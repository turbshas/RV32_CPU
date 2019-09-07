
rv32ui/and.elf:     file format elf32-littleriscv


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
 10000fc:	0020f733          	and	x14,x1,x2
 1000100:	0f001eb7          	lui	x29,0xf001
 1000104:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 1000108:	4189                	c.li	x3,2
 100010a:	3dd71f63          	bne	x14,x29,10004e8 <fail>

0100010e <test_3>:
 100010e:	0ff010b7          	lui	x1,0xff01
 1000112:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000116:	f0f0f137          	lui	x2,0xf0f0f
 100011a:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100011e:	0020f733          	and	x14,x1,x2
 1000122:	00f00eb7          	lui	x29,0xf00
 1000126:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 100012a:	418d                	c.li	x3,3
 100012c:	3bd71e63          	bne	x14,x29,10004e8 <fail>

01000130 <test_4>:
 1000130:	00ff00b7          	lui	x1,0xff0
 1000134:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000138:	0f0f1137          	lui	x2,0xf0f1
 100013c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000140:	0020f733          	and	x14,x1,x2
 1000144:	000f0eb7          	lui	x29,0xf0
 1000148:	00fe8e93          	addi	x29,x29,15 # f000f <_start-0xf0fff1>
 100014c:	4191                	c.li	x3,4
 100014e:	39d71d63          	bne	x14,x29,10004e8 <fail>

01000152 <test_5>:
 1000152:	f00ff0b7          	lui	x1,0xf00ff
 1000156:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 100015a:	f0f0f137          	lui	x2,0xf0f0f
 100015e:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000162:	0020f733          	and	x14,x1,x2
 1000166:	f000feb7          	lui	x29,0xf000f
 100016a:	4195                	c.li	x3,5
 100016c:	37d71e63          	bne	x14,x29,10004e8 <fail>

01000170 <test_6>:
 1000170:	ff0100b7          	lui	x1,0xff010
 1000174:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 1000178:	0f0f1137          	lui	x2,0xf0f1
 100017c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000180:	0020f0b3          	and	x1,x1,x2
 1000184:	0f001eb7          	lui	x29,0xf001
 1000188:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 100018c:	4199                	c.li	x3,6
 100018e:	35d09d63          	bne	x1,x29,10004e8 <fail>

01000192 <test_7>:
 1000192:	0ff010b7          	lui	x1,0xff01
 1000196:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100019a:	f0f0f137          	lui	x2,0xf0f0f
 100019e:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10001a2:	0020f133          	and	x2,x1,x2
 10001a6:	00f00eb7          	lui	x29,0xf00
 10001aa:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 10001ae:	419d                	c.li	x3,7
 10001b0:	33d11c63          	bne	x2,x29,10004e8 <fail>

010001b4 <test_8>:
 10001b4:	ff0100b7          	lui	x1,0xff010
 10001b8:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10001bc:	0010f0b3          	and	x1,x1,x1
 10001c0:	ff010eb7          	lui	x29,0xff010
 10001c4:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 10001c8:	41a1                	c.li	x3,8
 10001ca:	31d09f63          	bne	x1,x29,10004e8 <fail>

010001ce <test_9>:
 10001ce:	4201                	c.li	x4,0
 10001d0:	ff0100b7          	lui	x1,0xff010
 10001d4:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10001d8:	0f0f1137          	lui	x2,0xf0f1
 10001dc:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10001e0:	0020f733          	and	x14,x1,x2
 10001e4:	00070313          	addi	x6,x14,0
 10001e8:	0205                	c.addi	x4,1
 10001ea:	4289                	c.li	x5,2
 10001ec:	fe5212e3          	bne	x4,x5,10001d0 <test_9+0x2>
 10001f0:	0f001eb7          	lui	x29,0xf001
 10001f4:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 10001f8:	41a5                	c.li	x3,9
 10001fa:	2fd31763          	bne	x6,x29,10004e8 <fail>

010001fe <test_10>:
 10001fe:	4201                	c.li	x4,0
 1000200:	0ff010b7          	lui	x1,0xff01
 1000204:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000208:	f0f0f137          	lui	x2,0xf0f0f
 100020c:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000210:	0020f733          	and	x14,x1,x2
 1000214:	0001                	c.addi	x0,0
 1000216:	00070313          	addi	x6,x14,0
 100021a:	0205                	c.addi	x4,1
 100021c:	4289                	c.li	x5,2
 100021e:	fe5211e3          	bne	x4,x5,1000200 <test_10+0x2>
 1000222:	00f00eb7          	lui	x29,0xf00
 1000226:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 100022a:	41a9                	c.li	x3,10
 100022c:	2bd31e63          	bne	x6,x29,10004e8 <fail>

