
rv32ui/sw.elf:     file format elf32-littleriscv


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
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfcf>
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
 10000f4:	00aa0137          	lui	x2,0xaa0
 10000f8:	0aa10113          	addi	x2,x2,170 # aa00aa <_start-0x55ff56>
 10000fc:	0020a023          	sw	x2,0(x1)
 1000100:	0000a703          	lw	x14,0(x1)
 1000104:	00aa0eb7          	lui	x29,0xaa0
 1000108:	0aae8e93          	addi	x29,x29,170 # aa00aa <_start-0x55ff56>
 100010c:	4189                	c.li	x3,2
 100010e:	39d71e63          	bne	x14,x29,10004aa <fail>

01000112 <test_3>:
 1000112:	00002097          	auipc	x1,0x2
 1000116:	eee08093          	addi	x1,x1,-274 # 1002000 <begin_signature>
 100011a:	aa00b137          	lui	x2,0xaa00b
 100011e:	a0010113          	addi	x2,x2,-1536 # aa00aa00 <_end+0xa90089d0>
 1000122:	0020a223          	sw	x2,4(x1)
 1000126:	0040a703          	lw	x14,4(x1)
 100012a:	aa00beb7          	lui	x29,0xaa00b
 100012e:	a00e8e93          	addi	x29,x29,-1536 # aa00aa00 <_end+0xa90089d0>
 1000132:	418d                	c.li	x3,3
 1000134:	37d71b63          	bne	x14,x29,10004aa <fail>

01000138 <test_4>:
 1000138:	00002097          	auipc	x1,0x2
 100013c:	ec808093          	addi	x1,x1,-312 # 1002000 <begin_signature>
 1000140:	0aa01137          	lui	x2,0xaa01
 1000144:	aa010113          	addi	x2,x2,-1376 # aa00aa0 <_end+0x99fea70>
 1000148:	0020a423          	sw	x2,8(x1)
 100014c:	0080a703          	lw	x14,8(x1)
 1000150:	0aa01eb7          	lui	x29,0xaa01
 1000154:	aa0e8e93          	addi	x29,x29,-1376 # aa00aa0 <_end+0x99fea70>
 1000158:	4191                	c.li	x3,4
 100015a:	35d71863          	bne	x14,x29,10004aa <fail>

0100015e <test_5>:
 100015e:	00002097          	auipc	x1,0x2
 1000162:	ea208093          	addi	x1,x1,-350 # 1002000 <begin_signature>
 1000166:	a00aa137          	lui	x2,0xa00aa
 100016a:	00a10113          	addi	x2,x2,10 # a00aa00a <_end+0x9f0a7fda>
 100016e:	0020a623          	sw	x2,12(x1)
 1000172:	00c0a703          	lw	x14,12(x1)
 1000176:	a00aaeb7          	lui	x29,0xa00aa
 100017a:	00ae8e93          	addi	x29,x29,10 # a00aa00a <_end+0x9f0a7fda>
 100017e:	4195                	c.li	x3,5
 1000180:	33d71563          	bne	x14,x29,10004aa <fail>

01000184 <test_6>:
 1000184:	00002097          	auipc	x1,0x2
 1000188:	e9808093          	addi	x1,x1,-360 # 100201c <tdat8>
 100018c:	00aa0137          	lui	x2,0xaa0
 1000190:	0aa10113          	addi	x2,x2,170 # aa00aa <_start-0x55ff56>
 1000194:	fe20aa23          	sw	x2,-12(x1)
 1000198:	ff40a703          	lw	x14,-12(x1)
 100019c:	00aa0eb7          	lui	x29,0xaa0
 10001a0:	0aae8e93          	addi	x29,x29,170 # aa00aa <_start-0x55ff56>
 10001a4:	4199                	c.li	x3,6
 10001a6:	31d71263          	bne	x14,x29,10004aa <fail>

