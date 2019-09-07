
rv32ui/or.elf:     file format elf32-littleriscv


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
 10000fc:	0020e733          	or	x14,x1,x2
 1000100:	ff100eb7          	lui	x29,0xff100
 1000104:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 1000108:	4189                	c.li	x3,2
 100010a:	3fd71763          	bne	x14,x29,10004f8 <fail>

0100010e <test_3>:
 100010e:	0ff010b7          	lui	x1,0xff01
 1000112:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 1000116:	f0f0f137          	lui	x2,0xf0f0f
 100011a:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 100011e:	0020e733          	or	x14,x1,x2
 1000122:	fff10eb7          	lui	x29,0xfff10
 1000126:	ff0e8e93          	addi	x29,x29,-16 # fff0fff0 <_end+0xfef0dff0>
 100012a:	418d                	c.li	x3,3
 100012c:	3dd71663          	bne	x14,x29,10004f8 <fail>

01000130 <test_4>:
 1000130:	00ff00b7          	lui	x1,0xff0
 1000134:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 1000138:	0f0f1137          	lui	x2,0xf0f1
 100013c:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000140:	0020e733          	or	x14,x1,x2
 1000144:	0fff1eb7          	lui	x29,0xfff1
 1000148:	fffe8e93          	addi	x29,x29,-1 # fff0fff <_end+0xefeefff>
 100014c:	4191                	c.li	x3,4
 100014e:	3bd71563          	bne	x14,x29,10004f8 <fail>

01000152 <test_5>:
 1000152:	f00ff0b7          	lui	x1,0xf00ff
 1000156:	00f08093          	addi	x1,x1,15 # f00ff00f <_end+0xef0fd00f>
 100015a:	f0f0f137          	lui	x2,0xf0f0f
 100015e:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000162:	0020e733          	or	x14,x1,x2
 1000166:	f0fffeb7          	lui	x29,0xf0fff
 100016a:	0ffe8e93          	addi	x29,x29,255 # f0fff0ff <_end+0xefffd0ff>
 100016e:	4195                	c.li	x3,5
 1000170:	39d71463          	bne	x14,x29,10004f8 <fail>

01000174 <test_6>:
 1000174:	ff0100b7          	lui	x1,0xff010
 1000178:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100017c:	0f0f1137          	lui	x2,0xf0f1
 1000180:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000184:	0020e0b3          	or	x1,x1,x2
 1000188:	ff100eb7          	lui	x29,0xff100
 100018c:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 1000190:	4199                	c.li	x3,6
 1000192:	37d09363          	bne	x1,x29,10004f8 <fail>

01000196 <test_7>:
 1000196:	ff0100b7          	lui	x1,0xff010
 100019a:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100019e:	0f0f1137          	lui	x2,0xf0f1
 10001a2:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10001a6:	0020e133          	or	x2,x1,x2
 10001aa:	ff100eb7          	lui	x29,0xff100
 10001ae:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 10001b2:	419d                	c.li	x3,7
 10001b4:	35d11263          	bne	x2,x29,10004f8 <fail>

010001b8 <test_8>:
 10001b8:	ff0100b7          	lui	x1,0xff010
 10001bc:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10001c0:	0010e0b3          	or	x1,x1,x1
 10001c4:	ff010eb7          	lui	x29,0xff010
 10001c8:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 10001cc:	41a1                	c.li	x3,8
 10001ce:	33d09563          	bne	x1,x29,10004f8 <fail>

010001d2 <test_9>:
 10001d2:	4201                	c.li	x4,0
 10001d4:	ff0100b7          	lui	x1,0xff010
 10001d8:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10001dc:	0f0f1137          	lui	x2,0xf0f1
 10001e0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10001e4:	0020e733          	or	x14,x1,x2
 10001e8:	00070313          	addi	x6,x14,0
 10001ec:	0205                	c.addi	x4,1
 10001ee:	4289                	c.li	x5,2
 10001f0:	fe5212e3          	bne	x4,x5,10001d4 <test_9+0x2>
 10001f4:	ff100eb7          	lui	x29,0xff100
 10001f8:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 10001fc:	41a5                	c.li	x3,9
 10001fe:	2fd31d63          	bne	x6,x29,10004f8 <fail>

01000202 <test_10>:
 1000202:	4201                	c.li	x4,0
 1000204:	0ff010b7          	lui	x1,0xff01
 1000208:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100020c:	f0f0f137          	lui	x2,0xf0f0f
 1000210:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000214:	0020e733          	or	x14,x1,x2
 1000218:	0001                	c.addi	x0,0
 100021a:	00070313          	addi	x6,x14,0
 100021e:	0205                	c.addi	x4,1
 1000220:	4289                	c.li	x5,2
 1000222:	fe5211e3          	bne	x4,x5,1000204 <test_10+0x2>
 1000226:	fff10eb7          	lui	x29,0xfff10
 100022a:	ff0e8e93          	addi	x29,x29,-16 # fff0fff0 <_end+0xfef0dff0>
 100022e:	41a9                	c.li	x3,10
 1000230:	2dd31463          	bne	x6,x29,10004f8 <fail>

