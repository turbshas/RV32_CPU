FILE_LIST:=\
	decode/decode.sv \
	../common/branch_compare/branch_compare.sv \
	../common/csr/csr.sv \
	../common/decode/decode_branch_compare.sv \
	../common/decode/decode_csr.sv \
	../common/decode/decode_exec_unit.sv \
	../common/decode/decode_imm_gen.sv \
	../common/decode/decode_mem.sv \
	../common/decode/decode_pc_input_select.sv \
	../common/decode/decode_reg_file.sv \
	../common/decode/deocde_write_back.sv \
	../common/exec_unit/exec_unit.sv \
	../common/fetch/fetch.v \
	../common/imm_gen/imm_gen.sv \
	../common/mem/mem.sv \
	../common/reg_file/reg_file.sv \
	../common/write_back/write_back.sv \
	core.sv

INCLUDE_DIRS:=\
	-I. \
	-I../common/branch_compare \
	-I../common/csr \
	-I../common/exec_unit \
	-I../common/fence \
	-I../common/fetch \
	-I../common/imm_gen \
	-I../common/mem \
	-I../common/reg_file \
	-I../common/write_back

OUTPUT_NAME:=core
TOPMODULE:=core

include ../Makefile

