SOURCES= $(wildcard *.c)
ELFS=$(SOURCES:.c=.elf)
ASM=$(SOURCES:.c=.s)
DMP=$(SOURCES:.c=.d)
RAW=$(SOURCES:.c=.raw)
BIN=$(SOURCES:.c=.bin)
X=$(SOURCES:.c=.x)

CC = riscv32-unknown-elf-gcc
OBJDUMP = riscv32-unknown-elf-objdump 
OBJCOPY = riscv32-unknown-elf-objcopy

CFLAGS = -static -nostdlib -O0 -fno-delayed-branch -fomit-frame-pointer -nostartfiles #-Ttext=0x10000000
CORE = -march=rv32gc

LINKERFILE= -T ece429.ld

all: $(ELFS) $(ASM) $(DMP) $(BIN) $(RAW) $(X)

%.elf: %.c
	@echo "ELF-ing $^"
	$(CC) $(CORE) $(CFLAGS) -o $@ $^ $(LINKERFILE)

%.s: %.c
	@echo "S-ing $^"
	$(CC) $(CORE) $(CFLAGS) -S $^ $(LINKERFILE)

%.d: %.elf
	$(OBJDUMP) -D --disassembler-options=no-aliases,numeric $^ > $@

%.bin: %.elf
	$(OBJCOPY) -O binary $^ $@

%.raw: %.bin
	od -Ax -tx $^ > $@

%.x: %.raw
	./mk-bin.py $^ > $@

clean:
	rm -f *.o core *.elf *.bin *.raw *.x  *.d *.s 

rebuild: clean build
