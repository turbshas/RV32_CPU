
rv32ui/sh.elf:     file format elf32-littleriscv


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
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfdf>
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
 10000f4:	0aa00113          	addi	x2,x0,170
 10000f8:	00209023          	sh	x2,0(x1)
 10000fc:	00009703          	lh	x14,0(x1)
 1000100:	0aa00e93          	addi	x29,x0,170
 1000104:	4189                	c.li	x3,2
 1000106:	3dd71263          	bne	x14,x29,10004ca <fail>

0100010a <test_3>:
 100010a:	00002097          	auipc	x1,0x2
 100010e:	ef608093          	addi	x1,x1,-266 # 1002000 <begin_signature>
 1000112:	ffffb137          	lui	x2,0xffffb
 1000116:	a0010113          	addi	x2,x2,-1536 # ffffaa00 <_end+0xfeff89e0>
 100011a:	00209123          	sh	x2,2(x1)
 100011e:	00209703          	lh	x14,2(x1)
 1000122:	ffffbeb7          	lui	x29,0xffffb
 1000126:	a00e8e93          	addi	x29,x29,-1536 # ffffaa00 <_end+0xfeff89e0>
 100012a:	418d                	c.li	x3,3
 100012c:	39d71f63          	bne	x14,x29,10004ca <fail>

01000130 <test_4>:
 1000130:	00002097          	auipc	x1,0x2
 1000134:	ed008093          	addi	x1,x1,-304 # 1002000 <begin_signature>
 1000138:	beef1137          	lui	x2,0xbeef1
 100013c:	aa010113          	addi	x2,x2,-1376 # beef0aa0 <_end+0xbdeeea80>
 1000140:	00209223          	sh	x2,4(x1)
 1000144:	0040a703          	lw	x14,4(x1)
 1000148:	beef1eb7          	lui	x29,0xbeef1
 100014c:	aa0e8e93          	addi	x29,x29,-1376 # beef0aa0 <_end+0xbdeeea80>
 1000150:	4191                	c.li	x3,4
 1000152:	37d71c63          	bne	x14,x29,10004ca <fail>

01000156 <test_5>:
 1000156:	00002097          	auipc	x1,0x2
 100015a:	eaa08093          	addi	x1,x1,-342 # 1002000 <begin_signature>
 100015e:	ffffa137          	lui	x2,0xffffa
 1000162:	00a10113          	addi	x2,x2,10 # ffffa00a <_end+0xfeff7fea>
 1000166:	00209323          	sh	x2,6(x1)
 100016a:	00609703          	lh	x14,6(x1)
 100016e:	ffffaeb7          	lui	x29,0xffffa
 1000172:	00ae8e93          	addi	x29,x29,10 # ffffa00a <_end+0xfeff7fea>
 1000176:	4195                	c.li	x3,5
 1000178:	35d71963          	bne	x14,x29,10004ca <fail>

0100017c <test_6>:
 100017c:	00002097          	auipc	x1,0x2
 1000180:	e9208093          	addi	x1,x1,-366 # 100200e <tdat8>
 1000184:	0aa00113          	addi	x2,x0,170
 1000188:	fe209d23          	sh	x2,-6(x1)
 100018c:	ffa09703          	lh	x14,-6(x1)
 1000190:	0aa00e93          	addi	x29,x0,170
 1000194:	4199                	c.li	x3,6
 1000196:	33d71a63          	bne	x14,x29,10004ca <fail>

0100019a <test_7>:
 100019a:	00002097          	auipc	x1,0x2
 100019e:	e7408093          	addi	x1,x1,-396 # 100200e <tdat8>
 10001a2:	ffffb137          	lui	x2,0xffffb
 10001a6:	a0010113          	addi	x2,x2,-1536 # ffffaa00 <_end+0xfeff89e0>
 10001aa:	fe209e23          	sh	x2,-4(x1)
 10001ae:	ffc09703          	lh	x14,-4(x1)
 10001b2:	ffffbeb7          	lui	x29,0xffffb
 10001b6:	a00e8e93          	addi	x29,x29,-1536 # ffffaa00 <_end+0xfeff89e0>
 10001ba:	419d                	c.li	x3,7
 10001bc:	31d71763          	bne	x14,x29,10004ca <fail>