01000234 <test_11>:
 1000234:	4201                	c.li	x4,0
 1000236:	00ff00b7          	lui	x1,0xff0
 100023a:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100023e:	0f0f1137          	lui	x2,0xf0f1
 1000242:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000246:	0020e733          	or	x14,x1,x2
 100024a:	0001                	c.addi	x0,0
 100024c:	0001                	c.addi	x0,0
 100024e:	00070313          	addi	x6,x14,0
 1000252:	0205                	c.addi	x4,1
 1000254:	4289                	c.li	x5,2
 1000256:	fe5210e3          	bne	x4,x5,1000236 <test_11+0x2>
 100025a:	0fff1eb7          	lui	x29,0xfff1
 100025e:	fffe8e93          	addi	x29,x29,-1 # fff0fff <_end+0xefeefff>
 1000262:	41ad                	c.li	x3,11
 1000264:	29d31a63          	bne	x6,x29,10004f8 <fail>

01000268 <test_12>:
 1000268:	4201                	c.li	x4,0
 100026a:	ff0100b7          	lui	x1,0xff010
 100026e:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 1000272:	0f0f1137          	lui	x2,0xf0f1
 1000276:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 100027a:	0020e733          	or	x14,x1,x2
 100027e:	0205                	c.addi	x4,1
 1000280:	4289                	c.li	x5,2
 1000282:	fe5214e3          	bne	x4,x5,100026a <test_12+0x2>
 1000286:	ff100eb7          	lui	x29,0xff100
 100028a:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 100028e:	41b1                	c.li	x3,12
 1000290:	27d71463          	bne	x14,x29,10004f8 <fail>

01000294 <test_13>:
 1000294:	4201                	c.li	x4,0
 1000296:	0ff010b7          	lui	x1,0xff01
 100029a:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100029e:	f0f0f137          	lui	x2,0xf0f0f
 10002a2:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10002a6:	0001                	c.addi	x0,0
 10002a8:	0020e733          	or	x14,x1,x2
 10002ac:	0205                	c.addi	x4,1
 10002ae:	4289                	c.li	x5,2
 10002b0:	fe5213e3          	bne	x4,x5,1000296 <test_13+0x2>
 10002b4:	fff10eb7          	lui	x29,0xfff10
 10002b8:	ff0e8e93          	addi	x29,x29,-16 # fff0fff0 <_end+0xfef0dff0>
 10002bc:	41b5                	c.li	x3,13
 10002be:	23d71d63          	bne	x14,x29,10004f8 <fail>

010002c2 <test_14>:
 10002c2:	4201                	c.li	x4,0
 10002c4:	00ff00b7          	lui	x1,0xff0
 10002c8:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10002cc:	0f0f1137          	lui	x2,0xf0f1
 10002d0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10002d4:	0001                	c.addi	x0,0
 10002d6:	0001                	c.addi	x0,0
 10002d8:	0020e733          	or	x14,x1,x2
 10002dc:	0205                	c.addi	x4,1
 10002de:	4289                	c.li	x5,2
 10002e0:	fe5212e3          	bne	x4,x5,10002c4 <test_14+0x2>
 10002e4:	0fff1eb7          	lui	x29,0xfff1
 10002e8:	fffe8e93          	addi	x29,x29,-1 # fff0fff <_end+0xefeefff>
 10002ec:	41b9                	c.li	x3,14
 10002ee:	21d71563          	bne	x14,x29,10004f8 <fail>

010002f2 <test_15>:
 10002f2:	4201                	c.li	x4,0
 10002f4:	ff0100b7          	lui	x1,0xff010
 10002f8:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10002fc:	0001                	c.addi	x0,0
 10002fe:	0f0f1137          	lui	x2,0xf0f1
 1000302:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000306:	0020e733          	or	x14,x1,x2
 100030a:	0205                	c.addi	x4,1
 100030c:	4289                	c.li	x5,2
 100030e:	fe5213e3          	bne	x4,x5,10002f4 <test_15+0x2>
 1000312:	ff100eb7          	lui	x29,0xff100
 1000316:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 100031a:	41bd                	c.li	x3,15
 100031c:	1dd71e63          	bne	x14,x29,10004f8 <fail>

