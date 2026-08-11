FILE_LIST:=\
	decode/decode_D.sv \
	decode/decode_X.sv \
	decode/decode_M.sv \
	decode/decode_W.sv \
	../common/mem/mem.sv \
	../common/fetch/fetch.sv \
	../common/imm_gen/imm_gen.sv \
	../common/reg_file/reg_file.sv \
	../common/branch_compare/branch_compare.sv \
	../common/exec_unit/exec_unit.sv \
	../common/write_back/write_back.sv \
	core.sv

INCLUDE_DIRS:=\
	-I. \
	-I../common/ \
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

