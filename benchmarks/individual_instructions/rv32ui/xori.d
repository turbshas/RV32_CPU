
rv32ui/xori.elf:     file format elf32-littleriscv


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
 10000b0:	ff000297          	auipc	x5,0xff000
 10000b4:	f5028293          	addi	x5,x5,-176 # 0 <_start-0x1000000>
 10000b8:	00028e63          	beq	x5,x0,10000d4 <reset_vector+0x94>
 10000bc:	10529073          	csrrw	x0,stvec,x5
 10000c0:	0000b2b7          	lui	x5,0xb
 10000c4:	10928293          	addi	x5,x5,265 # b109 <_start-0xff4ef7>
 10000c8:	30229073          	csrrw	x0,medeleg,x5
 10000cc:	30202373          	csrrs	x6,medeleg,x0
 10000d0:	f66291e3          	bne	x5,x6,1000032 <handle_exception>
 10000d4:	30005073          	csrrwi	x0,mstatus,0
 10000d8:	00000297          	auipc	x5,0x0
 10000dc:	01428293          	addi	x5,x5,20 # 10000ec <test_2>
 10000e0:	34129073          	csrrw	x0,mepc,x5
 10000e4:	f1402573          	csrrs	x10,mhartid,x0
 10000e8:	30200073          	mret

010000ec <test_2>:
 10000ec:	00ff10b7          	lui	x1,0xff1
 10000f0:	f0008093          	addi	x1,x1,-256 # ff0f00 <_start-0xf100>
 10000f4:	f0f0c713          	xori	x14,x1,-241
 10000f8:	ff00feb7          	lui	x29,0xff00f
 10000fc:	00fe8e93          	addi	x29,x29,15 # ff00f00f <_end+0xfe00d00f>
 1000100:	4189                	c.li	x3,2
 1000102:	19d71163          	bne	x14,x29,1000284 <fail>

01000106 <test_3>:
 1000106:	0ff010b7          	lui	x1,0xff01
 100010a:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100010e:	0f00c713          	xori	x14,x1,240
 1000112:	0ff01eb7          	lui	x29,0xff01
 1000116:	f00e8e93          	addi	x29,x29,-256 # ff00f00 <_end+0xeefef00>
 100011a:	418d                	c.li	x3,3
 100011c:	17d71463          	bne	x14,x29,1000284 <fail>

01000120 <test_4>:
 1000120:	00ff10b7          	lui	x1,0xff1
 1000124:	8ff08093          	addi	x1,x1,-1793 # ff08ff <_start-0xf701>
 1000128:	70f0c713          	xori	x14,x1,1807
 100012c:	00ff1eb7          	lui	x29,0xff1
 1000130:	ff0e8e93          	addi	x29,x29,-16 # ff0ff0 <_start-0xf010>
 1000134:	4191                	c.li	x3,4
 1000136:	15d71763          	bne	x14,x29,1000284 <fail>

0100013a <test_5>:
 100013a:	f00ff0b7          	lui	x1,0xf00ff
 100013e:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 1000142:	0f00c713          	xori	x14,x1,240
 1000146:	f00ffeb7          	lui	x29,0xf00ff
 100014a:	0ffe8e93          	addi	x29,x29,255 # f00ff0ff <_end+0xef0fd0ff>
 100014e:	4195                	c.li	x3,5
 1000150:	13d71a63          	bne	x14,x29,1000284 <fail>

01000154 <test_6>:
 1000154:	ff00f0b7          	lui	x1,0xff00f
 1000158:	70008093          	addi	x1,x1,1792 # ff00f700 <_end+0xfe00d700>
 100015c:	70f0c093          	xori	x1,x1,1807
 1000160:	ff00feb7          	lui	x29,0xff00f
 1000164:	00fe8e93          	addi	x29,x29,15 # ff00f00f <_end+0xfe00d00f>
 1000168:	4199                	c.li	x3,6
 100016a:	11d09d63          	bne	x1,x29,1000284 <fail>

0100016e <test_7>:
 100016e:	4201                	c.li	x4,0
 1000170:	0ff010b7          	lui	x1,0xff01
 1000174:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000178:	0f00c713          	xori	x14,x1,240
 100017c:	00070313          	addi	x6,x14,0
 1000180:	0205                	c.addi	x4,1
 1000182:	4289                	c.li	x5,2
 1000184:	fe5216e3          	bne	x4,x5,1000170 <test_7+0x2>
 1000188:	0ff01eb7          	lui	x29,0xff01
 100018c:	f00e8e93          	addi	x29,x29,-256 # ff00f00 <_end+0xeefef00>
 1000190:	419d                	c.li	x3,7
 1000192:	0fd31963          	bne	x6,x29,1000284 <fail>

