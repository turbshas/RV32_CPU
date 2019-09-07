
rv32ui/lw.elf:     file format elf32-littleriscv


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
 10000f4:	0000a703          	lw	x14,0(x1)
 10000f8:	00ff0eb7          	lui	x29,0xff0
 10000fc:	0ffe8e93          	addi	x29,x29,255 # ff00ff <_start-0xff01>
 1000100:	4189                	c.li	x3,2
 1000102:	21d71a63          	bne	x14,x29,1000316 <fail>

01000106 <test_3>:
 1000106:	00002097          	auipc	x1,0x2
 100010a:	efa08093          	addi	x1,x1,-262 # 1002000 <begin_signature>
 100010e:	0040a703          	lw	x14,4(x1)
 1000112:	ff010eb7          	lui	x29,0xff010
 1000116:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00def0>
 100011a:	418d                	c.li	x3,3
 100011c:	1fd71d63          	bne	x14,x29,1000316 <fail>

01000120 <test_4>:
 1000120:	00002097          	auipc	x1,0x2
 1000124:	ee008093          	addi	x1,x1,-288 # 1002000 <begin_signature>
 1000128:	0080a703          	lw	x14,8(x1)
 100012c:	0ff01eb7          	lui	x29,0xff01
 1000130:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefefe0>
 1000134:	4191                	c.li	x3,4
 1000136:	1fd71063          	bne	x14,x29,1000316 <fail>

0100013a <test_5>:
 100013a:	00002097          	auipc	x1,0x2
 100013e:	ec608093          	addi	x1,x1,-314 # 1002000 <begin_signature>
 1000142:	00c0a703          	lw	x14,12(x1)
 1000146:	f00ffeb7          	lui	x29,0xf00ff
 100014a:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fcfff>
 100014e:	4195                	c.li	x3,5
 1000150:	1dd71363          	bne	x14,x29,1000316 <fail>

01000154 <test_6>:
 1000154:	00002097          	auipc	x1,0x2
 1000158:	eb808093          	addi	x1,x1,-328 # 100200c <tdat4>
 100015c:	ff40a703          	lw	x14,-12(x1)
 1000160:	00ff0eb7          	lui	x29,0xff0
 1000164:	0ffe8e93          	addi	x29,x29,255 # ff00ff <_start-0xff01>
 1000168:	4199                	c.li	x3,6
 100016a:	1bd71663          	bne	x14,x29,1000316 <fail>

0100016e <test_7>:
 100016e:	00002097          	auipc	x1,0x2
 1000172:	e9e08093          	addi	x1,x1,-354 # 100200c <tdat4>
 1000176:	ff80a703          	lw	x14,-8(x1)
 100017a:	ff010eb7          	lui	x29,0xff010
 100017e:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00def0>
 1000182:	419d                	c.li	x3,7
 1000184:	19d71963          	bne	x14,x29,1000316 <fail>

01000188 <test_8>:
 1000188:	00002097          	auipc	x1,0x2
 100018c:	e8408093          	addi	x1,x1,-380 # 100200c <tdat4>
 1000190:	ffc0a703          	lw	x14,-4(x1)
 1000194:	0ff01eb7          	lui	x29,0xff01
 1000198:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefefe0>
 100019c:	41a1                	c.li	x3,8
 100019e:	17d71c63          	bne	x14,x29,1000316 <fail>

010001a2 <test_9>:
 10001a2:	00002097          	auipc	x1,0x2
 10001a6:	e6a08093          	addi	x1,x1,-406 # 100200c <tdat4>
 10001aa:	0000a703          	lw	x14,0(x1)
 10001ae:	f00ffeb7          	lui	x29,0xf00ff
 10001b2:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fcfff>
 10001b6:	41a5                	c.li	x3,9
 10001b8:	15d71f63          	bne	x14,x29,1000316 <fail>

