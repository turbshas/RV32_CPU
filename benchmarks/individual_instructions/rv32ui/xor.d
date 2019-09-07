
rv32ui/xor.elf:     file format elf32-littleriscv


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
 10000ec:	ff0100b7          	lui	x1,0xff010
 10000f0:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10000f4:	0f0f1137          	lui	x2,0xf0f1
 10000f8:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10000fc:	0020c733          	xor	x14,x1,x2
 1000100:	f00ffeb7          	lui	x29,0xf00ff
 1000104:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 1000108:	4189                	c.li	x3,2
 100010a:	3fd71463          	bne	x14,x29,10004f2 <fail>

0100010e <test_3>:
 100010e:	0ff010b7          	lui	x1,0xff01
 1000112:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000116:	f0f0f137          	lui	x2,0xf0f0f
 100011a:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100011e:	0020c733          	xor	x14,x1,x2
 1000122:	ff010eb7          	lui	x29,0xff010
 1000126:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 100012a:	418d                	c.li	x3,3
 100012c:	3dd71363          	bne	x14,x29,10004f2 <fail>

01000130 <test_4>:
 1000130:	00ff00b7          	lui	x1,0xff0
 1000134:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000138:	0f0f1137          	lui	x2,0xf0f1
 100013c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000140:	0020c733          	xor	x14,x1,x2
 1000144:	0ff01eb7          	lui	x29,0xff01
 1000148:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 100014c:	4191                	c.li	x3,4
 100014e:	3bd71263          	bne	x14,x29,10004f2 <fail>

01000152 <test_5>:
 1000152:	f00ff0b7          	lui	x1,0xf00ff
 1000156:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 100015a:	f0f0f137          	lui	x2,0xf0f0f
 100015e:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000162:	0020c733          	xor	x14,x1,x2
 1000166:	00ff0eb7          	lui	x29,0xff0
 100016a:	0ffe8e93          	addi	x29,x29,255 # ff00ff <_start-0xff01>
 100016e:	4195                	c.li	x3,5
 1000170:	39d71163          	bne	x14,x29,10004f2 <fail>

01000174 <test_6>:
 1000174:	ff0100b7          	lui	x1,0xff010
 1000178:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100017c:	0f0f1137          	lui	x2,0xf0f1
 1000180:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000184:	0020c0b3          	xor	x1,x1,x2
 1000188:	f00ffeb7          	lui	x29,0xf00ff
 100018c:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 1000190:	4199                	c.li	x3,6
 1000192:	37d09063          	bne	x1,x29,10004f2 <fail>

01000196 <test_7>:
 1000196:	ff0100b7          	lui	x1,0xff010
 100019a:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100019e:	0f0f1137          	lui	x2,0xf0f1
 10001a2:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10001a6:	0020c133          	xor	x2,x1,x2
 10001aa:	f00ffeb7          	lui	x29,0xf00ff
 10001ae:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 10001b2:	419d                	c.li	x3,7
 10001b4:	33d11f63          	bne	x2,x29,10004f2 <fail>

010001b8 <test_8>:
 10001b8:	ff0100b7          	lui	x1,0xff010
 10001bc:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10001c0:	0010c0b3          	xor	x1,x1,x1
 10001c4:	4e81                	c.li	x29,0
 10001c6:	41a1                	c.li	x3,8
 10001c8:	33d09563          	bne	x1,x29,10004f2 <fail>

010001cc <test_9>:
 10001cc:	4201                	c.li	x4,0
 10001ce:	ff0100b7          	lui	x1,0xff010
 10001d2:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10001d6:	0f0f1137          	lui	x2,0xf0f1
 10001da:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10001de:	0020c733          	xor	x14,x1,x2
 10001e2:	00070313          	addi	x6,x14,0
 10001e6:	0205                	c.addi	x4,1
 10001e8:	4289                	c.li	x5,2
 10001ea:	fe5212e3          	bne	x4,x5,10001ce <test_9+0x2>
 10001ee:	f00ffeb7          	lui	x29,0xf00ff
 10001f2:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 10001f6:	41a5                	c.li	x3,9
 10001f8:	2fd31d63          	bne	x6,x29,10004f2 <fail>