01000196 <test_8>:
 1000196:	4201                	c.li	x4,0
 1000198:	00ff10b7          	lui	x1,0xff1
 100019c:	8ff08093          	addi	x1,x1,-1793 # ff08ff <_start-0xf701>
 10001a0:	70f0c713          	xori	x14,x1,1807
 10001a4:	0001                	c.addi	x0,0
 10001a6:	00070313          	addi	x6,x14,0
 10001aa:	0205                	c.addi	x4,1
 10001ac:	4289                	c.li	x5,2
 10001ae:	fe5215e3          	bne	x4,x5,1000198 <test_8+0x2>
 10001b2:	00ff1eb7          	lui	x29,0xff1
 10001b6:	ff0e8e93          	addi	x29,x29,-16 # ff0ff0 <_start-0xf010>
 10001ba:	41a1                	c.li	x3,8
 10001bc:	0dd31463          	bne	x6,x29,1000284 <fail>

010001c0 <test_9>:
 10001c0:	4201                	c.li	x4,0
 10001c2:	f00ff0b7          	lui	x1,0xf00ff
 10001c6:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 10001ca:	0f00c713          	xori	x14,x1,240
 10001ce:	0001                	c.addi	x0,0
 10001d0:	0001                	c.addi	x0,0
 10001d2:	00070313          	addi	x6,x14,0
 10001d6:	0205                	c.addi	x4,1
 10001d8:	4289                	c.li	x5,2
 10001da:	fe5214e3          	bne	x4,x5,10001c2 <test_9+0x2>
 10001de:	f00ffeb7          	lui	x29,0xf00ff
 10001e2:	0ffe8e93          	addi	x29,x29,255 # f00ff0ff <_end+0xef0fd0ff>
 10001e6:	41a5                	c.li	x3,9
 10001e8:	09d31e63          	bne	x6,x29,1000284 <fail>

010001ec <test_10>:
 10001ec:	4201                	c.li	x4,0
 10001ee:	0ff010b7          	lui	x1,0xff01
 10001f2:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 10001f6:	0f00c713          	xori	x14,x1,240
 10001fa:	0205                	c.addi	x4,1
 10001fc:	4289                	c.li	x5,2
 10001fe:	fe5218e3          	bne	x4,x5,10001ee <test_10+0x2>
 1000202:	0ff01eb7          	lui	x29,0xff01
 1000206:	f00e8e93          	addi	x29,x29,-256 # ff00f00 <_end+0xeefef00>
 100020a:	41a9                	c.li	x3,10
 100020c:	07d71c63          	bne	x14,x29,1000284 <fail>

01000210 <test_11>:
 1000210:	4201                	c.li	x4,0
 1000212:	00ff10b7          	lui	x1,0xff1
 1000216:	fff08093          	addi	x1,x1,-1 # ff0fff <_start-0xf001>
 100021a:	0001                	c.addi	x0,0
 100021c:	00f0c713          	xori	x14,x1,15
 1000220:	0205                	c.addi	x4,1
 1000222:	4289                	c.li	x5,2
 1000224:	fe5217e3          	bne	x4,x5,1000212 <test_11+0x2>
 1000228:	00ff1eb7          	lui	x29,0xff1
 100022c:	ff0e8e93          	addi	x29,x29,-16 # ff0ff0 <_start-0xf010>
 1000230:	41ad                	c.li	x3,11
 1000232:	05d71963          	bne	x14,x29,1000284 <fail>

01000236 <test_12>:
 1000236:	4201                	c.li	x4,0
 1000238:	f00ff0b7          	lui	x1,0xf00ff
 100023c:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 1000240:	0001                	c.addi	x0,0
 1000242:	0001                	c.addi	x0,0
 1000244:	0f00c713          	xori	x14,x1,240
 1000248:	0205                	c.addi	x4,1
 100024a:	4289                	c.li	x5,2
 100024c:	fe5216e3          	bne	x4,x5,1000238 <test_12+0x2>
 1000250:	f00ffeb7          	lui	x29,0xf00ff
 1000254:	0ffe8e93          	addi	x29,x29,255 # f00ff0ff <_end+0xef0fd0ff>
 1000258:	41b1                	c.li	x3,12
 100025a:	03d71563          	bne	x14,x29,1000284 <fail>

0100025e <test_13>:
 100025e:	0f004093          	xori	x1,x0,240
 1000262:	0f000e93          	addi	x29,x0,240
 1000266:	41b5                	c.li	x3,13
 1000268:	01d09e63          	bne	x1,x29,1000284 <fail>

0100026c <test_14>:
 100026c:	00ff00b7          	lui	x1,0xff0
 1000270:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000274:	70f0c013          	xori	x0,x1,1807
 1000278:	4e81                	c.li	x29,0
 100027a:	41b9                	c.li	x3,14
 100027c:	01d01463          	bne	x0,x29,1000284 <fail>
 1000280:	00301b63          	bne	x0,x3,1000296 <pass>

01000284 <fail>:
 1000284:	0ff0000f          	fence	iorw,iorw
 1000288:	00018063          	beq	x3,x0,1000288 <fail+0x4>
 100028c:	0186                	c.slli	x3,0x1
 100028e:	0011e193          	ori	x3,x3,1
 1000292:	00000073          	ecall

01000296 <pass>:
 1000296:	0ff0000f          	fence	iorw,iorw
 100029a:	4185                	c.li	x3,1
 100029c:	00000073          	ecall
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
