ASM_mi=$(wildcard rv32mi/*.S)
ASM_si=$(wildcard rv32si/*.S)
#ASM_ua=$(wildcard rv32ua/*.S)
#ASM_uc=$(wildcard rv32uc/*.S)
#ASM_ud=$(wildcard rv32ud/*.S)
#ASM_uf=$(wildcard rv32uf/*.S)
ASM_ui=$(wildcard rv32ui/*.S)
#ASM_um=$(wildcard rv32um/*.S)
ASM=$(ASM_mi) $(ASM_si) $(ASM_ua) $(ASM_uc) $(ASM_ud) $(ASM_uf) $(ASM_ui) $(ASM_um)
ELFS=$(ASM:.S=.elf)
DMP=$(ASM:.S=.d)
RAW=$(ASM:.S=.raw)
BIN=$(ASM:.S=.bin)
X=$(ASM:.S=.x)

CC = riscv32-unknown-elf-gcc
OBJDUMP = riscv32-unknown-elf-objdump 
OBJCOPY = riscv32-unknown-elf-objcopy

CFLAGS = -static -nostdlib -O0 -fno-delayed-branch -fomit-frame-pointer -nostartfiles -I. -I..#-Ttext=0x10000000
CORE = -march=rv32gc

LINKERFILE= -T ece429.ld

all: $(ELFS) $(DMP) $(BIN) $(RAW) $(X)

%.elf: %.S
	@echo "ELF-ing $^"
	$(CC) $(CORE) $(CFLAGS) -o $@ $^ $(LINKERFILE)

%.d: %.elf
	$(OBJDUMP) -D --disassembler-options=no-aliases,numeric $^ > $@

%.bin: %.elf
	$(OBJCOPY) -O binary $^ $@

%.raw: %.bin
	od -Ax -tx $^ > $@

%.x: %.raw
	./mk-bin.py $^ > $@

clean:
	rm -f $(ELFS) $(DMP) $(RAW) $(BIN) $(X)

rebuild: | clean all