010001fc <test_10>:
 10001fc:	4201                	c.li	x4,0
 10001fe:	0ff010b7          	lui	x1,0xff01
 1000202:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000206:	f0f0f137          	lui	x2,0xf0f0f
 100020a:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100020e:	0020c733          	xor	x14,x1,x2
 1000212:	0001                	c.addi	x0,0
 1000214:	00070313          	addi	x6,x14,0
 1000218:	0205                	c.addi	x4,1
 100021a:	4289                	c.li	x5,2
 100021c:	fe5211e3          	bne	x4,x5,10001fe <test_10+0x2>
 1000220:	ff010eb7          	lui	x29,0xff010
 1000224:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 1000228:	41a9                	c.li	x3,10
 100022a:	2dd31463          	bne	x6,x29,10004f2 <fail>

0100022e <test_11>:
 100022e:	4201                	c.li	x4,0
 1000230:	00ff00b7          	lui	x1,0xff0
 1000234:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000238:	0f0f1137          	lui	x2,0xf0f1
 100023c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000240:	0020c733          	xor	x14,x1,x2
 1000244:	0001                	c.addi	x0,0
 1000246:	0001                	c.addi	x0,0
 1000248:	00070313          	addi	x6,x14,0
 100024c:	0205                	c.addi	x4,1
 100024e:	4289                	c.li	x5,2
 1000250:	fe5210e3          	bne	x4,x5,1000230 <test_11+0x2>
 1000254:	0ff01eb7          	lui	x29,0xff01
 1000258:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 100025c:	41ad                	c.li	x3,11
 100025e:	29d31a63          	bne	x6,x29,10004f2 <fail>

01000262 <test_12>:
 1000262:	4201                	c.li	x4,0
 1000264:	ff0100b7          	lui	x1,0xff010
 1000268:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100026c:	0f0f1137          	lui	x2,0xf0f1
 1000270:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000274:	0020c733          	xor	x14,x1,x2
 1000278:	0205                	c.addi	x4,1
 100027a:	4289                	c.li	x5,2
 100027c:	fe5214e3          	bne	x4,x5,1000264 <test_12+0x2>
 1000280:	f00ffeb7          	lui	x29,0xf00ff
 1000284:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 1000288:	41b1                	c.li	x3,12
 100028a:	27d71463          	bne	x14,x29,10004f2 <fail>

0100028e <test_13>:
 100028e:	4201                	c.li	x4,0
 1000290:	0ff010b7          	lui	x1,0xff01
 1000294:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000298:	f0f0f137          	lui	x2,0xf0f0f
 100029c:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10002a0:	0001                	c.addi	x0,0
 10002a2:	0020c733          	xor	x14,x1,x2
 10002a6:	0205                	c.addi	x4,1
 10002a8:	4289                	c.li	x5,2
 10002aa:	fe5213e3          	bne	x4,x5,1000290 <test_13+0x2>
 10002ae:	ff010eb7          	lui	x29,0xff010
 10002b2:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 10002b6:	41b5                	c.li	x3,13
 10002b8:	23d71d63          	bne	x14,x29,10004f2 <fail>

010002bc <test_14>:
 10002bc:	4201                	c.li	x4,0
 10002be:	00ff00b7          	lui	x1,0xff0
 10002c2:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10002c6:	0f0f1137          	lui	x2,0xf0f1
 10002ca:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10002ce:	0001                	c.addi	x0,0
 10002d0:	0001                	c.addi	x0,0
 10002d2:	0020c733          	xor	x14,x1,x2
 10002d6:	0205                	c.addi	x4,1
 10002d8:	4289                	c.li	x5,2
 10002da:	fe5212e3          	bne	x4,x5,10002be <test_14+0x2>
 10002de:	0ff01eb7          	lui	x29,0xff01
 10002e2:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 10002e6:	41b9                	c.li	x3,14
 10002e8:	21d71563          	bne	x14,x29,10004f2 <fail>

010002ec <test_15>:
 10002ec:	4201                	c.li	x4,0
 10002ee:	ff0100b7          	lui	x1,0xff010
 10002f2:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10002f6:	0001                	c.addi	x0,0
 10002f8:	0f0f1137          	lui	x2,0xf0f1
 10002fc:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000300:	0020c733          	xor	x14,x1,x2
 1000304:	0205                	c.addi	x4,1
 1000306:	4289                	c.li	x5,2
 1000308:	fe5213e3          	bne	x4,x5,10002ee <test_15+0x2>
 100030c:	f00ffeb7          	lui	x29,0xf00ff
 1000310:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 1000314:	41bd                	c.li	x3,15
 1000316:	1dd71e63          	bne	x14,x29,10004f2 <fail>