01000230 <test_11>:
 1000230:	4201                	c.li	x4,0
 1000232:	00ff00b7          	lui	x1,0xff0
 1000236:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100023a:	0f0f1137          	lui	x2,0xf0f1
 100023e:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000242:	0020f733          	and	x14,x1,x2
 1000246:	0001                	c.addi	x0,0
 1000248:	0001                	c.addi	x0,0
 100024a:	00070313          	addi	x6,x14,0
 100024e:	0205                	c.addi	x4,1
 1000250:	4289                	c.li	x5,2
 1000252:	fe5210e3          	bne	x4,x5,1000232 <test_11+0x2>
 1000256:	000f0eb7          	lui	x29,0xf0
 100025a:	00fe8e93          	addi	x29,x29,15 # f000f <_start-0xf0fff1>
 100025e:	41ad                	c.li	x3,11
 1000260:	29d31463          	bne	x6,x29,10004e8 <fail>

01000264 <test_12>:
 1000264:	4201                	c.li	x4,0
 1000266:	ff0100b7          	lui	x1,0xff010
 100026a:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100026e:	0f0f1137          	lui	x2,0xf0f1
 1000272:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000276:	0020f733          	and	x14,x1,x2
 100027a:	0205                	c.addi	x4,1
 100027c:	4289                	c.li	x5,2
 100027e:	fe5214e3          	bne	x4,x5,1000266 <test_12+0x2>
 1000282:	0f001eb7          	lui	x29,0xf001
 1000286:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 100028a:	41b1                	c.li	x3,12
 100028c:	25d71e63          	bne	x14,x29,10004e8 <fail>

01000290 <test_13>:
 1000290:	4201                	c.li	x4,0
 1000292:	0ff010b7          	lui	x1,0xff01
 1000296:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100029a:	f0f0f137          	lui	x2,0xf0f0f
 100029e:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10002a2:	0001                	c.addi	x0,0
 10002a4:	0020f733          	and	x14,x1,x2
 10002a8:	0205                	c.addi	x4,1
 10002aa:	4289                	c.li	x5,2
 10002ac:	fe5213e3          	bne	x4,x5,1000292 <test_13+0x2>
 10002b0:	00f00eb7          	lui	x29,0xf00
 10002b4:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 10002b8:	41b5                	c.li	x3,13
 10002ba:	23d71763          	bne	x14,x29,10004e8 <fail>

010002be <test_14>:
 10002be:	4201                	c.li	x4,0
 10002c0:	00ff00b7          	lui	x1,0xff0
 10002c4:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10002c8:	0f0f1137          	lui	x2,0xf0f1
 10002cc:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10002d0:	0001                	c.addi	x0,0
 10002d2:	0001                	c.addi	x0,0
 10002d4:	0020f733          	and	x14,x1,x2
 10002d8:	0205                	c.addi	x4,1
 10002da:	4289                	c.li	x5,2
 10002dc:	fe5212e3          	bne	x4,x5,10002c0 <test_14+0x2>
 10002e0:	000f0eb7          	lui	x29,0xf0
 10002e4:	00fe8e93          	addi	x29,x29,15 # f000f <_start-0xf0fff1>
 10002e8:	41b9                	c.li	x3,14
 10002ea:	1fd71f63          	bne	x14,x29,10004e8 <fail>

010002ee <test_15>:
 10002ee:	4201                	c.li	x4,0
 10002f0:	ff0100b7          	lui	x1,0xff010
 10002f4:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10002f8:	0001                	c.addi	x0,0
 10002fa:	0f0f1137          	lui	x2,0xf0f1
 10002fe:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000302:	0020f733          	and	x14,x1,x2
 1000306:	0205                	c.addi	x4,1
 1000308:	4289                	c.li	x5,2
 100030a:	fe5213e3          	bne	x4,x5,10002f0 <test_15+0x2>
 100030e:	0f001eb7          	lui	x29,0xf001
 1000312:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 1000316:	41bd                	c.li	x3,15
 1000318:	1dd71863          	bne	x14,x29,10004e8 <fail>

