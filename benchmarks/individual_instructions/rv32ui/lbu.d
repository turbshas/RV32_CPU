
rv32ui/lbu.elf:     file format elf32-littleriscv


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
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfef>
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
 10000ec:	00002097          	auipc	x1,0x2
 10000f0:	f1408093          	addi	x1,x1,-236 # 1002000 <begin_signature>
 10000f4:	0000c703          	lbu	x14,0(x1)
 10000f8:	0ff00e93          	addi	x29,x0,255
 10000fc:	4189                	c.li	x3,2
 10000fe:	1dd71363          	bne	x14,x29,10002c4 <fail>

01000102 <test_3>:
 1000102:	00002097          	auipc	x1,0x2
 1000106:	efe08093          	addi	x1,x1,-258 # 1002000 <begin_signature>
 100010a:	0010c703          	lbu	x14,1(x1)
 100010e:	4e81                	c.li	x29,0
 1000110:	418d                	c.li	x3,3
 1000112:	1bd71963          	bne	x14,x29,10002c4 <fail>

01000116 <test_4>:
 1000116:	00002097          	auipc	x1,0x2
 100011a:	eea08093          	addi	x1,x1,-278 # 1002000 <begin_signature>
 100011e:	0020c703          	lbu	x14,2(x1)
 1000122:	0f000e93          	addi	x29,x0,240
 1000126:	4191                	c.li	x3,4
 1000128:	19d71e63          	bne	x14,x29,10002c4 <fail>

0100012c <test_5>:
 100012c:	00002097          	auipc	x1,0x2
 1000130:	ed408093          	addi	x1,x1,-300 # 1002000 <begin_signature>
 1000134:	0030c703          	lbu	x14,3(x1)
 1000138:	4ebd                	c.li	x29,15
 100013a:	4195                	c.li	x3,5
 100013c:	19d71463          	bne	x14,x29,10002c4 <fail>

01000140 <test_6>:
 1000140:	00002097          	auipc	x1,0x2
 1000144:	ec308093          	addi	x1,x1,-317 # 1002003 <tdat4>
 1000148:	ffd0c703          	lbu	x14,-3(x1)
 100014c:	0ff00e93          	addi	x29,x0,255
 1000150:	4199                	c.li	x3,6
 1000152:	17d71963          	bne	x14,x29,10002c4 <fail>

01000156 <test_7>:
 1000156:	00002097          	auipc	x1,0x2
 100015a:	ead08093          	addi	x1,x1,-339 # 1002003 <tdat4>
 100015e:	ffe0c703          	lbu	x14,-2(x1)
 1000162:	4e81                	c.li	x29,0
 1000164:	419d                	c.li	x3,7
 1000166:	15d71f63          	bne	x14,x29,10002c4 <fail>

0100016a <test_8>:
 100016a:	00002097          	auipc	x1,0x2
 100016e:	e9908093          	addi	x1,x1,-359 # 1002003 <tdat4>
 1000172:	fff0c703          	lbu	x14,-1(x1)
 1000176:	0f000e93          	addi	x29,x0,240
 100017a:	41a1                	c.li	x3,8
 100017c:	15d71463          	bne	x14,x29,10002c4 <fail>

01000180 <test_9>:
 1000180:	00002097          	auipc	x1,0x2
 1000184:	e8308093          	addi	x1,x1,-381 # 1002003 <tdat4>
 1000188:	0000c703          	lbu	x14,0(x1)
 100018c:	4ebd                	c.li	x29,15
 100018e:	41a5                	c.li	x3,9
 1000190:	13d71a63          	bne	x14,x29,10002c4 <fail>

01000194 <test_10>:
 1000194:	00002097          	auipc	x1,0x2
 1000198:	e6c08093          	addi	x1,x1,-404 # 1002000 <begin_signature>
 100019c:	1081                	c.addi	x1,-32
 100019e:	0200c283          	lbu	x5,32(x1)
 10001a2:	0ff00e93          	addi	x29,x0,255
 10001a6:	41a9                	c.li	x3,10
 10001a8:	11d29e63          	bne	x5,x29,10002c4 <fail>

010001ac <test_11>:
 10001ac:	00002097          	auipc	x1,0x2
 10001b0:	e5408093          	addi	x1,x1,-428 # 1002000 <begin_signature>
 10001b4:	10e9                	c.addi	x1,-6
 10001b6:	0070c283          	lbu	x5,7(x1)
 10001ba:	4e81                	c.li	x29,0
 10001bc:	41ad                	c.li	x3,11
 10001be:	11d29363          	bne	x5,x29,10002c4 <fail>

010001c2 <test_12>:
 10001c2:	41b1                	c.li	x3,12
 10001c4:	4201                	c.li	x4,0
 10001c6:	00002097          	auipc	x1,0x2
 10001ca:	e3b08093          	addi	x1,x1,-453 # 1002001 <tdat2>
 10001ce:	0010c703          	lbu	x14,1(x1)
 10001d2:	00070313          	addi	x6,x14,0
 10001d6:	0f000e93          	addi	x29,x0,240
 10001da:	0fd31563          	bne	x6,x29,10002c4 <fail>
 10001de:	0205                	c.addi	x4,1
 10001e0:	4289                	c.li	x5,2
 10001e2:	fe5212e3          	bne	x4,x5,10001c6 <test_12+0x4>