010001aa <test_7>:
 10001aa:	00002097          	auipc	x1,0x2
 10001ae:	e7208093          	addi	x1,x1,-398 # 100201c <tdat8>
 10001b2:	aa00b137          	lui	x2,0xaa00b
 10001b6:	a0010113          	addi	x2,x2,-1536 # aa00aa00 <_end+0xa90089d0>
 10001ba:	fe20ac23          	sw	x2,-8(x1)
 10001be:	ff80a703          	lw	x14,-8(x1)
 10001c2:	aa00beb7          	lui	x29,0xaa00b
 10001c6:	a00e8e93          	addi	x29,x29,-1536 # aa00aa00 <_end+0xa90089d0>
 10001ca:	419d                	c.li	x3,7
 10001cc:	2dd71f63          	bne	x14,x29,10004aa <fail>

010001d0 <test_8>:
 10001d0:	00002097          	auipc	x1,0x2
 10001d4:	e4c08093          	addi	x1,x1,-436 # 100201c <tdat8>
 10001d8:	0aa01137          	lui	x2,0xaa01
 10001dc:	aa010113          	addi	x2,x2,-1376 # aa00aa0 <_end+0x99fea70>
 10001e0:	fe20ae23          	sw	x2,-4(x1)
 10001e4:	ffc0a703          	lw	x14,-4(x1)
 10001e8:	0aa01eb7          	lui	x29,0xaa01
 10001ec:	aa0e8e93          	addi	x29,x29,-1376 # aa00aa0 <_end+0x99fea70>
 10001f0:	41a1                	c.li	x3,8
 10001f2:	2bd71c63          	bne	x14,x29,10004aa <fail>

010001f6 <test_9>:
 10001f6:	00002097          	auipc	x1,0x2
 10001fa:	e2608093          	addi	x1,x1,-474 # 100201c <tdat8>
 10001fe:	a00aa137          	lui	x2,0xa00aa
 1000202:	00a10113          	addi	x2,x2,10 # a00aa00a <_end+0x9f0a7fda>
 1000206:	0020a023          	sw	x2,0(x1)
 100020a:	0000a703          	lw	x14,0(x1)
 100020e:	a00aaeb7          	lui	x29,0xa00aa
 1000212:	00ae8e93          	addi	x29,x29,10 # a00aa00a <_end+0x9f0a7fda>
 1000216:	41a5                	c.li	x3,9
 1000218:	29d71963          	bne	x14,x29,10004aa <fail>

0100021c <test_10>:
 100021c:	00002097          	auipc	x1,0x2
 1000220:	e0408093          	addi	x1,x1,-508 # 1002020 <tdat9>
 1000224:	12345137          	lui	x2,0x12345
 1000228:	67810113          	addi	x2,x2,1656 # 12345678 <_end+0x11343648>
 100022c:	fe008213          	addi	x4,x1,-32
 1000230:	02222023          	sw	x2,32(x4) # 20 <_start-0xffffe0>
 1000234:	0000a283          	lw	x5,0(x1)
 1000238:	12345eb7          	lui	x29,0x12345
 100023c:	678e8e93          	addi	x29,x29,1656 # 12345678 <_end+0x11343648>
 1000240:	41a9                	c.li	x3,10
 1000242:	27d29463          	bne	x5,x29,10004aa <fail>

01000246 <test_11>:
 1000246:	00002097          	auipc	x1,0x2
 100024a:	dda08093          	addi	x1,x1,-550 # 1002020 <tdat9>
 100024e:	58213137          	lui	x2,0x58213
 1000252:	09810113          	addi	x2,x2,152 # 58213098 <_end+0x57211068>
 1000256:	10f5                	c.addi	x1,-3
 1000258:	0020a3a3          	sw	x2,7(x1)
 100025c:	00002217          	auipc	x4,0x2
 1000260:	dc820213          	addi	x4,x4,-568 # 1002024 <tdat10>
 1000264:	00022283          	lw	x5,0(x4) # 0 <_start-0x1000000>
 1000268:	58213eb7          	lui	x29,0x58213
 100026c:	098e8e93          	addi	x29,x29,152 # 58213098 <_end+0x57211068>
 1000270:	41ad                	c.li	x3,11
 1000272:	23d29c63          	bne	x5,x29,10004aa <fail>