0100031c <test_16>:
 100031c:	4201                	c.li	x4,0
 100031e:	0ff010b7          	lui	x1,0xff01
 1000322:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000326:	0001                	c.addi	x0,0
 1000328:	f0f0f137          	lui	x2,0xf0f0f
 100032c:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000330:	0001                	c.addi	x0,0
 1000332:	0020f733          	and	x14,x1,x2
 1000336:	0205                	c.addi	x4,1
 1000338:	4289                	c.li	x5,2
 100033a:	fe5212e3          	bne	x4,x5,100031e <test_16+0x2>
 100033e:	00f00eb7          	lui	x29,0xf00
 1000342:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 1000346:	41c1                	c.li	x3,16
 1000348:	1bd71063          	bne	x14,x29,10004e8 <fail>

0100034c <test_17>:
 100034c:	4201                	c.li	x4,0
 100034e:	00ff00b7          	lui	x1,0xff0
 1000352:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000356:	0001                	c.addi	x0,0
 1000358:	0001                	c.addi	x0,0
 100035a:	0f0f1137          	lui	x2,0xf0f1
 100035e:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000362:	0020f733          	and	x14,x1,x2
 1000366:	0205                	c.addi	x4,1
 1000368:	4289                	c.li	x5,2
 100036a:	fe5212e3          	bne	x4,x5,100034e <test_17+0x2>
 100036e:	000f0eb7          	lui	x29,0xf0
 1000372:	00fe8e93          	addi	x29,x29,15 # f000f <_start-0xf0fff1>
 1000376:	41c5                	c.li	x3,17
 1000378:	17d71863          	bne	x14,x29,10004e8 <fail>

0100037c <test_18>:
 100037c:	4201                	c.li	x4,0
 100037e:	0f0f1137          	lui	x2,0xf0f1
 1000382:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000386:	ff0100b7          	lui	x1,0xff010
 100038a:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100038e:	0020f733          	and	x14,x1,x2
 1000392:	0205                	c.addi	x4,1
 1000394:	4289                	c.li	x5,2
 1000396:	fe5214e3          	bne	x4,x5,100037e <test_18+0x2>
 100039a:	0f001eb7          	lui	x29,0xf001
 100039e:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 10003a2:	41c9                	c.li	x3,18
 10003a4:	15d71263          	bne	x14,x29,10004e8 <fail>

010003a8 <test_19>:
 10003a8:	4201                	c.li	x4,0
 10003aa:	f0f0f137          	lui	x2,0xf0f0f
 10003ae:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10003b2:	0ff010b7          	lui	x1,0xff01
 10003b6:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 10003ba:	0001                	c.addi	x0,0
 10003bc:	0020f733          	and	x14,x1,x2
 10003c0:	0205                	c.addi	x4,1
 10003c2:	4289                	c.li	x5,2
 10003c4:	fe5213e3          	bne	x4,x5,10003aa <test_19+0x2>
 10003c8:	00f00eb7          	lui	x29,0xf00
 10003cc:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 10003d0:	41cd                	c.li	x3,19
 10003d2:	11d71b63          	bne	x14,x29,10004e8 <fail>

010003d6 <test_20>:
 10003d6:	4201                	c.li	x4,0
 10003d8:	0f0f1137          	lui	x2,0xf0f1
 10003dc:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10003e0:	00ff00b7          	lui	x1,0xff0
 10003e4:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10003e8:	0001                	c.addi	x0,0
 10003ea:	0001                	c.addi	x0,0
 10003ec:	0020f733          	and	x14,x1,x2
 10003f0:	0205                	c.addi	x4,1
 10003f2:	4289                	c.li	x5,2
 10003f4:	fe5212e3          	bne	x4,x5,10003d8 <test_20+0x2>
 10003f8:	000f0eb7          	lui	x29,0xf0
 10003fc:	00fe8e93          	addi	x29,x29,15 # f000f <_start-0xf0fff1>
 1000400:	41d1                	c.li	x3,20
 1000402:	0fd71363          	bne	x14,x29,10004e8 <fail>