0100031a <test_16>:
 100031a:	4201                	c.li	x4,0
 100031c:	0ff010b7          	lui	x1,0xff01
 1000320:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000324:	0001                	c.addi	x0,0
 1000326:	f0f0f137          	lui	x2,0xf0f0f
 100032a:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100032e:	0001                	c.addi	x0,0
 1000330:	0020c733          	xor	x14,x1,x2
 1000334:	0205                	c.addi	x4,1
 1000336:	4289                	c.li	x5,2
 1000338:	fe5212e3          	bne	x4,x5,100031c <test_16+0x2>
 100033c:	ff010eb7          	lui	x29,0xff010
 1000340:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 1000344:	41c1                	c.li	x3,16
 1000346:	1bd71663          	bne	x14,x29,10004f2 <fail>

0100034a <test_17>:
 100034a:	4201                	c.li	x4,0
 100034c:	00ff00b7          	lui	x1,0xff0
 1000350:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000354:	0001                	c.addi	x0,0
 1000356:	0001                	c.addi	x0,0
 1000358:	0f0f1137          	lui	x2,0xf0f1
 100035c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000360:	0020c733          	xor	x14,x1,x2
 1000364:	0205                	c.addi	x4,1
 1000366:	4289                	c.li	x5,2
 1000368:	fe5212e3          	bne	x4,x5,100034c <test_17+0x2>
 100036c:	0ff01eb7          	lui	x29,0xff01
 1000370:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 1000374:	41c5                	c.li	x3,17
 1000376:	17d71e63          	bne	x14,x29,10004f2 <fail>

0100037a <test_18>:
 100037a:	4201                	c.li	x4,0
 100037c:	0f0f1137          	lui	x2,0xf0f1
 1000380:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000384:	ff0100b7          	lui	x1,0xff010
 1000388:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100038c:	0020c733          	xor	x14,x1,x2
 1000390:	0205                	c.addi	x4,1
 1000392:	4289                	c.li	x5,2
 1000394:	fe5214e3          	bne	x4,x5,100037c <test_18+0x2>
 1000398:	f00ffeb7          	lui	x29,0xf00ff
 100039c:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 10003a0:	41c9                	c.li	x3,18
 10003a2:	15d71863          	bne	x14,x29,10004f2 <fail>

010003a6 <test_19>:
 10003a6:	4201                	c.li	x4,0
 10003a8:	f0f0f137          	lui	x2,0xf0f0f
 10003ac:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10003b0:	0ff010b7          	lui	x1,0xff01
 10003b4:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 10003b8:	0001                	c.addi	x0,0
 10003ba:	0020c733          	xor	x14,x1,x2
 10003be:	0205                	c.addi	x4,1
 10003c0:	4289                	c.li	x5,2
 10003c2:	fe5213e3          	bne	x4,x5,10003a8 <test_19+0x2>
 10003c6:	ff010eb7          	lui	x29,0xff010
 10003ca:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 10003ce:	41cd                	c.li	x3,19
 10003d0:	13d71163          	bne	x14,x29,10004f2 <fail>

010003d4 <test_20>:
 10003d4:	4201                	c.li	x4,0
 10003d6:	0f0f1137          	lui	x2,0xf0f1
 10003da:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10003de:	00ff00b7          	lui	x1,0xff0
 10003e2:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10003e6:	0001                	c.addi	x0,0
 10003e8:	0001                	c.addi	x0,0
 10003ea:	0020c733          	xor	x14,x1,x2
 10003ee:	0205                	c.addi	x4,1
 10003f0:	4289                	c.li	x5,2
 10003f2:	fe5212e3          	bne	x4,x5,10003d6 <test_20+0x2>
 10003f6:	0ff01eb7          	lui	x29,0xff01
 10003fa:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 10003fe:	41d1                	c.li	x3,20
 1000400:	0fd71963          	bne	x14,x29,10004f2 <fail>

01000404 <test_21>:
 1000404:	4201                	c.li	x4,0
 1000406:	0f0f1137          	lui	x2,0xf0f1
 100040a:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 100040e:	0001                	c.addi	x0,0
 1000410:	ff0100b7          	lui	x1,0xff010
 1000414:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 1000418:	0020c733          	xor	x14,x1,x2
 100041c:	0205                	c.addi	x4,1
 100041e:	4289                	c.li	x5,2
 1000420:	fe5213e3          	bne	x4,x5,1000406 <test_21+0x2>
 1000424:	f00ffeb7          	lui	x29,0xf00ff
 1000428:	00fe8e93          	addi	x29,x29,15 # f00ff00f <_end+0xef0fd00f>
 100042c:	41d5                	c.li	x3,21
 100042e:	0dd71263          	bne	x14,x29,10004f2 <fail>