01000320 <test_16>:
 1000320:	4201                	c.li	x4,0
 1000322:	0ff010b7          	lui	x1,0xff01
 1000326:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100032a:	0001                	c.addi	x0,0
 100032c:	f0f0f137          	lui	x2,0xf0f0f
 1000330:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000334:	0001                	c.addi	x0,0
 1000336:	0020e733          	or	x14,x1,x2
 100033a:	0205                	c.addi	x4,1
 100033c:	4289                	c.li	x5,2
 100033e:	fe5212e3          	bne	x4,x5,1000322 <test_16+0x2>
 1000342:	fff10eb7          	lui	x29,0xfff10
 1000346:	ff0e8e93          	addi	x29,x29,-16 # fff0fff0 <_end+0xfef0dff0>
 100034a:	41c1                	c.li	x3,16
 100034c:	1bd71663          	bne	x14,x29,10004f8 <fail>

01000350 <test_17>:
 1000350:	4201                	c.li	x4,0
 1000352:	00ff00b7          	lui	x1,0xff0
 1000356:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100035a:	0001                	c.addi	x0,0
 100035c:	0001                	c.addi	x0,0
 100035e:	0f0f1137          	lui	x2,0xf0f1
 1000362:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000366:	0020e733          	or	x14,x1,x2
 100036a:	0205                	c.addi	x4,1
 100036c:	4289                	c.li	x5,2
 100036e:	fe5212e3          	bne	x4,x5,1000352 <test_17+0x2>
 1000372:	0fff1eb7          	lui	x29,0xfff1
 1000376:	fffe8e93          	addi	x29,x29,-1 # fff0fff <_end+0xefeefff>
 100037a:	41c5                	c.li	x3,17
 100037c:	17d71e63          	bne	x14,x29,10004f8 <fail>

01000380 <test_18>:
 1000380:	4201                	c.li	x4,0
 1000382:	0f0f1137          	lui	x2,0xf0f1
 1000386:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 100038a:	ff0100b7          	lui	x1,0xff010
 100038e:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 1000392:	0020e733          	or	x14,x1,x2
 1000396:	0205                	c.addi	x4,1
 1000398:	4289                	c.li	x5,2
 100039a:	fe5214e3          	bne	x4,x5,1000382 <test_18+0x2>
 100039e:	ff100eb7          	lui	x29,0xff100
 10003a2:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 10003a6:	41c9                	c.li	x3,18
 10003a8:	15d71863          	bne	x14,x29,10004f8 <fail>

010003ac <test_19>:
 10003ac:	4201                	c.li	x4,0
 10003ae:	f0f0f137          	lui	x2,0xf0f0f
 10003b2:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 10003b6:	0ff010b7          	lui	x1,0xff01
 10003ba:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 10003be:	0001                	c.addi	x0,0
 10003c0:	0020e733          	or	x14,x1,x2
 10003c4:	0205                	c.addi	x4,1
 10003c6:	4289                	c.li	x5,2
 10003c8:	fe5213e3          	bne	x4,x5,10003ae <test_19+0x2>
 10003cc:	fff10eb7          	lui	x29,0xfff10
 10003d0:	ff0e8e93          	addi	x29,x29,-16 # fff0fff0 <_end+0xfef0dff0>
 10003d4:	41cd                	c.li	x3,19
 10003d6:	13d71163          	bne	x14,x29,10004f8 <fail>

010003da <test_20>:
 10003da:	4201                	c.li	x4,0
 10003dc:	0f0f1137          	lui	x2,0xf0f1
 10003e0:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 10003e4:	00ff00b7          	lui	x1,0xff0
 10003e8:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10003ec:	0001                	c.addi	x0,0
 10003ee:	0001                	c.addi	x0,0
 10003f0:	0020e733          	or	x14,x1,x2
 10003f4:	0205                	c.addi	x4,1
 10003f6:	4289                	c.li	x5,2
 10003f8:	fe5212e3          	bne	x4,x5,10003dc <test_20+0x2>
 10003fc:	0fff1eb7          	lui	x29,0xfff1
 1000400:	fffe8e93          	addi	x29,x29,-1 # fff0fff <_end+0xefeefff>
 1000404:	41d1                	c.li	x3,20
 1000406:	0fd71963          	bne	x14,x29,10004f8 <fail>

0100040a <test_21>:
 100040a:	4201                	c.li	x4,0
 100040c:	0f0f1137          	lui	x2,0xf0f1
 1000410:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000414:	0001                	c.addi	x0,0
 1000416:	ff0100b7          	lui	x1,0xff010
 100041a:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 100041e:	0020e733          	or	x14,x1,x2
 1000422:	0205                	c.addi	x4,1
 1000424:	4289                	c.li	x5,2
 1000426:	fe5213e3          	bne	x4,x5,100040c <test_21+0x2>
 100042a:	ff100eb7          	lui	x29,0xff100
 100042e:	f0fe8e93          	addi	x29,x29,-241 # ff0fff0f <_end+0xfe0fdf0f>
 1000432:	41d5                	c.li	x3,21
 1000434:	0dd71263          	bne	x14,x29,10004f8 <fail>