01000406 <test_21>:
 1000406:	4201                	c.li	x4,0
 1000408:	0f0f1137          	lui	x2,0xf0f1
 100040c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000410:	0001                	c.addi	x0,0
 1000412:	ff0100b7          	lui	x1,0xff010
 1000416:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100041a:	0020f733          	and	x14,x1,x2
 100041e:	0205                	c.addi	x4,1
 1000420:	4289                	c.li	x5,2
 1000422:	fe5213e3          	bne	x4,x5,1000408 <test_21+0x2>
 1000426:	0f001eb7          	lui	x29,0xf001
 100042a:	f00e8e93          	addi	x29,x29,-256 # f000f00 <_end+0xdffef00>
 100042e:	41d5                	c.li	x3,21
 1000430:	0bd71c63          	bne	x14,x29,10004e8 <fail>

01000434 <test_22>:
 1000434:	4201                	c.li	x4,0
 1000436:	f0f0f137          	lui	x2,0xf0f0f
 100043a:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100043e:	0001                	c.addi	x0,0
 1000440:	0ff010b7          	lui	x1,0xff01
 1000444:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000448:	0001                	c.addi	x0,0
 100044a:	0020f733          	and	x14,x1,x2
 100044e:	0205                	c.addi	x4,1
 1000450:	4289                	c.li	x5,2
 1000452:	fe5212e3          	bne	x4,x5,1000436 <test_22+0x2>
 1000456:	00f00eb7          	lui	x29,0xf00
 100045a:	0f0e8e93          	addi	x29,x29,240 # f000f0 <_start-0xfff10>
 100045e:	41d9                	c.li	x3,22
 1000460:	09d71463          	bne	x14,x29,10004e8 <fail>

01000464 <test_23>:
 1000464:	4201                	c.li	x4,0
 1000466:	0f0f1137          	lui	x2,0xf0f1
 100046a:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 100046e:	0001                	c.addi	x0,0
 1000470:	0001                	c.addi	x0,0
 1000472:	00ff00b7          	lui	x1,0xff0
 1000476:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100047a:	0020f733          	and	x14,x1,x2
 100047e:	0205                	c.addi	x4,1
 1000480:	4289                	c.li	x5,2
 1000482:	fe5212e3          	bne	x4,x5,1000466 <test_23+0x2>
 1000486:	000f0eb7          	lui	x29,0xf0
 100048a:	00fe8e93          	addi	x29,x29,15 # f000f <_start-0xf0fff1>
 100048e:	41dd                	c.li	x3,23
 1000490:	05d71c63          	bne	x14,x29,10004e8 <fail>

01000494 <test_24>:
 1000494:	ff0100b7          	lui	x1,0xff010
 1000498:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100049c:	00107133          	and	x2,x0,x1
 10004a0:	4e81                	c.li	x29,0
 10004a2:	41e1                	c.li	x3,24
 10004a4:	05d11263          	bne	x2,x29,10004e8 <fail>

010004a8 <test_25>:
 10004a8:	00ff00b7          	lui	x1,0xff0
 10004ac:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10004b0:	0000f133          	and	x2,x1,x0
 10004b4:	4e81                	c.li	x29,0
 10004b6:	41e5                	c.li	x3,25
 10004b8:	03d11863          	bne	x2,x29,10004e8 <fail>

010004bc <test_26>:
 10004bc:	000070b3          	and	x1,x0,x0
 10004c0:	4e81                	c.li	x29,0
 10004c2:	41e9                	c.li	x3,26
 10004c4:	03d09263          	bne	x1,x29,10004e8 <fail>

010004c8 <test_27>:
 10004c8:	111110b7          	lui	x1,0x11111
 10004cc:	11108093          	addi	x1,x1,273 # 11111111 <_end+0x1010f111>
 10004d0:	22222137          	lui	x2,0x22222
 10004d4:	22210113          	addi	x2,x2,546 # 22222222 <_end+0x21220222>
 10004d8:	0020f033          	and	x0,x1,x2
 10004dc:	4e81                	c.li	x29,0
 10004de:	41ed                	c.li	x3,27
 10004e0:	01d01463          	bne	x0,x29,10004e8 <fail>
 10004e4:	00301b63          	bne	x0,x3,10004fa <pass>

010004e8 <fail>:
 10004e8:	0ff0000f          	fence	iorw,iorw
 10004ec:	00018063          	beq	x3,x0,10004ec <fail+0x4>
 10004f0:	0186                	c.slli	x3,0x1
 10004f2:	0011e193          	ori	x3,x3,1
 10004f6:	00000073          	ecall

010004fa <pass>:
 10004fa:	0ff0000f          	fence	iorw,iorw
 10004fe:	4185                	c.li	x3,1
 1000500:	00000073          	ecall
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