01000432 <test_22>:
 1000432:	4201                	c.li	x4,0
 1000434:	f0f0f137          	lui	x2,0xf0f0f
 1000438:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100043c:	0001                	c.addi	x0,0
 100043e:	0ff010b7          	lui	x1,0xff01
 1000442:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000446:	0001                	c.addi	x0,0
 1000448:	0020c733          	xor	x14,x1,x2
 100044c:	0205                	c.addi	x4,1
 100044e:	4289                	c.li	x5,2
 1000450:	fe5212e3          	bne	x4,x5,1000434 <test_22+0x2>
 1000454:	ff010eb7          	lui	x29,0xff010
 1000458:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 100045c:	41d9                	c.li	x3,22
 100045e:	09d71a63          	bne	x14,x29,10004f2 <fail>

01000462 <test_23>:
 1000462:	4201                	c.li	x4,0
 1000464:	0f0f1137          	lui	x2,0xf0f1
 1000468:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 100046c:	0001                	c.addi	x0,0
 100046e:	0001                	c.addi	x0,0
 1000470:	00ff00b7          	lui	x1,0xff0
 1000474:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000478:	0020c733          	xor	x14,x1,x2
 100047c:	0205                	c.addi	x4,1
 100047e:	4289                	c.li	x5,2
 1000480:	fe5212e3          	bne	x4,x5,1000464 <test_23+0x2>
 1000484:	0ff01eb7          	lui	x29,0xff01
 1000488:	ff0e8e93          	addi	x29,x29,-16 # ff00ff0 <_end+0xeefeff0>
 100048c:	41dd                	c.li	x3,23
 100048e:	07d71263          	bne	x14,x29,10004f2 <fail>

01000492 <test_24>:
 1000492:	ff0100b7          	lui	x1,0xff010
 1000496:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100049a:	00104133          	xor	x2,x0,x1
 100049e:	ff010eb7          	lui	x29,0xff010
 10004a2:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 10004a6:	41e1                	c.li	x3,24
 10004a8:	05d11563          	bne	x2,x29,10004f2 <fail>

010004ac <test_25>:
 10004ac:	00ff00b7          	lui	x1,0xff0
 10004b0:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10004b4:	0000c133          	xor	x2,x1,x0
 10004b8:	00ff0eb7          	lui	x29,0xff0
 10004bc:	0ffe8e93          	addi	x29,x29,255 # ff00ff <_start-0xff01>
 10004c0:	41e5                	c.li	x3,25
 10004c2:	03d11863          	bne	x2,x29,10004f2 <fail>

010004c6 <test_26>:
 10004c6:	000040b3          	xor	x1,x0,x0
 10004ca:	4e81                	c.li	x29,0
 10004cc:	41e9                	c.li	x3,26
 10004ce:	03d09263          	bne	x1,x29,10004f2 <fail>

010004d2 <test_27>:
 10004d2:	111110b7          	lui	x1,0x11111
 10004d6:	11108093          	addi	x1,x1,273 # 11111111 <_end+0x1010f111>
 10004da:	22222137          	lui	x2,0x22222
 10004de:	22210113          	addi	x2,x2,546 # 22222222 <_end+0x21220222>
 10004e2:	0020c033          	xor	x0,x1,x2
 10004e6:	4e81                	c.li	x29,0
 10004e8:	41ed                	c.li	x3,27
 10004ea:	01d01463          	bne	x0,x29,10004f2 <fail>
 10004ee:	00301b63          	bne	x0,x3,1000504 <pass>

010004f2 <fail>:
 10004f2:	0ff0000f          	fence	iorw,iorw
 10004f6:	00018063          	beq	x3,x0,10004f6 <fail+0x4>
 10004fa:	0186                	c.slli	x3,0x1
 10004fc:	0011e193          	ori	x3,x3,1
 1000500:	00000073          	ecall

01000504 <pass>:
 1000504:	0ff0000f          	fence	iorw,iorw
 1000508:	4185                	c.li	x3,1
 100050a:	00000073          	ecall
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
