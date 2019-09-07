
rv32si/ma_fetch.elf:     file format elf32-littleriscv


Disassembly of section .text.init:

01000000 <_start>:
 1000000:	a081                	c.j	1000040 <reset_vector>
 1000002:	0001                	c.addi	x0,0

01000004 <trap_vector>:
 1000004:	34202f73          	csrrs	x30,mcause,x0
 1000008:	4fa1                	c.li	x31,8
 100000a:	03ff0663          	beq	x30,x31,1000036 <write_tohost>
 100000e:	4fa5                	c.li	x31,9
 1000010:	03ff0363          	beq	x30,x31,1000036 <write_tohost>
 1000014:	4fad                	c.li	x31,11
 1000016:	03ff0063          	beq	x30,x31,1000036 <write_tohost>
 100001a:	ff000f17          	auipc	x30,0xff000
 100001e:	fe6f0f13          	addi	x30,x30,-26 # 0 <_start-0x1000000>
 1000022:	000f0363          	beq	x30,x0,1000028 <trap_vector+0x24>
 1000026:	8f02                	c.jr	x30
 1000028:	34202f73          	csrrs	x30,mcause,x0
 100002c:	000f5363          	bge	x30,x0,1000032 <handle_exception>
 1000030:	a009                	c.j	1000032 <handle_exception>

01000032 <handle_exception>:
 1000032:	5391e193          	ori	x3,x3,1337

01000036 <write_tohost>:
 1000036:	00001f17          	auipc	x30,0x1
 100003a:	fc3f2523          	sw	x3,-54(x30) # 1001000 <tohost>
 100003e:	bfe5                	c.j	1000036 <write_tohost>

01000040 <reset_vector>:
 1000040:	f1402573          	csrrs	x10,mhartid,x0
 1000044:	e101                	c.bnez	x10,1000044 <reset_vector+0x4>
 1000046:	00000297          	auipc	x5,0x0
 100004a:	01228293          	addi	x5,x5,18 # 1000058 <reset_vector+0x18>
 100004e:	30529073          	csrrw	x0,mtvec,x5
 1000052:	18005073          	csrrwi	x0,satp,0
 1000056:	0001                	c.addi	x0,0
 1000058:	00000297          	auipc	x5,0x0
 100005c:	02028293          	addi	x5,x5,32 # 1000078 <reset_vector+0x38>
 1000060:	30529073          	csrrw	x0,mtvec,x5
 1000064:	800002b7          	lui	x5,0x80000
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfff>
 100006c:	3b029073          	csrrw	x0,pmpaddr0,x5
 1000070:	42fd                	c.li	x5,31
 1000072:	3a029073          	csrrw	x0,pmpcfg0,x5
 1000076:	0001                	c.addi	x0,0
 1000078:	00000297          	auipc	x5,0x0
 100007c:	01828293          	addi	x5,x5,24 # 1000090 <reset_vector+0x50>
 1000080:	30529073          	csrrw	x0,mtvec,x5
 1000084:	30205073          	csrrwi	x0,medeleg,0
 1000088:	30305073          	csrrwi	x0,mideleg,0
 100008c:	30405073          	csrrwi	x0,mie,0
 1000090:	4181                	c.li	x3,0
 1000092:	00000297          	auipc	x5,0x0
 1000096:	f7228293          	addi	x5,x5,-142 # 1000004 <trap_vector>
 100009a:	30529073          	csrrw	x0,mtvec,x5
 100009e:	4505                	c.li	x10,1
 10000a0:	057e                	c.slli	x10,0x1f
 10000a2:	00054763          	blt	x10,x0,10000b0 <reset_vector+0x70>
 10000a6:	0ff0000f          	fence	iorw,iorw
 10000aa:	4185                	c.li	x3,1
 10000ac:	00000073          	ecall
 10000b0:	00000297          	auipc	x5,0x0
 10000b4:	11428293          	addi	x5,x5,276 # 10001c4 <stvec_handler>
 10000b8:	00028e63          	beq	x5,x0,10000d4 <reset_vector+0x94>
 10000bc:	10529073          	csrrw	x0,stvec,x5
 10000c0:	0000b2b7          	lui	x5,0xb
 10000c4:	10928293          	addi	x5,x5,265 # b109 <_start-0xff4ef7>
 10000c8:	30229073          	csrrw	x0,medeleg,x5
 10000cc:	30202373          	csrrs	x6,medeleg,x0
 10000d0:	f66291e3          	bne	x5,x6,1000032 <handle_exception>
 10000d4:	30005073          	csrrwi	x0,mstatus,0
 10000d8:	00001537          	lui	x10,0x1
 10000dc:	80050513          	addi	x10,x10,-2048 # 800 <_start-0xfff800>
 10000e0:	30052073          	csrrs	x0,mstatus,x10
 10000e4:	02200513          	addi	x10,x0,34
 10000e8:	30352073          	csrrs	x0,mideleg,x10
 10000ec:	00000297          	auipc	x5,0x0
 10000f0:	01428293          	addi	x5,x5,20 # 1000100 <reset_vector+0xc0>
 10000f4:	34129073          	csrrw	x0,mepc,x5
 10000f8:	f1402573          	csrrs	x10,mhartid,x0
 10000fc:	30200073          	mret
 1000100:	00200193          	addi	x3,x0,2
 1000104:	00000313          	addi	x6,x0,0
 1000108:	00000297          	auipc	x5,0x0
 100010c:	00c28293          	addi	x5,x5,12 # 1000114 <reset_vector+0xd4>
 1000110:	00228367          	jalr	x6,2(x5)
 1000114:	a011                	c.j	1000118 <reset_vector+0xd8>
 1000116:	a019                	c.j	100011c <reset_vector+0xdc>
 1000118:	08c0006f          	jal	x0,10001a4 <fail>
 100011c:	00300193          	addi	x3,x0,3
 1000120:	00000297          	auipc	x5,0x0
 1000124:	00c28293          	addi	x5,x5,12 # 100012c <reset_vector+0xec>
 1000128:	00128367          	jalr	x6,1(x5)
 100012c:	0080006f          	jal	x0,1000134 <reset_vector+0xf4>
 1000130:	0740006f          	jal	x0,10001a4 <fail>
 1000134:	00400193          	addi	x3,x0,4
 1000138:	00000313          	addi	x6,x0,0
 100013c:	00000297          	auipc	x5,0x0
 1000140:	00c28293          	addi	x5,x5,12 # 1000148 <reset_vector+0x108>
 1000144:	00328367          	jalr	x6,3(x5)
 1000148:	a011                	c.j	100014c <reset_vector+0x10c>
 100014a:	a019                	c.j	1000150 <reset_vector+0x110>
 100014c:	0580006f          	jal	x0,10001a4 <fail>
 1000150:	00500193          	addi	x3,x0,5
 1000154:	00000313          	addi	x6,x0,0
 1000158:	00000297          	auipc	x5,0x0
 100015c:	00c28293          	addi	x5,x5,12 # 1000164 <reset_vector+0x124>
 1000160:	0060036f          	jal	x6,1000166 <reset_vector+0x126>
 1000164:	a011                	c.j	1000168 <reset_vector+0x128>
 1000166:	a019                	c.j	100016c <reset_vector+0x12c>
 1000168:	03c0006f          	jal	x0,10001a4 <fail>
 100016c:	00600193          	addi	x3,x0,6
 1000170:	00000313          	addi	x6,x0,0
 1000174:	00000297          	auipc	x5,0x0
 1000178:	00c28293          	addi	x5,x5,12 # 1000180 <reset_vector+0x140>
 100017c:	00000363          	beq	x0,x0,1000182 <reset_vector+0x142>
 1000180:	a011                	c.j	1000184 <reset_vector+0x144>
 1000182:	a019                	c.j	1000188 <reset_vector+0x148>
 1000184:	0200006f          	jal	x0,10001a4 <fail>
 1000188:	00700193          	addi	x3,x0,7
 100018c:	00001563          	bne	x0,x0,1000196 <reset_vector+0x156>
 1000190:	00c0006f          	jal	x0,100019c <reset_vector+0x15c>
 1000194:	a009                	c.j	1000196 <reset_vector+0x156>
 1000196:	a009                	c.j	1000198 <reset_vector+0x158>
 1000198:	00c0006f          	jal	x0,10001a4 <fail>
 100019c:	01c0006f          	jal	x0,10001b8 <pass>
 10001a0:	00301c63          	bne	x0,x3,10001b8 <pass>

