# Requires the following packages:
# sudo apt install iverilog verilator yosys gtkwave npm
# npm install -g netlistsvg
default: build_verilator

# Targets for building and simulating through iverilog
SIMFILE:=$(OUTPUT_NAME).vvp
TRACEFILE:=$(OUTPUT_NAME).vcd

$(SIMFILE): $(FILE_LIST)
	iverilog -g2005 -s $(TOPMODULE) -DDUMPFILE=\"$(TRACEFILE)\" -o $(SIMFILE) $^

$(TRACEFILE): $(SIMFILE)
	./$<

sim: $(TRACEFILE)
	gtkwave $<

# Targets for building and simulating through verilator
ifndef $(TEST_FILE)
TEST_FILE:=SumArray.x
endif
TEST_LENGTH:=$(shell test -e $(TEST_FILE) && cat $(TEST_FILE) | wc -l)

VERILATOR_NAME:=V$(TOPMODULE)
HEADER_NAME:=$(VERILATOR_NAME).h
VTRACEFILE:=$(VERILATOR_NAME).vcd
TB_NAME:=$(OUTPUT_NAME)_tb.cpp

obj_dir/$(VERILATOR_NAME): $(TB_NAME) $(TEST_FILE) $(FILE_LIST)
	verilator --trace -sv --top-module $(TOPMODULE) -DTEST_FILE=\"$(TEST_FILE)\" --cc $(FILE_LIST) $(INCLUDE_DIRS) --exe $<
	@echo "#define VERILATOR_NAME $(VERILATOR_NAME)" > obj_dir/$(TB_NAME)
	@echo "#define HEADER_NAME \"$(HEADER_NAME)\"" >> obj_dir/$(TB_NAME)
	@echo "#define TRACEFILE \"$(VTRACEFILE)\"" >> obj_dir/$(TB_NAME)
	@echo "#define TEST_LENGTH $(TEST_LENGTH)" >> obj_dir/$(TB_NAME)
	@cat $(TB_NAME) >> obj_dir/$(TB_NAME)
	@make -j -C obj_dir -f $(VERILATOR_NAME).mk $(VERILATOR_NAME) > /dev/null

$(VTRACEFILE): obj_dir/$(VERILATOR_NAME)
	obj_dir/$(VERILATOR_NAME)

build_verilator: obj_dir/$(VERILATOR_NAME)

sim_verilator: $(VTRACEFILE)
	gtkwave $(VTRACEFILE)

# Targets for running tests

# These two variables are used to find the location of the benchmarks
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

#INSTR_TEST_FILES:=$(MKFILE_DIR)/benchmarks/individual_instructions/*.x
#SIMPLE_PROGRAM_FILES:=$(MKFILE_DIR)/benchmarks/simple_programs/*.x
#INSTR_TESTS:=$(foreach test, $(shell ls $(INSTR_TEST_FILES)), \
	test_output/instr_$(basename $(notdir $(test))).out)
#SIMPLE_PROGRAMS:=$(foreach program, \
	$(filter-out fact.x, $(shell ls $(SIMPLE_PROGRAM_FILES))), \
	test_output/program_$(basename $(notdir $(program))).out)

instr_%.x:
	@cp $(MKFILE_DIR)/benchmarks/individual_instructions/$(notdir $*).x ./$(notdir $@)

program_%.x:
	@cp $(MKFILE_DIR)/benchmarks/simple_programs/$(notdir $*).x ./$(notdir $@)

%.out: $(notdir %.x)
	@make build_verilator TEST_FILE=$(notdir $<)
	obj_dir/$(VERILATOR_NAME) > test_output/$(notdir $*).out
	cp $(VTRACEFILE) vcd_output/$(notdir $*).vcd

test_output:
	@mkdir test_output

vcd_output:
	@mkdir vcd_output

test: $(FILE_LIST) | test_output vcd_output $(INSTR_TESTS) $(SIMPLE_PROGRAMS)

test_instr: $(FILE_LIST) | test_output vcd_output $(INSTR_TESTS)

test_simple: $(FILE_LIST) | test_output vcd_output $(SIMPLE_PROGRAMS)

# Targets for viewing RTL of the code
$(OUTPUT_NAME).json: FORCE# $(FILE_LIST)
	yosys -p "read_verilog $(INCLUDE_DIRS) -DBUILDING_RTL $(FILE_LIST); prep -top $(TOPMODULE) -flatten; write_json $@" 1>/dev/null

$(OUTPUT_NAME).svg: $(OUTPUT_NAME).json
	netlistsvg $< -o $@

$(OUTPUT_NAME).png: $(OUTPUT_NAME).svg
	inkscape --export-png $@ --export-background="rgb(255, 255, 255)" --export-dpi 300 $< 2>&1 | grep -v "WARNING: unknown type: s:alias"

rtl: $(OUTPUT_NAME).png
	xdg-open $<

# Other targets
clean:
	@rm -f *.vvp
	@rm -f *.vcd
	@rm -rf obj_dir
	@rm -f *.json *.svg *.png
	@rm -f *.x
	@rm -rf test_output
	@rm -rf vcd_output

FORCE: ;

.PHONY: default sim clean build_verilator sim_verilator rtl FORCE

