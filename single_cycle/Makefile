FILE_LIST:=\
	../PD1/mem.v \
	../PD2/fetch/fetch.v \
	../PD2/decode.v \
	../PD2/imm_gen/imm_gen.v \
	../PD3/reg_file/reg_file.v \
	../PD3/branch_compare/branch_compare.v \
	../PD3/exec_unit/exec_unit.v \
	dmem/dmem.v \
	write_back/write_back.v \
	core.v

INCLUDE_DIRS:=\
	-I../PD1 \
	-I../PD2 \
	-I../PD2/fetch \
	-I../PD2/imm_gen \
	-I../PD3/reg_file \
	-I../PD3/branch_compare \
	-I../PD3/exec_unit \
	-Idmem \
	-Iwrite_back

OUTPUT_NAME:=core
TOPMODULE:=core

include ../Makefile