010001c0 <test_8>:
 10001c0:	00002097          	auipc	x1,0x2
 10001c4:	e4e08093          	addi	x1,x1,-434 # 100200e <tdat8>
 10001c8:	00001137          	lui	x2,0x1
 10001cc:	aa010113          	addi	x2,x2,-1376 # aa0 <_start-0xfff560>
 10001d0:	fe209f23          	sh	x2,-2(x1)
 10001d4:	ffe09703          	lh	x14,-2(x1)
 10001d8:	00001eb7          	lui	x29,0x1
 10001dc:	aa0e8e93          	addi	x29,x29,-1376 # aa0 <_start-0xfff560>
 10001e0:	41a1                	c.li	x3,8
 10001e2:	2fd71463          	bne	x14,x29,10004ca <fail>

010001e6 <test_9>:
 10001e6:	00002097          	auipc	x1,0x2
 10001ea:	e2808093          	addi	x1,x1,-472 # 100200e <tdat8>
 10001ee:	ffffa137          	lui	x2,0xffffa
 10001f2:	00a10113          	addi	x2,x2,10 # ffffa00a <_end+0xfeff7fea>
 10001f6:	00209023          	sh	x2,0(x1)
 10001fa:	00009703          	lh	x14,0(x1)
 10001fe:	ffffaeb7          	lui	x29,0xffffa
 1000202:	00ae8e93          	addi	x29,x29,10 # ffffa00a <_end+0xfeff7fea>
 1000206:	41a5                	c.li	x3,9
 1000208:	2dd71163          	bne	x14,x29,10004ca <fail>

0100020c <test_10>:
 100020c:	00002097          	auipc	x1,0x2
 1000210:	e0408093          	addi	x1,x1,-508 # 1002010 <tdat9>
 1000214:	12345137          	lui	x2,0x12345
 1000218:	67810113          	addi	x2,x2,1656 # 12345678 <_end+0x11343658>
 100021c:	fe008213          	addi	x4,x1,-32
 1000220:	02221023          	sh	x2,32(x4) # 20 <_start-0xffffe0>
 1000224:	00009283          	lh	x5,0(x1)
 1000228:	00005eb7          	lui	x29,0x5
 100022c:	678e8e93          	addi	x29,x29,1656 # 5678 <_start-0xffa988>
 1000230:	41a9                	c.li	x3,10
 1000232:	29d29c63          	bne	x5,x29,10004ca <fail>

01000236 <test_11>:
 1000236:	00002097          	auipc	x1,0x2
 100023a:	dda08093          	addi	x1,x1,-550 # 1002010 <tdat9>
 100023e:	00003137          	lui	x2,0x3
 1000242:	09810113          	addi	x2,x2,152 # 3098 <_start-0xffcf68>
 1000246:	10ed                	c.addi	x1,-5
 1000248:	002093a3          	sh	x2,7(x1)
 100024c:	00002217          	auipc	x4,0x2
 1000250:	dc620213          	addi	x4,x4,-570 # 1002012 <tdat10>
 1000254:	00021283          	lh	x5,0(x4) # 0 <_start-0x1000000>
 1000258:	00003eb7          	lui	x29,0x3
 100025c:	098e8e93          	addi	x29,x29,152 # 3098 <_start-0xffcf68>
 1000260:	41ad                	c.li	x3,11
 1000262:	27d29463          	bne	x5,x29,10004ca <fail>

01000266 <test_12>:
 1000266:	41b1                	c.li	x3,12
 1000268:	4201                	c.li	x4,0
 100026a:	ffffd0b7          	lui	x1,0xffffd
 100026e:	cdd08093          	addi	x1,x1,-803 # ffffccdd <_end+0xfeffacbd>
 1000272:	00002117          	auipc	x2,0x2
 1000276:	d8e10113          	addi	x2,x2,-626 # 1002000 <begin_signature>
 100027a:	00111023          	sh	x1,0(x2)
 100027e:	00011703          	lh	x14,0(x2)
 1000282:	ffffdeb7          	lui	x29,0xffffd
 1000286:	cdde8e93          	addi	x29,x29,-803 # ffffccdd <_end+0xfeffacbd>
 100028a:	25d71063          	bne	x14,x29,10004ca <fail>
 100028e:	0205                	c.addi	x4,1
 1000290:	4289                	c.li	x5,2
 1000292:	fc521ce3          	bne	x4,x5,100026a <test_12+0x4>