010001bc <test_10>:
 10001bc:	00002097          	auipc	x1,0x2
 10001c0:	e4408093          	addi	x1,x1,-444 # 1002000 <begin_signature>
 10001c4:	1081                	c.addi	x1,-32
 10001c6:	0200a283          	lw	x5,32(x1)
 10001ca:	00ff0eb7          	lui	x29,0xff0
 10001ce:	0ffe8e93          	addi	x29,x29,255 # ff00ff <_start-0xff01>
 10001d2:	41a9                	c.li	x3,10
 10001d4:	15d29163          	bne	x5,x29,1000316 <fail>

010001d8 <test_11>:
 10001d8:	00002097          	auipc	x1,0x2
 10001dc:	e2808093          	addi	x1,x1,-472 # 1002000 <begin_signature>
 10001e0:	10f5                	c.addi	x1,-3
 10001e2:	0070a283          	lw	x5,7(x1)
 10001e6:	ff010eb7          	lui	x29,0xff010
 10001ea:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00def0>
 10001ee:	41ad                	c.li	x3,11
 10001f0:	13d29363          	bne	x5,x29,1000316 <fail>

010001f4 <test_12>:
 10001f4:	41b1                	c.li	x3,12
 10001f6:	4201                	c.li	x4,0
 10001f8:	00002097          	auipc	x1,0x2
 10001fc:	e0c08093          	addi	x1,x1,-500 # 1002004 <tdat2>
 1000200:	0040a703          	lw	x14,4(x1)
 1000204:	00070313          	addi	x6,x14,0
 1000208:	0ff01eb7          	lui	x29,0xff01
 100020c:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefefe0>
 1000210:	11d31363          	bne	x6,x29,1000316 <fail>
 1000214:	0205                	c.addi	x4,1
 1000216:	4289                	c.li	x5,2
 1000218:	fe5210e3          	bne	x4,x5,10001f8 <test_12+0x4>

0100021c <test_13>:
 100021c:	41b5                	c.li	x3,13
 100021e:	4201                	c.li	x4,0
 1000220:	00002097          	auipc	x1,0x2
 1000224:	de808093          	addi	x1,x1,-536 # 1002008 <tdat3>
 1000228:	0040a703          	lw	x14,4(x1)
 100022c:	0001                	c.addi	x0,0
 100022e:	00070313          	addi	x6,x14,0
 1000232:	f00ffeb7          	lui	x29,0xf00ff
 1000236:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fcfff>
 100023a:	0dd31e63          	bne	x6,x29,1000316 <fail>
 100023e:	0205                	c.addi	x4,1
 1000240:	4289                	c.li	x5,2
 1000242:	fc521fe3          	bne	x4,x5,1000220 <test_13+0x4>

01000246 <test_14>:
 1000246:	41b9                	c.li	x3,14
 1000248:	4201                	c.li	x4,0
 100024a:	00002097          	auipc	x1,0x2
 100024e:	db608093          	addi	x1,x1,-586 # 1002000 <begin_signature>
 1000252:	0040a703          	lw	x14,4(x1)
 1000256:	0001                	c.addi	x0,0
 1000258:	0001                	c.addi	x0,0
 100025a:	00070313          	addi	x6,x14,0
 100025e:	ff010eb7          	lui	x29,0xff010
 1000262:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00def0>
 1000266:	0bd31863          	bne	x6,x29,1000316 <fail>
 100026a:	0205                	c.addi	x4,1
 100026c:	4289                	c.li	x5,2
 100026e:	fc521ee3          	bne	x4,x5,100024a <test_14+0x4>

01000272 <test_15>:
 1000272:	41bd                	c.li	x3,15
 1000274:	4201                	c.li	x4,0
 1000276:	00002097          	auipc	x1,0x2
 100027a:	d8e08093          	addi	x1,x1,-626 # 1002004 <tdat2>
 100027e:	0040a703          	lw	x14,4(x1)
 1000282:	0ff01eb7          	lui	x29,0xff01
 1000286:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefefe0>
 100028a:	09d71663          	bne	x14,x29,1000316 <fail>
 100028e:	0205                	c.addi	x4,1
 1000290:	4289                	c.li	x5,2
 1000292:	fe5212e3          	bne	x4,x5,1000276 <test_15+0x4>

