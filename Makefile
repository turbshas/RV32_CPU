# Requires the following packages:
# sudo apt install iverilog verilator yosys gtkwave npm
# npm install -g netlistsvg
default: build_verilator

# Targets for building and simulating through iverilog
SIMFILE:=$(OUTPUT_NAME).vvp
TRACEFILE:=$(OUTPUT_NAME).vcd

$(SIMFILE): $(FILE_LIST)
	iverilog -g2005 -s -u $(TOPMODULE) -DDUMPFILE=\"$(TRACEFILE)\" -o $(SIMFILE) $^

$(TRACEFILE): $(SIMFILE)
	./$<

sim: $(TRACEFILE)
	gtkwave $<

# Targets for building and simulating through verilator
ifndef $(TEST_FILE)
TEST_FILE:=test.x
endif

VERILATOR_NAME:=V$(TOPMODULE)
HEADER_NAME:=$(VERILATOR_NAME).h
VTRACEFILE:=$(VERILATOR_NAME).vcd
TB_NAME:=$(OUTPUT_NAME)_tb.cpp

obj_dir/$(VERILATOR_NAME): $(TB_NAME) $(FILE_LIST)
	verilator --trace -sv --top-module $(TOPMODULE) --cc $(FILE_LIST) $(INCLUDE_DIRS) --exe $<
	@echo "#define VERILATOR_NAME $(VERILATOR_NAME)" > obj_dir/$(TB_NAME)
	@echo "#define HEADER_NAME \"$(HEADER_NAME)\"" >> obj_dir/$(TB_NAME)
	@cat $(TB_NAME) >> obj_dir/$(TB_NAME)
	@make -j -C obj_dir -f $(VERILATOR_NAME).mk $(VERILATOR_NAME) > /dev/null

$(VTRACEFILE): obj_dir/$(VERILATOR_NAME)
	obj_dir/$(VERILATOR_NAME) $(TEST_FILE) $(VTRACEFILE)

build_verilator: obj_dir/$(VERILATOR_NAME)

sim_verilator: $(VTRACEFILE)
	gtkwave $(VTRACEFILE)

# Targets for running tests

# These two variables are used to find the location of the benchmarks
MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

# Directories where tests are contained
TEST_DIR := $(MKFILE_DIR)/benchmarks
INSTR_TEST_DIR := $(TEST_DIR)/individual_instructions
INSTR_TEST_DIRS := $(wildcard $(INSTR_TEST_DIR)/*/.)
SIMPLE_PROGRAM_DIR := $(TEST_DIR)/simple_programs

# Test files in those directories
INSTR_TEST_FILES:=$(foreach d, $(INSTR_TEST_DIRS), $(wildcard $(d)/*.x))
SIMPLE_PROGRAM_FILES:=$(wildcard $(SIMPLE_PROGRAM_DIR)/*.x)

# Files output from testing (.out = console output, .vcd = trace file)
INSTR_TESTS_OUT := $(patsubst $(TEST_DIR)/%.x, test_output/%.out, $(INSTR_TEST_FILES))
SIMPLE_PROGRAMS_OUT := $(patsubst $(TEST_DIR)/%.x, test_output/%.out, $(SIMPLE_PROGRAM_FILES))
INSTR_TESTS_VCD := $(patsubst $(TEST_DIR)/%.x, vcd_output/%.vcd, $(INSTR_TEST_FILES))
SIMPLE_PROGRAMS_VCD := $(patsubst $(TEST_DIR)/%.x, vcd_output/%.vcd, $(SIMPLE_PROGRAM_FILES))

test_output/%.out: $(TEST_DIR)/%.x obj_dir/$(VERILATOR_NAME)
	@mkdir $(notdir $@)
	obj_dir/$(VERILATOR_NAME) $< vcd_output/$*.vcd > test_output/$*.out

vcd_output/%.vcd: $(TEST_DIR)/%.x
	@mkdir $(notdir $@)
	obj_dir/$(VERILATOR_NAME) $< vcd_output/$*.vcd > test_output/$*.out

test: $(INSTR_TESTS_OUT) $(SIMPLE_PROGRAMS_OUT)

test_instr: $(INSTR_TESTS_OUT)

test_simple: $(SIMPLE_PROGRAMS_OUT)

# Targets for viewing RTL of the code
$(OUTPUT_NAME).json: $(FILE_LIST)
	yosys -p "read_verilog $(INCLUDE_DIRS) -DBUILDING_RTL $< ; prep -top $(TOPMODULE) -flatten; write_json $@" 1>/dev/null

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
	@rm -rf tests
	@rm -rf test_output
	@rm -rf vcd_output

FORCE: ;

.PHONY: default sim clean build_verilator sim_verilator rtl FORCE