01000276 <test_12>:
 1000276:	41b1                	c.li	x3,12
 1000278:	4201                	c.li	x4,0
 100027a:	aabbd0b7          	lui	x1,0xaabbd
 100027e:	cdd08093          	addi	x1,x1,-803 # aabbccdd <_end+0xa9bbacad>
 1000282:	00002117          	auipc	x2,0x2
 1000286:	d7e10113          	addi	x2,x2,-642 # 1002000 <begin_signature>
 100028a:	c006                	c.swsp	x1,0(x2)
 100028c:	4702                	c.lwsp	x14,0(x2)
 100028e:	aabbdeb7          	lui	x29,0xaabbd
 1000292:	cdde8e93          	addi	x29,x29,-803 # aabbccdd <_end+0xa9bbacad>
 1000296:	21d71a63          	bne	x14,x29,10004aa <fail>
 100029a:	0205                	c.addi	x4,1
 100029c:	4289                	c.li	x5,2
 100029e:	fc521ee3          	bne	x4,x5,100027a <test_12+0x4>

010002a2 <test_13>:
 10002a2:	41b5                	c.li	x3,13
 10002a4:	4201                	c.li	x4,0
 10002a6:	daabc0b7          	lui	x1,0xdaabc
 10002aa:	ccd08093          	addi	x1,x1,-819 # daabbccd <_end+0xd9ab9c9d>
 10002ae:	00002117          	auipc	x2,0x2
 10002b2:	d5210113          	addi	x2,x2,-686 # 1002000 <begin_signature>
 10002b6:	0001                	c.addi	x0,0
 10002b8:	c206                	c.swsp	x1,4(x2)
 10002ba:	4712                	c.lwsp	x14,4(x2)
 10002bc:	daabceb7          	lui	x29,0xdaabc
 10002c0:	ccde8e93          	addi	x29,x29,-819 # daabbccd <_end+0xd9ab9c9d>
 10002c4:	1fd71363          	bne	x14,x29,10004aa <fail>
 10002c8:	0205                	c.addi	x4,1
 10002ca:	4289                	c.li	x5,2
 10002cc:	fc521de3          	bne	x4,x5,10002a6 <test_13+0x4>

010002d0 <test_14>:
 10002d0:	41b9                	c.li	x3,14
 10002d2:	4201                	c.li	x4,0
 10002d4:	ddaac0b7          	lui	x1,0xddaac
 10002d8:	bcc08093          	addi	x1,x1,-1076 # ddaabbcc <_end+0xdcaa9b9c>
 10002dc:	00002117          	auipc	x2,0x2
 10002e0:	d2410113          	addi	x2,x2,-732 # 1002000 <begin_signature>
 10002e4:	0001                	c.addi	x0,0
 10002e6:	0001                	c.addi	x0,0
 10002e8:	c406                	c.swsp	x1,8(x2)
 10002ea:	4722                	c.lwsp	x14,8(x2)
 10002ec:	ddaaceb7          	lui	x29,0xddaac
 10002f0:	bcce8e93          	addi	x29,x29,-1076 # ddaabbcc <_end+0xdcaa9b9c>
 10002f4:	1bd71b63          	bne	x14,x29,10004aa <fail>
 10002f8:	0205                	c.addi	x4,1
 10002fa:	4289                	c.li	x5,2
 10002fc:	fc521ce3          	bne	x4,x5,10002d4 <test_14+0x4>