01000296 <test_13>:
 1000296:	41b5                	c.li	x3,13
 1000298:	4201                	c.li	x4,0
 100029a:	ffffc0b7          	lui	x1,0xffffc
 100029e:	ccd08093          	addi	x1,x1,-819 # ffffbccd <_end+0xfeff9cad>
 10002a2:	00002117          	auipc	x2,0x2
 10002a6:	d5e10113          	addi	x2,x2,-674 # 1002000 <begin_signature>
 10002aa:	0001                	c.addi	x0,0
 10002ac:	00111123          	sh	x1,2(x2)
 10002b0:	00211703          	lh	x14,2(x2)
 10002b4:	ffffceb7          	lui	x29,0xffffc
 10002b8:	ccde8e93          	addi	x29,x29,-819 # ffffbccd <_end+0xfeff9cad>
 10002bc:	21d71763          	bne	x14,x29,10004ca <fail>
 10002c0:	0205                	c.addi	x4,1
 10002c2:	4289                	c.li	x5,2
 10002c4:	fc521be3          	bne	x4,x5,100029a <test_13+0x4>

010002c8 <test_14>:
 10002c8:	41b9                	c.li	x3,14
 10002ca:	4201                	c.li	x4,0
 10002cc:	ffffc0b7          	lui	x1,0xffffc
 10002d0:	bcc08093          	addi	x1,x1,-1076 # ffffbbcc <_end+0xfeff9bac>
 10002d4:	00002117          	auipc	x2,0x2
 10002d8:	d2c10113          	addi	x2,x2,-724 # 1002000 <begin_signature>
 10002dc:	0001                	c.addi	x0,0
 10002de:	0001                	c.addi	x0,0
 10002e0:	00111223          	sh	x1,4(x2)
 10002e4:	00411703          	lh	x14,4(x2)
 10002e8:	ffffceb7          	lui	x29,0xffffc
 10002ec:	bcce8e93          	addi	x29,x29,-1076 # ffffbbcc <_end+0xfeff9bac>
 10002f0:	1dd71d63          	bne	x14,x29,10004ca <fail>
 10002f4:	0205                	c.addi	x4,1
 10002f6:	4289                	c.li	x5,2
 10002f8:	fc521ae3          	bne	x4,x5,10002cc <test_14+0x4>

010002fc <test_15>:
 10002fc:	41bd                	c.li	x3,15
 10002fe:	4201                	c.li	x4,0
 1000300:	ffffb0b7          	lui	x1,0xffffb
 1000304:	bbc08093          	addi	x1,x1,-1092 # ffffabbc <_end+0xfeff8b9c>
 1000308:	0001                	c.addi	x0,0
 100030a:	00002117          	auipc	x2,0x2
 100030e:	cf610113          	addi	x2,x2,-778 # 1002000 <begin_signature>
 1000312:	00111323          	sh	x1,6(x2)
 1000316:	00611703          	lh	x14,6(x2)
 100031a:	ffffbeb7          	lui	x29,0xffffb
 100031e:	bbce8e93          	addi	x29,x29,-1092 # ffffabbc <_end+0xfeff8b9c>
 1000322:	1bd71463          	bne	x14,x29,10004ca <fail>
 1000326:	0205                	c.addi	x4,1
 1000328:	4289                	c.li	x5,2
 100032a:	fc521be3          	bne	x4,x5,1000300 <test_15+0x4>

0100032e <test_16>:
 100032e:	41c1                	c.li	x3,16
 1000330:	4201                	c.li	x4,0
 1000332:	ffffb0b7          	lui	x1,0xffffb
 1000336:	abb08093          	addi	x1,x1,-1349 # ffffaabb <_end+0xfeff8a9b>
 100033a:	0001                	c.addi	x0,0
 100033c:	00002117          	auipc	x2,0x2
 1000340:	cc410113          	addi	x2,x2,-828 # 1002000 <begin_signature>
 1000344:	0001                	c.addi	x0,0
 1000346:	00111423          	sh	x1,8(x2)
 100034a:	00811703          	lh	x14,8(x2)
 100034e:	ffffbeb7          	lui	x29,0xffffb
 1000352:	abbe8e93          	addi	x29,x29,-1349 # ffffaabb <_end+0xfeff8a9b>
 1000356:	17d71a63          	bne	x14,x29,10004ca <fail>
 100035a:	0205                	c.addi	x4,1
 100035c:	4289                	c.li	x5,2
 100035e:	fc521ae3          	bne	x4,x5,1000332 <test_16+0x4>

