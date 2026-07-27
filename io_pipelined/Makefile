FILE_LIST:=\
	decode/decode_D.v \
	decode/decode_X.v \
	decode/decode_M.v \
	decode/decode_W.v \
	../common/mem/mem.sv \
	../common/fetch/fetch.sv \
	../common/imm_gen/imm_gen.sv \
	../common/reg_file/reg_file.sv \
	../common/branch_compare/branch_compare.sv \
	../common/exec_unit/exec_unit.sv \
	../common/write_back/write_back.sv \
	core.v

INCLUDE_DIRS:=\
	-I. \
	-I../common/mem \
	-I../common/fetch \
	-I../common/decode \
	-I../common/imm_gen \
	-I../common/reg_file \
	-I../common/branch_compare \
	-I../common/exec_unit \
	-I../common/write_back

OUTPUT_NAME:=core
TOPMODULE:=core

include ../Makefile