01000300 <test_15>:
 1000300:	41bd                	c.li	x3,15
 1000302:	4201                	c.li	x4,0
 1000304:	cddab0b7          	lui	x1,0xcddab
 1000308:	bbc08093          	addi	x1,x1,-1092 # cddaabbc <_end+0xccda8b8c>
 100030c:	0001                	c.addi	x0,0
 100030e:	00002117          	auipc	x2,0x2
 1000312:	cf210113          	addi	x2,x2,-782 # 1002000 <begin_signature>
 1000316:	c606                	c.swsp	x1,12(x2)
 1000318:	4732                	c.lwsp	x14,12(x2)
 100031a:	cddabeb7          	lui	x29,0xcddab
 100031e:	bbce8e93          	addi	x29,x29,-1092 # cddaabbc <_end+0xccda8b8c>
 1000322:	19d71463          	bne	x14,x29,10004aa <fail>
 1000326:	0205                	c.addi	x4,1
 1000328:	4289                	c.li	x5,2
 100032a:	fc521de3          	bne	x4,x5,1000304 <test_15+0x4>

0100032e <test_16>:
 100032e:	41c1                	c.li	x3,16
 1000330:	4201                	c.li	x4,0
 1000332:	ccddb0b7          	lui	x1,0xccddb
 1000336:	abb08093          	addi	x1,x1,-1349 # ccddaabb <_end+0xcbdd8a8b>
 100033a:	0001                	c.addi	x0,0
 100033c:	00002117          	auipc	x2,0x2
 1000340:	cc410113          	addi	x2,x2,-828 # 1002000 <begin_signature>
 1000344:	0001                	c.addi	x0,0
 1000346:	c806                	c.swsp	x1,16(x2)
 1000348:	4742                	c.lwsp	x14,16(x2)
 100034a:	ccddbeb7          	lui	x29,0xccddb
 100034e:	abbe8e93          	addi	x29,x29,-1349 # ccddaabb <_end+0xcbdd8a8b>
 1000352:	15d71c63          	bne	x14,x29,10004aa <fail>
 1000356:	0205                	c.addi	x4,1
 1000358:	4289                	c.li	x5,2
 100035a:	fc521ce3          	bne	x4,x5,1000332 <test_16+0x4>

0100035e <test_17>:
 100035e:	41c5                	c.li	x3,17
 1000360:	4201                	c.li	x4,0
 1000362:	bccde0b7          	lui	x1,0xbccde
 1000366:	aab08093          	addi	x1,x1,-1365 # bccddaab <_end+0xbbcdba7b>
 100036a:	0001                	c.addi	x0,0
 100036c:	0001                	c.addi	x0,0
 100036e:	00002117          	auipc	x2,0x2
 1000372:	c9210113          	addi	x2,x2,-878 # 1002000 <begin_signature>
 1000376:	ca06                	c.swsp	x1,20(x2)
 1000378:	4752                	c.lwsp	x14,20(x2)
 100037a:	bccdeeb7          	lui	x29,0xbccde
 100037e:	aabe8e93          	addi	x29,x29,-1365 # bccddaab <_end+0xbbcdba7b>
 1000382:	13d71463          	bne	x14,x29,10004aa <fail>
 1000386:	0205                	c.addi	x4,1
 1000388:	4289                	c.li	x5,2
 100038a:	fc521ce3          	bne	x4,x5,1000362 <test_17+0x4>

0100038e <test_18>:
 100038e:	41c9                	c.li	x3,18
 1000390:	4201                	c.li	x4,0
 1000392:	00002117          	auipc	x2,0x2
 1000396:	c6e10113          	addi	x2,x2,-914 # 1002000 <begin_signature>
 100039a:	001120b7          	lui	x1,0x112
 100039e:	23308093          	addi	x1,x1,563 # 112233 <_start-0xeeddcd>
 10003a2:	c006                	c.swsp	x1,0(x2)
 10003a4:	4702                	c.lwsp	x14,0(x2)
 10003a6:	00112eb7          	lui	x29,0x112
 10003aa:	233e8e93          	addi	x29,x29,563 # 112233 <_start-0xeeddcd>
 10003ae:	0fd71e63          	bne	x14,x29,10004aa <fail>
 10003b2:	0205                	c.addi	x4,1
 10003b4:	4289                	c.li	x5,2
 10003b6:	fc521ee3          	bne	x4,x5,1000392 <test_18+0x4>