01000362 <test_17>:
 1000362:	41c5                	c.li	x3,17
 1000364:	4201                	c.li	x4,0
 1000366:	ffffe0b7          	lui	x1,0xffffe
 100036a:	aab08093          	addi	x1,x1,-1365 # ffffdaab <_end+0xfeffba8b>
 100036e:	0001                	c.addi	x0,0
 1000370:	0001                	c.addi	x0,0
 1000372:	00002117          	auipc	x2,0x2
 1000376:	c8e10113          	addi	x2,x2,-882 # 1002000 <begin_signature>
 100037a:	00111523          	sh	x1,10(x2)
 100037e:	00a11703          	lh	x14,10(x2)
 1000382:	ffffeeb7          	lui	x29,0xffffe
 1000386:	aabe8e93          	addi	x29,x29,-1365 # ffffdaab <_end+0xfeffba8b>
 100038a:	15d71063          	bne	x14,x29,10004ca <fail>
 100038e:	0205                	c.addi	x4,1
 1000390:	4289                	c.li	x5,2
 1000392:	fc521ae3          	bne	x4,x5,1000366 <test_17+0x4>

01000396 <test_18>:
 1000396:	41c9                	c.li	x3,18
 1000398:	4201                	c.li	x4,0
 100039a:	00002117          	auipc	x2,0x2
 100039e:	c6610113          	addi	x2,x2,-922 # 1002000 <begin_signature>
 10003a2:	000020b7          	lui	x1,0x2
 10003a6:	23308093          	addi	x1,x1,563 # 2233 <_start-0xffddcd>
 10003aa:	00111023          	sh	x1,0(x2)
 10003ae:	00011703          	lh	x14,0(x2)
 10003b2:	00002eb7          	lui	x29,0x2
 10003b6:	233e8e93          	addi	x29,x29,563 # 2233 <_start-0xffddcd>
 10003ba:	11d71863          	bne	x14,x29,10004ca <fail>
 10003be:	0205                	c.addi	x4,1
 10003c0:	4289                	c.li	x5,2
 10003c2:	fc521ce3          	bne	x4,x5,100039a <test_18+0x4>

010003c6 <test_19>:
 10003c6:	41cd                	c.li	x3,19
 10003c8:	4201                	c.li	x4,0
 10003ca:	00002117          	auipc	x2,0x2
 10003ce:	c3610113          	addi	x2,x2,-970 # 1002000 <begin_signature>
 10003d2:	000010b7          	lui	x1,0x1
 10003d6:	22308093          	addi	x1,x1,547 # 1223 <_start-0xffeddd>
 10003da:	0001                	c.addi	x0,0
 10003dc:	00111123          	sh	x1,2(x2)
 10003e0:	00211703          	lh	x14,2(x2)
 10003e4:	00001eb7          	lui	x29,0x1
 10003e8:	223e8e93          	addi	x29,x29,547 # 1223 <_start-0xffeddd>
 10003ec:	0dd71f63          	bne	x14,x29,10004ca <fail>
 10003f0:	0205                	c.addi	x4,1
 10003f2:	4289                	c.li	x5,2
 10003f4:	fc521be3          	bne	x4,x5,10003ca <test_19+0x4>

010003f8 <test_20>:
 10003f8:	41d1                	c.li	x3,20
 10003fa:	4201                	c.li	x4,0
 10003fc:	00002117          	auipc	x2,0x2
 1000400:	c0410113          	addi	x2,x2,-1020 # 1002000 <begin_signature>
 1000404:	000010b7          	lui	x1,0x1
 1000408:	12208093          	addi	x1,x1,290 # 1122 <_start-0xffeede>
 100040c:	0001                	c.addi	x0,0
 100040e:	0001                	c.addi	x0,0
 1000410:	00111223          	sh	x1,4(x2)
 1000414:	00411703          	lh	x14,4(x2)
 1000418:	00001eb7          	lui	x29,0x1
 100041c:	122e8e93          	addi	x29,x29,290 # 1122 <_start-0xffeede>
 1000420:	0bd71563          	bne	x14,x29,10004ca <fail>
 1000424:	0205                	c.addi	x4,1
 1000426:	4289                	c.li	x5,2
 1000428:	fc521ae3          	bne	x4,x5,10003fc <test_20+0x4>

