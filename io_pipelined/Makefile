FILE_LIST:=\
	decode/decode_D.v \
	decode/decode_X.v \
	decode/decode_M.v \
	decode/decode_W.v \
	../common/mem/mem.v \
	../common/fetch/fetch.v \
	../common/imm_gen/imm_gen.v \
	../common/reg_file/reg_file.v \
	../common/branch_compare/branch_compare.v \
	../common/exec_unit/exec_unit.v \
	../common/write_back/write_back.v \
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