010003ba <test_19>:
 10003ba:	41cd                	c.li	x3,19
 10003bc:	4201                	c.li	x4,0
 10003be:	00002117          	auipc	x2,0x2
 10003c2:	c4210113          	addi	x2,x2,-958 # 1002000 <begin_signature>
 10003c6:	300110b7          	lui	x1,0x30011
 10003ca:	22308093          	addi	x1,x1,547 # 30011223 <_end+0x2f00f1f3>
 10003ce:	0001                	c.addi	x0,0
 10003d0:	c206                	c.swsp	x1,4(x2)
 10003d2:	4712                	c.lwsp	x14,4(x2)
 10003d4:	30011eb7          	lui	x29,0x30011
 10003d8:	223e8e93          	addi	x29,x29,547 # 30011223 <_end+0x2f00f1f3>
 10003dc:	0dd71763          	bne	x14,x29,10004aa <fail>
 10003e0:	0205                	c.addi	x4,1
 10003e2:	4289                	c.li	x5,2
 10003e4:	fc521de3          	bne	x4,x5,10003be <test_19+0x4>

010003e8 <test_20>:
 10003e8:	41d1                	c.li	x3,20
 10003ea:	4201                	c.li	x4,0
 10003ec:	00002117          	auipc	x2,0x2
 10003f0:	c1410113          	addi	x2,x2,-1004 # 1002000 <begin_signature>
 10003f4:	330010b7          	lui	x1,0x33001
 10003f8:	12208093          	addi	x1,x1,290 # 33001122 <_end+0x31fff0f2>
 10003fc:	0001                	c.addi	x0,0
 10003fe:	0001                	c.addi	x0,0
 1000400:	c406                	c.swsp	x1,8(x2)
 1000402:	4722                	c.lwsp	x14,8(x2)
 1000404:	33001eb7          	lui	x29,0x33001
 1000408:	122e8e93          	addi	x29,x29,290 # 33001122 <_end+0x31fff0f2>
 100040c:	09d71f63          	bne	x14,x29,10004aa <fail>
 1000410:	0205                	c.addi	x4,1
 1000412:	4289                	c.li	x5,2
 1000414:	fc521ce3          	bne	x4,x5,10003ec <test_20+0x4>

01000418 <test_21>:
 1000418:	41d5                	c.li	x3,21
 100041a:	4201                	c.li	x4,0
 100041c:	00002117          	auipc	x2,0x2
 1000420:	be410113          	addi	x2,x2,-1052 # 1002000 <begin_signature>
 1000424:	0001                	c.addi	x0,0
 1000426:	233000b7          	lui	x1,0x23300
 100042a:	11208093          	addi	x1,x1,274 # 23300112 <_end+0x222fe0e2>
 100042e:	c606                	c.swsp	x1,12(x2)
 1000430:	4732                	c.lwsp	x14,12(x2)
 1000432:	23300eb7          	lui	x29,0x23300
 1000436:	112e8e93          	addi	x29,x29,274 # 23300112 <_end+0x222fe0e2>
 100043a:	07d71863          	bne	x14,x29,10004aa <fail>
 100043e:	0205                	c.addi	x4,1
 1000440:	4289                	c.li	x5,2
 1000442:	fc521de3          	bne	x4,x5,100041c <test_21+0x4>