0100042c <test_21>:
 100042c:	41d5                	c.li	x3,21
 100042e:	4201                	c.li	x4,0
 1000430:	00002117          	auipc	x2,0x2
 1000434:	bd010113          	addi	x2,x2,-1072 # 1002000 <begin_signature>
 1000438:	0001                	c.addi	x0,0
 100043a:	11200093          	addi	x1,x0,274
 100043e:	00111323          	sh	x1,6(x2)
 1000442:	00611703          	lh	x14,6(x2)
 1000446:	11200e93          	addi	x29,x0,274
 100044a:	09d71063          	bne	x14,x29,10004ca <fail>
 100044e:	0205                	c.addi	x4,1
 1000450:	4289                	c.li	x5,2
 1000452:	fc521fe3          	bne	x4,x5,1000430 <test_21+0x4>

01000456 <test_22>:
 1000456:	41d9                	c.li	x3,22
 1000458:	4201                	c.li	x4,0
 100045a:	00002117          	auipc	x2,0x2
 100045e:	ba610113          	addi	x2,x2,-1114 # 1002000 <begin_signature>
 1000462:	0001                	c.addi	x0,0
 1000464:	40c5                	c.li	x1,17
 1000466:	0001                	c.addi	x0,0
 1000468:	00111423          	sh	x1,8(x2)
 100046c:	00811703          	lh	x14,8(x2)
 1000470:	4ec5                	c.li	x29,17
 1000472:	05d71c63          	bne	x14,x29,10004ca <fail>
 1000476:	0205                	c.addi	x4,1
 1000478:	4289                	c.li	x5,2
 100047a:	fe5210e3          	bne	x4,x5,100045a <test_22+0x4>

0100047e <test_23>:
 100047e:	41dd                	c.li	x3,23
 1000480:	4201                	c.li	x4,0
 1000482:	00002117          	auipc	x2,0x2
 1000486:	b7e10113          	addi	x2,x2,-1154 # 1002000 <begin_signature>
 100048a:	0001                	c.addi	x0,0
 100048c:	0001                	c.addi	x0,0
 100048e:	000030b7          	lui	x1,0x3
 1000492:	00108093          	addi	x1,x1,1 # 3001 <_start-0xffcfff>
 1000496:	00111523          	sh	x1,10(x2)
 100049a:	00a11703          	lh	x14,10(x2)
 100049e:	00003eb7          	lui	x29,0x3
 10004a2:	001e8e93          	addi	x29,x29,1 # 3001 <_start-0xffcfff>
 10004a6:	03d71263          	bne	x14,x29,10004ca <fail>
 10004aa:	0205                	c.addi	x4,1
 10004ac:	4289                	c.li	x5,2
 10004ae:	fc521ae3          	bne	x4,x5,1000482 <test_23+0x4>
 10004b2:	0000c537          	lui	x10,0xc
 10004b6:	eef50513          	addi	x10,x10,-273 # beef <_start-0xff4111>
 10004ba:	00002597          	auipc	x11,0x2
 10004be:	b4658593          	addi	x11,x11,-1210 # 1002000 <begin_signature>
 10004c2:	00a59323          	sh	x10,6(x11)
 10004c6:	00301b63          	bne	x0,x3,10004dc <pass>

010004ca <fail>:
 10004ca:	0ff0000f          	fence	iorw,iorw
 10004ce:	00018063          	beq	x3,x0,10004ce <fail+0x4>
 10004d2:	0186                	c.slli	x3,0x1
 10004d4:	0011e193          	ori	x3,x3,1
 10004d8:	00000073          	ecall

010004dc <pass>:
 10004dc:	0ff0000f          	fence	iorw,iorw
 10004e0:	4185                	c.li	x3,1
 10004e2:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	          	jal	x29,ffd3ee <_start-0x2c12>

01002002 <tdat2>:
 1002002:	          	jal	x29,ffd3f0 <_start-0x2c10>

01002004 <tdat3>:
 1002004:	          	jal	x29,ffd3f2 <_start-0x2c0e>

01002006 <tdat4>:
 1002006:	          	jal	x29,ffd3f4 <_start-0x2c0c>

01002008 <tdat5>:
 1002008:	          	jal	x29,ffd3f6 <_start-0x2c0a>

0100200a <tdat6>:
 100200a:	          	jal	x29,ffd3f8 <_start-0x2c08>

0100200c <tdat7>:
 100200c:	          	jal	x29,ffd3fa <_start-0x2c06>

0100200e <tdat8>:
 100200e:	          	jal	x29,ffd3fc <_start-0x2c04>

01002010 <tdat9>:
 1002010:	          	jal	x29,ffd3fe <_start-0x2c02>

01002012 <tdat10>:
 1002012:	0000beef          	jal	x29,100d012 <_end+0xaff2>
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd960>
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
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd9a4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...