01000296 <test_16>:
 1000296:	41c1                	c.li	x3,16
 1000298:	4201                	c.li	x4,0
 100029a:	00002097          	auipc	x1,0x2
 100029e:	d6e08093          	addi	x1,x1,-658 # 1002008 <tdat3>
 10002a2:	0001                	c.addi	x0,0
 10002a4:	0040a703          	lw	x14,4(x1)
 10002a8:	f00ffeb7          	lui	x29,0xf00ff
 10002ac:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fcfff>
 10002b0:	07d71363          	bne	x14,x29,1000316 <fail>
 10002b4:	0205                	c.addi	x4,1
 10002b6:	4289                	c.li	x5,2
 10002b8:	fe5211e3          	bne	x4,x5,100029a <test_16+0x4>

010002bc <test_17>:
 10002bc:	41c5                	c.li	x3,17
 10002be:	4201                	c.li	x4,0
 10002c0:	00002097          	auipc	x1,0x2
 10002c4:	d4008093          	addi	x1,x1,-704 # 1002000 <begin_signature>
 10002c8:	0001                	c.addi	x0,0
 10002ca:	0001                	c.addi	x0,0
 10002cc:	0040a703          	lw	x14,4(x1)
 10002d0:	ff010eb7          	lui	x29,0xff010
 10002d4:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00def0>
 10002d8:	03d71f63          	bne	x14,x29,1000316 <fail>
 10002dc:	0205                	c.addi	x4,1
 10002de:	4289                	c.li	x5,2
 10002e0:	fe5210e3          	bne	x4,x5,10002c0 <test_17+0x4>

010002e4 <test_18>:
 10002e4:	00002297          	auipc	x5,0x2
 10002e8:	d1c28293          	addi	x5,x5,-740 # 1002000 <begin_signature>
 10002ec:	0002a103          	lw	x2,0(x5)
 10002f0:	4109                	c.li	x2,2
 10002f2:	4e89                	c.li	x29,2
 10002f4:	41c9                	c.li	x3,18
 10002f6:	03d11063          	bne	x2,x29,1000316 <fail>

010002fa <test_19>:
 10002fa:	00002297          	auipc	x5,0x2
 10002fe:	d0628293          	addi	x5,x5,-762 # 1002000 <begin_signature>
 1000302:	0002a103          	lw	x2,0(x5)
 1000306:	0001                	c.addi	x0,0
 1000308:	4109                	c.li	x2,2
 100030a:	4e89                	c.li	x29,2
 100030c:	41cd                	c.li	x3,19
 100030e:	01d11463          	bne	x2,x29,1000316 <fail>
 1000312:	00301b63          	bne	x0,x3,1000328 <pass>

01000316 <fail>:
 1000316:	0ff0000f          	fence	iorw,iorw
 100031a:	00018063          	beq	x3,x0,100031a <fail+0x4>
 100031e:	0186                	c.slli	x3,0x1
 1000320:	0011e193          	ori	x3,x3,1
 1000324:	00000073          	ecall

01000328 <pass>:
 1000328:	0ff0000f          	fence	iorw,iorw
 100032c:	4185                	c.li	x3,1
 100032e:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	00ff                	0xff
 1002002:	00ff                	0xff

01002004 <tdat2>:
 1002004:	ff00                	c.fsw	f8,56(x14)
 1002006:	ff00                	c.fsw	f8,56(x14)

01002008 <tdat3>:
 1002008:	0ff0                	c.addi4spn	x12,x2,988
 100200a:	0ff0                	c.addi4spn	x12,x2,988

0100200c <tdat4>:
 100200c:	f00ff00f          	0xf00ff00f

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