01000446 <test_22>:
 1000446:	41d9                	c.li	x3,22
 1000448:	4201                	c.li	x4,0
 100044a:	00002117          	auipc	x2,0x2
 100044e:	bb610113          	addi	x2,x2,-1098 # 1002000 <begin_signature>
 1000452:	0001                	c.addi	x0,0
 1000454:	223300b7          	lui	x1,0x22330
 1000458:	01108093          	addi	x1,x1,17 # 22330011 <_end+0x2132dfe1>
 100045c:	0001                	c.addi	x0,0
 100045e:	c806                	c.swsp	x1,16(x2)
 1000460:	4742                	c.lwsp	x14,16(x2)
 1000462:	22330eb7          	lui	x29,0x22330
 1000466:	011e8e93          	addi	x29,x29,17 # 22330011 <_end+0x2132dfe1>
 100046a:	05d71063          	bne	x14,x29,10004aa <fail>
 100046e:	0205                	c.addi	x4,1
 1000470:	4289                	c.li	x5,2
 1000472:	fc521ce3          	bne	x4,x5,100044a <test_22+0x4>

01000476 <test_23>:
 1000476:	41dd                	c.li	x3,23
 1000478:	4201                	c.li	x4,0
 100047a:	00002117          	auipc	x2,0x2
 100047e:	b8610113          	addi	x2,x2,-1146 # 1002000 <begin_signature>
 1000482:	0001                	c.addi	x0,0
 1000484:	0001                	c.addi	x0,0
 1000486:	122330b7          	lui	x1,0x12233
 100048a:	00108093          	addi	x1,x1,1 # 12233001 <_end+0x11230fd1>
 100048e:	ca06                	c.swsp	x1,20(x2)
 1000490:	4752                	c.lwsp	x14,20(x2)
 1000492:	12233eb7          	lui	x29,0x12233
 1000496:	001e8e93          	addi	x29,x29,1 # 12233001 <_end+0x11230fd1>
 100049a:	01d71863          	bne	x14,x29,10004aa <fail>
 100049e:	0205                	c.addi	x4,1
 10004a0:	4289                	c.li	x5,2
 10004a2:	fc521ce3          	bne	x4,x5,100047a <test_23+0x4>
 10004a6:	00301b63          	bne	x0,x3,10004bc <pass>

010004aa <fail>:
 10004aa:	0ff0000f          	fence	iorw,iorw
 10004ae:	00018063          	beq	x3,x0,10004ae <fail+0x4>
 10004b2:	0186                	c.slli	x3,0x1
 10004b4:	0011e193          	ori	x3,x3,1
 10004b8:	00000073          	ecall

010004bc <pass>:
 10004bc:	0ff0000f          	fence	iorw,iorw
 10004c0:	4185                	c.li	x3,1
 10004c2:	00000073          	ecall
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	deadbeef          	jal	x29,fdd5ea <_start-0x22a16>

01002004 <tdat2>:
 1002004:	deadbeef          	jal	x29,fdd5ee <_start-0x22a12>

01002008 <tdat3>:
 1002008:	deadbeef          	jal	x29,fdd5f2 <_start-0x22a0e>

0100200c <tdat4>:
 100200c:	deadbeef          	jal	x29,fdd5f6 <_start-0x22a0a>

01002010 <tdat5>:
 1002010:	deadbeef          	jal	x29,fdd5fa <_start-0x22a06>

01002014 <tdat6>:
 1002014:	deadbeef          	jal	x29,fdd5fe <_start-0x22a02>

01002018 <tdat7>:
 1002018:	deadbeef          	jal	x29,fdd602 <_start-0x229fe>

0100201c <tdat8>:
 100201c:	deadbeef          	jal	x29,fdd606 <_start-0x229fa>

01002020 <tdat9>:
 1002020:	deadbeef          	jal	x29,fdd60a <_start-0x229f6>

01002024 <tdat10>:
 1002024:	deadbeef          	jal	x29,fdd60e <_start-0x229f2>
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd950>
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
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd994>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...
