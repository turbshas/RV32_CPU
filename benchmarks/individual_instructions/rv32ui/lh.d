
rv32ui/lh.elf:     file format elf32-littleriscv


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
 10000f4:	00009703          	lh	x14,0(x1)
 10000f8:	0ff00e93          	addi	x29,x0,255
 10000fc:	4189                	c.li	x3,2
 10000fe:	1fd71c63          	bne	x14,x29,10002f6 <fail>

01000102 <test_3>:
 1000102:	00002097          	auipc	x1,0x2
 1000106:	efe08093          	addi	x1,x1,-258 # 1002000 <begin_signature>
 100010a:	00209703          	lh	x14,2(x1)
 100010e:	f0000e93          	addi	x29,x0,-256
 1000112:	418d                	c.li	x3,3
 1000114:	1fd71163          	bne	x14,x29,10002f6 <fail>

01000118 <test_4>:
 1000118:	00002097          	auipc	x1,0x2
 100011c:	ee808093          	addi	x1,x1,-280 # 1002000 <begin_signature>
 1000120:	00409703          	lh	x14,4(x1)
 1000124:	00001eb7          	lui	x29,0x1
 1000128:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 100012c:	4191                	c.li	x3,4
 100012e:	1dd71463          	bne	x14,x29,10002f6 <fail>

01000132 <test_5>:
 1000132:	00002097          	auipc	x1,0x2
 1000136:	ece08093          	addi	x1,x1,-306 # 1002000 <begin_signature>
 100013a:	00609703          	lh	x14,6(x1)
 100013e:	fffffeb7          	lui	x29,0xfffff
 1000142:	00fe8e93          	addi	x29,x29,15 # fffff00f <_end+0xfeffcfff>
 1000146:	4195                	c.li	x3,5
 1000148:	1bd71763          	bne	x14,x29,10002f6 <fail>

0100014c <test_6>:
 100014c:	00002097          	auipc	x1,0x2
 1000150:	eba08093          	addi	x1,x1,-326 # 1002006 <tdat4>
 1000154:	ffa09703          	lh	x14,-6(x1)
 1000158:	0ff00e93          	addi	x29,x0,255
 100015c:	4199                	c.li	x3,6
 100015e:	19d71c63          	bne	x14,x29,10002f6 <fail>

01000162 <test_7>:
 1000162:	00002097          	auipc	x1,0x2
 1000166:	ea408093          	addi	x1,x1,-348 # 1002006 <tdat4>
 100016a:	ffc09703          	lh	x14,-4(x1)
 100016e:	f0000e93          	addi	x29,x0,-256
 1000172:	419d                	c.li	x3,7
 1000174:	19d71163          	bne	x14,x29,10002f6 <fail>

01000178 <test_8>:
 1000178:	00002097          	auipc	x1,0x2
 100017c:	e8e08093          	addi	x1,x1,-370 # 1002006 <tdat4>
 1000180:	ffe09703          	lh	x14,-2(x1)
 1000184:	00001eb7          	lui	x29,0x1
 1000188:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 100018c:	41a1                	c.li	x3,8
 100018e:	17d71463          	bne	x14,x29,10002f6 <fail>

01000192 <test_9>:
 1000192:	00002097          	auipc	x1,0x2
 1000196:	e7408093          	addi	x1,x1,-396 # 1002006 <tdat4>
 100019a:	00009703          	lh	x14,0(x1)
 100019e:	fffffeb7          	lui	x29,0xfffff
 10001a2:	00fe8e93          	addi	x29,x29,15 # fffff00f <_end+0xfeffcfff>
 10001a6:	41a5                	c.li	x3,9
 10001a8:	15d71763          	bne	x14,x29,10002f6 <fail>

010001ac <test_10>:
 10001ac:	00002097          	auipc	x1,0x2
 10001b0:	e5408093          	addi	x1,x1,-428 # 1002000 <begin_signature>
 10001b4:	1081                	c.addi	x1,-32
 10001b6:	02009283          	lh	x5,32(x1)
 10001ba:	0ff00e93          	addi	x29,x0,255
 10001be:	41a9                	c.li	x3,10
 10001c0:	13d29b63          	bne	x5,x29,10002f6 <fail>

010001c4 <test_11>:
 10001c4:	00002097          	auipc	x1,0x2
 10001c8:	e3c08093          	addi	x1,x1,-452 # 1002000 <begin_signature>
 10001cc:	10ed                	c.addi	x1,-5
 10001ce:	00709283          	lh	x5,7(x1)
 10001d2:	f0000e93          	addi	x29,x0,-256
 10001d6:	41ad                	c.li	x3,11
 10001d8:	11d29f63          	bne	x5,x29,10002f6 <fail>

010001dc <test_12>:
 10001dc:	41b1                	c.li	x3,12
 10001de:	4201                	c.li	x4,0
 10001e0:	00002097          	auipc	x1,0x2
 10001e4:	e2208093          	addi	x1,x1,-478 # 1002002 <tdat2>
 10001e8:	00209703          	lh	x14,2(x1)
 10001ec:	00070313          	addi	x6,x14,0
 10001f0:	00001eb7          	lui	x29,0x1
 10001f4:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 10001f8:	0fd31f63          	bne	x6,x29,10002f6 <fail>
 10001fc:	0205                	c.addi	x4,1
 10001fe:	4289                	c.li	x5,2
 1000200:	fe5210e3          	bne	x4,x5,10001e0 <test_12+0x4>

