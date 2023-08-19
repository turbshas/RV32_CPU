FILE_LIST:=\
	decode/decode.sv \
	../common/mem/mem.v \
	../common/fetch/fetch.v \
	../common/imm_gen/imm_gen.v \
	../common/reg_file/reg_file.v \
	../common/branch_compare/branch_compare.v \
	../common/exec_unit/exec_unit.sv \
	../common/exec_unit/exec_unit_interfaces.sv \
	../common/write_back/write_back.v \
	core.sv

INCLUDE_DIRS:=\
	-I. \
	-I../common/mem \
	-I../common/fetch \
	-I../common/imm_gen \
	-I../common/reg_file \
	-I../common/branch_compare \
	-I../common/exec_unit \
	-I../common/write_back

OUTPUT_NAME:=core
TOPMODULE:=core

include ../Makefile