010001e6 <test_13>:
 10001e6:	41b5                	c.li	x3,13
 10001e8:	4201                	c.li	x4,0
 10001ea:	00002097          	auipc	x1,0x2
 10001ee:	e1808093          	addi	x1,x1,-488 # 1002002 <tdat3>
 10001f2:	0010c703          	lbu	x14,1(x1)
 10001f6:	0001                	c.addi	x0,0
 10001f8:	00070313          	addi	x6,x14,0
 10001fc:	4ebd                	c.li	x29,15
 10001fe:	0dd31363          	bne	x6,x29,10002c4 <fail>
 1000202:	0205                	c.addi	x4,1
 1000204:	4289                	c.li	x5,2
 1000206:	fe5212e3          	bne	x4,x5,10001ea <test_13+0x4>

0100020a <test_14>:
 100020a:	41b9                	c.li	x3,14
 100020c:	4201                	c.li	x4,0
 100020e:	00002097          	auipc	x1,0x2
 1000212:	df208093          	addi	x1,x1,-526 # 1002000 <begin_signature>
 1000216:	0010c703          	lbu	x14,1(x1)
 100021a:	0001                	c.addi	x0,0
 100021c:	0001                	c.addi	x0,0
 100021e:	00070313          	addi	x6,x14,0
 1000222:	4e81                	c.li	x29,0
 1000224:	0bd31063          	bne	x6,x29,10002c4 <fail>
 1000228:	0205                	c.addi	x4,1
 100022a:	4289                	c.li	x5,2
 100022c:	fe5211e3          	bne	x4,x5,100020e <test_14+0x4>

01000230 <test_15>:
 1000230:	41bd                	c.li	x3,15
 1000232:	4201                	c.li	x4,0
 1000234:	00002097          	auipc	x1,0x2
 1000238:	dcd08093          	addi	x1,x1,-563 # 1002001 <tdat2>
 100023c:	0010c703          	lbu	x14,1(x1)
 1000240:	0f000e93          	addi	x29,x0,240
 1000244:	09d71063          	bne	x14,x29,10002c4 <fail>
 1000248:	0205                	c.addi	x4,1
 100024a:	4289                	c.li	x5,2
 100024c:	fe5214e3          	bne	x4,x5,1000234 <test_15+0x4>

01000250 <test_16>:
 1000250:	41c1                	c.li	x3,16
 1000252:	4201                	c.li	x4,0
 1000254:	00002097          	auipc	x1,0x2
 1000258:	dae08093          	addi	x1,x1,-594 # 1002002 <tdat3>
 100025c:	0001                	c.addi	x0,0
 100025e:	0010c703          	lbu	x14,1(x1)
 1000262:	4ebd                	c.li	x29,15
 1000264:	07d71063          	bne	x14,x29,10002c4 <fail>
 1000268:	0205                	c.addi	x4,1
 100026a:	4289                	c.li	x5,2
 100026c:	fe5214e3          	bne	x4,x5,1000254 <test_16+0x4>

01000270 <test_17>:
 1000270:	41c5                	c.li	x3,17
 1000272:	4201                	c.li	x4,0
 1000274:	00002097          	auipc	x1,0x2
 1000278:	d8c08093          	addi	x1,x1,-628 # 1002000 <begin_signature>
 100027c:	0001                	c.addi	x0,0
 100027e:	0001                	c.addi	x0,0
 1000280:	0010c703          	lbu	x14,1(x1)
 1000284:	4e81                	c.li	x29,0
 1000286:	03d71f63          	bne	x14,x29,10002c4 <fail>
 100028a:	0205                	c.addi	x4,1
 100028c:	4289                	c.li	x5,2
 100028e:	fe5213e3          	bne	x4,x5,1000274 <test_17+0x4>

01000292 <test_18>:
 1000292:	00002297          	auipc	x5,0x2
 1000296:	d6e28293          	addi	x5,x5,-658 # 1002000 <begin_signature>
 100029a:	0002c103          	lbu	x2,0(x5)
 100029e:	4109                	c.li	x2,2
 10002a0:	4e89                	c.li	x29,2
 10002a2:	41c9                	c.li	x3,18
 10002a4:	03d11063          	bne	x2,x29,10002c4 <fail>

010002a8 <test_19>:
 10002a8:	00002297          	auipc	x5,0x2
 10002ac:	d5828293          	addi	x5,x5,-680 # 1002000 <begin_signature>
 10002b0:	0002c103          	lbu	x2,0(x5)
 10002b4:	0001                	c.addi	x0,0
 10002b6:	4109                	c.li	x2,2
 10002b8:	4e89                	c.li	x29,2
 10002ba:	41cd                	c.li	x3,19
 10002bc:	01d11463          	bne	x2,x29,10002c4 <fail>
 10002c0:	00301b63          	bne	x0,x3,10002d6 <pass>

010002c4 <fail>:
 10002c4:	0ff0000f          	fence	iorw,iorw
 10002c8:	00018063          	beq	x3,x0,10002c8 <fail+0x4>
 10002cc:	0186                	c.slli	x3,0x1
 10002ce:	0011e193          	ori	x3,x3,1
 10002d2:	00000073          	ecall

010002d6 <pass>:
 10002d6:	0ff0000f          	fence	iorw,iorw
 10002da:	4185                	c.li	x3,1
 10002dc:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	                	0xff

01002001 <tdat2>:
	...

01002002 <tdat3>:
 1002002:	                	c.addi4spn	x12,x2,988

01002003 <tdat4>:
 1002003:	0000000f          	fence	unknown,unknown
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd970>
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
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd9b4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...