010001a4 <fail>:
 10001a4:	0ff0000f          	fence	iorw,iorw
 10001a8:	00018063          	beq	x3,x0,10001a8 <fail+0x4>
 10001ac:	00119193          	slli	x3,x3,0x1
 10001b0:	0011e193          	ori	x3,x3,1
 10001b4:	00000073          	ecall

010001b8 <pass>:
 10001b8:	0ff0000f          	fence	iorw,iorw
 10001bc:	00100193          	addi	x3,x0,1
 10001c0:	00000073          	ecall

010001c4 <stvec_handler>:
 10001c4:	00200513          	addi	x10,x0,2
 10001c8:	02a18063          	beq	x3,x10,10001e8 <stvec_handler+0x24>
 10001cc:	00400513          	addi	x10,x0,4
 10001d0:	00a18c63          	beq	x3,x10,10001e8 <stvec_handler+0x24>
 10001d4:	00500513          	addi	x10,x0,5
 10001d8:	00a18863          	beq	x3,x10,10001e8 <stvec_handler+0x24>
 10001dc:	00600513          	addi	x10,x0,6
 10001e0:	00a18463          	beq	x3,x10,10001e8 <stvec_handler+0x24>
 10001e4:	fc1ff06f          	jal	x0,10001a4 <fail>
 10001e8:	fa031ee3          	bne	x6,x0,10001a4 <fail>
 10001ec:	00000593          	addi	x11,x0,0
 10001f0:	14202573          	csrrs	x10,scause,x0
 10001f4:	fab518e3          	bne	x10,x11,10001a4 <fail>
 10001f8:	141025f3          	csrrs	x11,sepc,x0
 10001fc:	00458593          	addi	x11,x11,4
 1000200:	fab292e3          	bne	x5,x11,10001a4 <fail>
 1000204:	14302573          	csrrs	x10,stval,x0
 1000208:	00050663          	beq	x10,x0,1000214 <stvec_handler+0x50>
 100020c:	ffe50513          	addi	x10,x10,-2
 1000210:	f8551ae3          	bne	x10,x5,10001a4 <fail>
 1000214:	00c58593          	addi	x11,x11,12
 1000218:	14159073          	csrrw	x0,sepc,x11
 100021c:	10200073          	sret
 1000220:	c0001073          	unimp
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd980>
   2:	0000                	c.unimp
   4:	7200                	c.flw	f8,32(x12)
   6:	7369                	c.lui	x6,0xffffa
   8:	01007663          	bgeu	x0,x16,14 <_start-0xffffec>
   c:	0028                	c.addi4spn	x10,x2,8
   e:	0000                	c.unimp
  10:	7205                	c.lui	x4,0xfffe1
  12:	3376                	c.fldsp	f6,376(x2)
  14:	6932                	c.flwsp	f18,12(x2)
  16:	7032                	c.flwsp	f0,44(x2)
  18:	5f30                	c.lw	x12,120(x14)
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd9c4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...