01000438 <test_22>:
 1000438:	4201                	c.li	x4,0
 100043a:	f0f0f137          	lui	x2,0xf0f0f
 100043e:	0f010113          	addi	x2,x2,240 # f0f0f0f0 <_end+0xeff0d0f0>
 1000442:	0001                	c.addi	x0,0
 1000444:	0ff010b7          	lui	x1,0xff01
 1000448:	ff008093          	addi	x1,x1,-16 # ff00ff0 <_end+0xeefeff0>
 100044c:	0001                	c.addi	x0,0
 100044e:	0020e733          	or	x14,x1,x2
 1000452:	0205                	c.addi	x4,1
 1000454:	4289                	c.li	x5,2
 1000456:	fe5212e3          	bne	x4,x5,100043a <test_22+0x2>
 100045a:	fff10eb7          	lui	x29,0xfff10
 100045e:	ff0e8e93          	addi	x29,x29,-16 # fff0fff0 <_end+0xfef0dff0>
 1000462:	41d9                	c.li	x3,22
 1000464:	09d71a63          	bne	x14,x29,10004f8 <fail>

01000468 <test_23>:
 1000468:	4201                	c.li	x4,0
 100046a:	0f0f1137          	lui	x2,0xf0f1
 100046e:	f0f10113          	addi	x2,x2,-241 # f0f0f0f <_end+0xe0eef0f>
 1000472:	0001                	c.addi	x0,0
 1000474:	0001                	c.addi	x0,0
 1000476:	00ff00b7          	lui	x1,0xff0
 100047a:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 100047e:	0020e733          	or	x14,x1,x2
 1000482:	0205                	c.addi	x4,1
 1000484:	4289                	c.li	x5,2
 1000486:	fe5212e3          	bne	x4,x5,100046a <test_23+0x2>
 100048a:	0fff1eb7          	lui	x29,0xfff1
 100048e:	fffe8e93          	addi	x29,x29,-1 # fff0fff <_end+0xefeefff>
 1000492:	41dd                	c.li	x3,23
 1000494:	07d71263          	bne	x14,x29,10004f8 <fail>

01000498 <test_24>:
 1000498:	ff0100b7          	lui	x1,0xff010
 100049c:	f0008093          	addi	x1,x1,-256 # ff00ff00 <_end+0xfe00df00>
 10004a0:	00106133          	or	x2,x0,x1
 10004a4:	ff010eb7          	lui	x29,0xff010
 10004a8:	f00e8e93          	addi	x29,x29,-256 # ff00ff00 <_end+0xfe00df00>
 10004ac:	41e1                	c.li	x3,24
 10004ae:	05d11563          	bne	x2,x29,10004f8 <fail>

010004b2 <test_25>:
 10004b2:	00ff00b7          	lui	x1,0xff0
 10004b6:	0ff08093          	addi	x1,x1,255 # ff00ff <_start-0xff01>
 10004ba:	0000e133          	or	x2,x1,x0
 10004be:	00ff0eb7          	lui	x29,0xff0
 10004c2:	0ffe8e93          	addi	x29,x29,255 # ff00ff <_start-0xff01>
 10004c6:	41e5                	c.li	x3,25
 10004c8:	03d11863          	bne	x2,x29,10004f8 <fail>

010004cc <test_26>:
 10004cc:	000060b3          	or	x1,x0,x0
 10004d0:	4e81                	c.li	x29,0
 10004d2:	41e9                	c.li	x3,26
 10004d4:	03d09263          	bne	x1,x29,10004f8 <fail>

010004d8 <test_27>:
 10004d8:	111110b7          	lui	x1,0x11111
 10004dc:	11108093          	addi	x1,x1,273 # 11111111 <_end+0x1010f111>
 10004e0:	22222137          	lui	x2,0x22222
 10004e4:	22210113          	addi	x2,x2,546 # 22222222 <_end+0x21220222>
 10004e8:	0020e033          	or	x0,x1,x2
 10004ec:	4e81                	c.li	x29,0
 10004ee:	41ed                	c.li	x3,27
 10004f0:	01d01463          	bne	x0,x29,10004f8 <fail>
 10004f4:	00301b63          	bne	x0,x3,100050a <pass>

010004f8 <fail>:
 10004f8:	0ff0000f          	fence	iorw,iorw
 10004fc:	00018063          	beq	x3,x0,10004fc <fail+0x4>
 1000500:	0186                	c.slli	x3,0x1
 1000502:	0011e193          	ori	x3,x3,1
 1000506:	00000073          	ecall

0100050a <pass>:
 100050a:	0ff0000f          	fence	iorw,iorw
 100050e:	4185                	c.li	x3,1
 1000510:	00000073          	ecall
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