01000204 <test_13>:
 1000204:	41b5                	c.li	x3,13
 1000206:	4201                	c.li	x4,0
 1000208:	00002097          	auipc	x1,0x2
 100020c:	dfc08093          	addi	x1,x1,-516 # 1002004 <tdat3>
 1000210:	00209703          	lh	x14,2(x1)
 1000214:	0001                	c.addi	x0,0
 1000216:	00070313          	addi	x6,x14,0
 100021a:	fffffeb7          	lui	x29,0xfffff
 100021e:	00fe8e93          	addi	x29,x29,15 # fffff00f <_end+0xfeffcfff>
 1000222:	0dd31a63          	bne	x6,x29,10002f6 <fail>
 1000226:	0205                	c.addi	x4,1
 1000228:	4289                	c.li	x5,2
 100022a:	fc521fe3          	bne	x4,x5,1000208 <test_13+0x4>

0100022e <test_14>:
 100022e:	41b9                	c.li	x3,14
 1000230:	4201                	c.li	x4,0
 1000232:	00002097          	auipc	x1,0x2
 1000236:	dce08093          	addi	x1,x1,-562 # 1002000 <begin_signature>
 100023a:	00209703          	lh	x14,2(x1)
 100023e:	0001                	c.addi	x0,0
 1000240:	0001                	c.addi	x0,0
 1000242:	00070313          	addi	x6,x14,0
 1000246:	f0000e93          	addi	x29,x0,-256
 100024a:	0bd31663          	bne	x6,x29,10002f6 <fail>
 100024e:	0205                	c.addi	x4,1
 1000250:	4289                	c.li	x5,2
 1000252:	fe5210e3          	bne	x4,x5,1000232 <test_14+0x4>

01000256 <test_15>:
 1000256:	41bd                	c.li	x3,15
 1000258:	4201                	c.li	x4,0
 100025a:	00002097          	auipc	x1,0x2
 100025e:	da808093          	addi	x1,x1,-600 # 1002002 <tdat2>
 1000262:	00209703          	lh	x14,2(x1)
 1000266:	00001eb7          	lui	x29,0x1
 100026a:	ff0e8e93          	addi	x29,x29,-16 # ff0 <_start-0xfff010>
 100026e:	09d71463          	bne	x14,x29,10002f6 <fail>
 1000272:	0205                	c.addi	x4,1
 1000274:	4289                	c.li	x5,2
 1000276:	fe5212e3          	bne	x4,x5,100025a <test_15+0x4>

0100027a <test_16>:
 100027a:	41c1                	c.li	x3,16
 100027c:	4201                	c.li	x4,0
 100027e:	00002097          	auipc	x1,0x2
 1000282:	d8608093          	addi	x1,x1,-634 # 1002004 <tdat3>
 1000286:	0001                	c.addi	x0,0
 1000288:	00209703          	lh	x14,2(x1)
 100028c:	fffffeb7          	lui	x29,0xfffff
 1000290:	00fe8e93          	addi	x29,x29,15 # fffff00f <_end+0xfeffcfff>
 1000294:	07d71163          	bne	x14,x29,10002f6 <fail>
 1000298:	0205                	c.addi	x4,1
 100029a:	4289                	c.li	x5,2
 100029c:	fe5211e3          	bne	x4,x5,100027e <test_16+0x4>

010002a0 <test_17>:
 10002a0:	41c5                	c.li	x3,17
 10002a2:	4201                	c.li	x4,0
 10002a4:	00002097          	auipc	x1,0x2
 10002a8:	d5c08093          	addi	x1,x1,-676 # 1002000 <begin_signature>
 10002ac:	0001                	c.addi	x0,0
 10002ae:	0001                	c.addi	x0,0
 10002b0:	00209703          	lh	x14,2(x1)
 10002b4:	f0000e93          	addi	x29,x0,-256
 10002b8:	03d71f63          	bne	x14,x29,10002f6 <fail>
 10002bc:	0205                	c.addi	x4,1
 10002be:	4289                	c.li	x5,2
 10002c0:	fe5212e3          	bne	x4,x5,10002a4 <test_17+0x4>

010002c4 <test_18>:
 10002c4:	00002297          	auipc	x5,0x2
 10002c8:	d3c28293          	addi	x5,x5,-708 # 1002000 <begin_signature>
 10002cc:	00029103          	lh	x2,0(x5)
 10002d0:	4109                	c.li	x2,2
 10002d2:	4e89                	c.li	x29,2
 10002d4:	41c9                	c.li	x3,18
 10002d6:	03d11063          	bne	x2,x29,10002f6 <fail>

010002da <test_19>:
 10002da:	00002297          	auipc	x5,0x2
 10002de:	d2628293          	addi	x5,x5,-730 # 1002000 <begin_signature>
 10002e2:	00029103          	lh	x2,0(x5)
 10002e6:	0001                	c.addi	x0,0
 10002e8:	4109                	c.li	x2,2
 10002ea:	4e89                	c.li	x29,2
 10002ec:	41cd                	c.li	x3,19
 10002ee:	01d11463          	bne	x2,x29,10002f6 <fail>
 10002f2:	00301b63          	bne	x0,x3,1000308 <pass>

010002f6 <fail>:
 10002f6:	0ff0000f          	fence	iorw,iorw
 10002fa:	00018063          	beq	x3,x0,10002fa <fail+0x4>
 10002fe:	0186                	c.slli	x3,0x1
 1000300:	0011e193          	ori	x3,x3,1
 1000304:	00000073          	ecall

01000308 <pass>:
 1000308:	0ff0000f          	fence	iorw,iorw
 100030c:	4185                	c.li	x3,1
 100030e:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	00ff                	0xff

01002002 <tdat2>:
 1002002:	ff00                	c.fsw	f8,56(x14)

01002004 <tdat3>:
 1002004:	0ff0                	c.addi4spn	x12,x2,988

01002006 <tdat4>:
 1002006:	0000f00f          	0xf00f
 100200a:	0000                	c.unimp
 100200c:	0000                	c.unimp
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
