
rv32ui/srl.elf:     file format elf32-littleriscv


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
 10000ec:	800000b7          	lui	x1,0x80000
 10000f0:	4101                	c.li	x2,0
 10000f2:	0020d733          	srl	x14,x1,x2
 10000f6:	80000eb7          	lui	x29,0x80000
 10000fa:	4189                	c.li	x3,2
 10000fc:	45d71d63          	bne	x14,x29,1000556 <fail>

01000100 <test_3>:
 1000100:	800000b7          	lui	x1,0x80000
 1000104:	4105                	c.li	x2,1
 1000106:	0020d733          	srl	x14,x1,x2
 100010a:	40000eb7          	lui	x29,0x40000
 100010e:	418d                	c.li	x3,3
 1000110:	45d71363          	bne	x14,x29,1000556 <fail>

01000114 <test_4>:
 1000114:	800000b7          	lui	x1,0x80000
 1000118:	411d                	c.li	x2,7
 100011a:	0020d733          	srl	x14,x1,x2
 100011e:	01000eb7          	lui	x29,0x1000
 1000122:	4191                	c.li	x3,4
 1000124:	43d71963          	bne	x14,x29,1000556 <fail>

01000128 <test_5>:
 1000128:	800000b7          	lui	x1,0x80000
 100012c:	4139                	c.li	x2,14
 100012e:	0020d733          	srl	x14,x1,x2
 1000132:	00020eb7          	lui	x29,0x20
 1000136:	4195                	c.li	x3,5
 1000138:	41d71f63          	bne	x14,x29,1000556 <fail>

0100013c <test_6>:
 100013c:	800000b7          	lui	x1,0x80000
 1000140:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 1000144:	417d                	c.li	x2,31
 1000146:	0020d733          	srl	x14,x1,x2
 100014a:	4e85                	c.li	x29,1
 100014c:	4199                	c.li	x3,6
 100014e:	41d71463          	bne	x14,x29,1000556 <fail>

01000152 <test_7>:
 1000152:	fff00093          	addi	x1,x0,-1
 1000156:	4101                	c.li	x2,0
 1000158:	0020d733          	srl	x14,x1,x2
 100015c:	fff00e93          	addi	x29,x0,-1
 1000160:	419d                	c.li	x3,7
 1000162:	3fd71a63          	bne	x14,x29,1000556 <fail>

01000166 <test_8>:
 1000166:	fff00093          	addi	x1,x0,-1
 100016a:	4105                	c.li	x2,1
 100016c:	0020d733          	srl	x14,x1,x2
 1000170:	80000eb7          	lui	x29,0x80000
 1000174:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 1000178:	41a1                	c.li	x3,8
 100017a:	3dd71e63          	bne	x14,x29,1000556 <fail>

0100017e <test_9>:
 100017e:	fff00093          	addi	x1,x0,-1
 1000182:	411d                	c.li	x2,7
 1000184:	0020d733          	srl	x14,x1,x2
 1000188:	02000eb7          	lui	x29,0x2000
 100018c:	fffe8e93          	addi	x29,x29,-1 # 1ffffff <_end+0xffdfff>
 1000190:	41a5                	c.li	x3,9
 1000192:	3dd71263          	bne	x14,x29,1000556 <fail>

01000196 <test_10>:
 1000196:	fff00093          	addi	x1,x0,-1
 100019a:	4139                	c.li	x2,14
 100019c:	0020d733          	srl	x14,x1,x2
 10001a0:	00040eb7          	lui	x29,0x40
 10001a4:	fffe8e93          	addi	x29,x29,-1 # 3ffff <_start-0xfc0001>
 10001a8:	41a9                	c.li	x3,10
 10001aa:	3bd71663          	bne	x14,x29,1000556 <fail>

010001ae <test_11>:
 10001ae:	fff00093          	addi	x1,x0,-1
 10001b2:	417d                	c.li	x2,31
 10001b4:	0020d733          	srl	x14,x1,x2
 10001b8:	4e85                	c.li	x29,1
 10001ba:	41ad                	c.li	x3,11
 10001bc:	39d71d63          	bne	x14,x29,1000556 <fail>

010001c0 <test_12>:
 10001c0:	212120b7          	lui	x1,0x21212
 10001c4:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001c8:	4101                	c.li	x2,0
 10001ca:	0020d733          	srl	x14,x1,x2
 10001ce:	21212eb7          	lui	x29,0x21212
 10001d2:	121e8e93          	addi	x29,x29,289 # 21212121 <_end+0x20210121>
 10001d6:	41b1                	c.li	x3,12
 10001d8:	37d71f63          	bne	x14,x29,1000556 <fail>

010001dc <test_13>:
 10001dc:	212120b7          	lui	x1,0x21212
 10001e0:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001e4:	4105                	c.li	x2,1
 10001e6:	0020d733          	srl	x14,x1,x2
 10001ea:	10909eb7          	lui	x29,0x10909
 10001ee:	090e8e93          	addi	x29,x29,144 # 10909090 <_end+0xf907090>
 10001f2:	41b5                	c.li	x3,13
 10001f4:	37d71163          	bne	x14,x29,1000556 <fail>

010001f8 <test_14>:
 10001f8:	212120b7          	lui	x1,0x21212
 10001fc:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000200:	411d                	c.li	x2,7
 1000202:	0020d733          	srl	x14,x1,x2
 1000206:	00424eb7          	lui	x29,0x424
 100020a:	242e8e93          	addi	x29,x29,578 # 424242 <_start-0xbdbdbe>
 100020e:	41b9                	c.li	x3,14
 1000210:	35d71363          	bne	x14,x29,1000556 <fail>

01000214 <test_15>:
 1000214:	212120b7          	lui	x1,0x21212
 1000218:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100021c:	4139                	c.li	x2,14
 100021e:	0020d733          	srl	x14,x1,x2
 1000222:	00008eb7          	lui	x29,0x8
 1000226:	484e8e93          	addi	x29,x29,1156 # 8484 <_start-0xff7b7c>
 100022a:	41bd                	c.li	x3,15
 100022c:	33d71563          	bne	x14,x29,1000556 <fail>

01000230 <test_16>:
 1000230:	212120b7          	lui	x1,0x21212
 1000234:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000238:	417d                	c.li	x2,31
 100023a:	0020d733          	srl	x14,x1,x2
 100023e:	4e81                	c.li	x29,0
 1000240:	41c1                	c.li	x3,16
 1000242:	31d71a63          	bne	x14,x29,1000556 <fail>

01000246 <test_17>:
 1000246:	212120b7          	lui	x1,0x21212
 100024a:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100024e:	fc000113          	addi	x2,x0,-64
 1000252:	0020d733          	srl	x14,x1,x2
 1000256:	21212eb7          	lui	x29,0x21212
 100025a:	121e8e93          	addi	x29,x29,289 # 21212121 <_end+0x20210121>
 100025e:	41c5                	c.li	x3,17
 1000260:	2fd71b63          	bne	x14,x29,1000556 <fail>

01000264 <test_18>:
 1000264:	212120b7          	lui	x1,0x21212
 1000268:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100026c:	fc100113          	addi	x2,x0,-63
 1000270:	0020d733          	srl	x14,x1,x2
 1000274:	10909eb7          	lui	x29,0x10909
 1000278:	090e8e93          	addi	x29,x29,144 # 10909090 <_end+0xf907090>
 100027c:	41c9                	c.li	x3,18
 100027e:	2dd71c63          	bne	x14,x29,1000556 <fail>

01000282 <test_19>:
 1000282:	212120b7          	lui	x1,0x21212
 1000286:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100028a:	fc700113          	addi	x2,x0,-57
 100028e:	0020d733          	srl	x14,x1,x2
 1000292:	00424eb7          	lui	x29,0x424
 1000296:	242e8e93          	addi	x29,x29,578 # 424242 <_start-0xbdbdbe>
 100029a:	41cd                	c.li	x3,19
 100029c:	2bd71d63          	bne	x14,x29,1000556 <fail>

010002a0 <test_20>:
 10002a0:	212120b7          	lui	x1,0x21212
 10002a4:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10002a8:	fce00113          	addi	x2,x0,-50
 10002ac:	0020d733          	srl	x14,x1,x2
 10002b0:	00008eb7          	lui	x29,0x8
 10002b4:	484e8e93          	addi	x29,x29,1156 # 8484 <_start-0xff7b7c>
 10002b8:	41d1                	c.li	x3,20
 10002ba:	29d71e63          	bne	x14,x29,1000556 <fail>

010002be <test_21>:
 10002be:	212120b7          	lui	x1,0x21212
 10002c2:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10002c6:	fff00113          	addi	x2,x0,-1
 10002ca:	0020d733          	srl	x14,x1,x2
 10002ce:	4e81                	c.li	x29,0
 10002d0:	41d5                	c.li	x3,21
 10002d2:	29d71263          	bne	x14,x29,1000556 <fail>

010002d6 <test_22>:
 10002d6:	800000b7          	lui	x1,0x80000
 10002da:	411d                	c.li	x2,7
 10002dc:	0020d0b3          	srl	x1,x1,x2
 10002e0:	01000eb7          	lui	x29,0x1000
 10002e4:	41d9                	c.li	x3,22
 10002e6:	27d09863          	bne	x1,x29,1000556 <fail>

010002ea <test_23>:
 10002ea:	800000b7          	lui	x1,0x80000
 10002ee:	4139                	c.li	x2,14
 10002f0:	0020d133          	srl	x2,x1,x2
 10002f4:	00020eb7          	lui	x29,0x20
 10002f8:	41dd                	c.li	x3,23
 10002fa:	25d11e63          	bne	x2,x29,1000556 <fail>

010002fe <test_24>:
 10002fe:	409d                	c.li	x1,7
 1000300:	0010d0b3          	srl	x1,x1,x1
 1000304:	4e81                	c.li	x29,0
 1000306:	41e1                	c.li	x3,24
 1000308:	25d09763          	bne	x1,x29,1000556 <fail>

0100030c <test_25>:
 100030c:	4201                	c.li	x4,0
 100030e:	800000b7          	lui	x1,0x80000
 1000312:	411d                	c.li	x2,7
 1000314:	0020d733          	srl	x14,x1,x2
 1000318:	00070313          	addi	x6,x14,0
 100031c:	0205                	c.addi	x4,1
 100031e:	4289                	c.li	x5,2
 1000320:	fe5217e3          	bne	x4,x5,100030e <test_25+0x2>
 1000324:	01000eb7          	lui	x29,0x1000
 1000328:	41e5                	c.li	x3,25
 100032a:	23d31663          	bne	x6,x29,1000556 <fail>

0100032e <test_26>:
 100032e:	4201                	c.li	x4,0
 1000330:	800000b7          	lui	x1,0x80000
 1000334:	4139                	c.li	x2,14
 1000336:	0020d733          	srl	x14,x1,x2
 100033a:	0001                	c.addi	x0,0
 100033c:	00070313          	addi	x6,x14,0
 1000340:	0205                	c.addi	x4,1
 1000342:	4289                	c.li	x5,2
 1000344:	fe5216e3          	bne	x4,x5,1000330 <test_26+0x2>
 1000348:	00020eb7          	lui	x29,0x20
 100034c:	41e9                	c.li	x3,26
 100034e:	21d31463          	bne	x6,x29,1000556 <fail>

01000352 <test_27>:
 1000352:	4201                	c.li	x4,0
 1000354:	800000b7          	lui	x1,0x80000
 1000358:	417d                	c.li	x2,31
 100035a:	0020d733          	srl	x14,x1,x2
 100035e:	0001                	c.addi	x0,0
 1000360:	0001                	c.addi	x0,0
 1000362:	00070313          	addi	x6,x14,0
 1000366:	0205                	c.addi	x4,1
 1000368:	4289                	c.li	x5,2
 100036a:	fe5215e3          	bne	x4,x5,1000354 <test_27+0x2>
 100036e:	4e85                	c.li	x29,1
 1000370:	41ed                	c.li	x3,27
 1000372:	1fd31263          	bne	x6,x29,1000556 <fail>

01000376 <test_28>:
 1000376:	4201                	c.li	x4,0
 1000378:	800000b7          	lui	x1,0x80000
 100037c:	411d                	c.li	x2,7
 100037e:	0020d733          	srl	x14,x1,x2
 1000382:	0205                	c.addi	x4,1
 1000384:	4289                	c.li	x5,2
 1000386:	fe5219e3          	bne	x4,x5,1000378 <test_28+0x2>
 100038a:	01000eb7          	lui	x29,0x1000
 100038e:	41f1                	c.li	x3,28
 1000390:	1dd71363          	bne	x14,x29,1000556 <fail>

01000394 <test_29>:
 1000394:	4201                	c.li	x4,0
 1000396:	800000b7          	lui	x1,0x80000
 100039a:	4139                	c.li	x2,14
 100039c:	0001                	c.addi	x0,0
 100039e:	0020d733          	srl	x14,x1,x2
 10003a2:	0205                	c.addi	x4,1
 10003a4:	4289                	c.li	x5,2
 10003a6:	fe5218e3          	bne	x4,x5,1000396 <test_29+0x2>
 10003aa:	00020eb7          	lui	x29,0x20
 10003ae:	41f5                	c.li	x3,29
 10003b0:	1bd71363          	bne	x14,x29,1000556 <fail>

010003b4 <test_30>:
 10003b4:	4201                	c.li	x4,0
 10003b6:	800000b7          	lui	x1,0x80000
 10003ba:	417d                	c.li	x2,31
 10003bc:	0001                	c.addi	x0,0
 10003be:	0001                	c.addi	x0,0
 10003c0:	0020d733          	srl	x14,x1,x2
 10003c4:	0205                	c.addi	x4,1
 10003c6:	4289                	c.li	x5,2
 10003c8:	fe5217e3          	bne	x4,x5,10003b6 <test_30+0x2>
 10003cc:	4e85                	c.li	x29,1
 10003ce:	41f9                	c.li	x3,30
 10003d0:	19d71363          	bne	x14,x29,1000556 <fail>

010003d4 <test_31>:
 10003d4:	4201                	c.li	x4,0
 10003d6:	800000b7          	lui	x1,0x80000
 10003da:	0001                	c.addi	x0,0
 10003dc:	411d                	c.li	x2,7
 10003de:	0020d733          	srl	x14,x1,x2
 10003e2:	0205                	c.addi	x4,1
 10003e4:	4289                	c.li	x5,2
 10003e6:	fe5218e3          	bne	x4,x5,10003d6 <test_31+0x2>
 10003ea:	01000eb7          	lui	x29,0x1000
 10003ee:	41fd                	c.li	x3,31
 10003f0:	17d71363          	bne	x14,x29,1000556 <fail>

010003f4 <test_32>:
 10003f4:	4201                	c.li	x4,0
 10003f6:	800000b7          	lui	x1,0x80000
 10003fa:	0001                	c.addi	x0,0
 10003fc:	4139                	c.li	x2,14
 10003fe:	0001                	c.addi	x0,0
 1000400:	0020d733          	srl	x14,x1,x2
 1000404:	0205                	c.addi	x4,1
 1000406:	4289                	c.li	x5,2
 1000408:	fe5217e3          	bne	x4,x5,10003f6 <test_32+0x2>
 100040c:	00020eb7          	lui	x29,0x20
 1000410:	02000193          	addi	x3,x0,32
 1000414:	15d71163          	bne	x14,x29,1000556 <fail>

01000418 <test_33>:
 1000418:	4201                	c.li	x4,0
 100041a:	800000b7          	lui	x1,0x80000
 100041e:	0001                	c.addi	x0,0
 1000420:	0001                	c.addi	x0,0
 1000422:	417d                	c.li	x2,31
 1000424:	0020d733          	srl	x14,x1,x2
 1000428:	0205                	c.addi	x4,1
 100042a:	4289                	c.li	x5,2
 100042c:	fe5217e3          	bne	x4,x5,100041a <test_33+0x2>
 1000430:	4e85                	c.li	x29,1
 1000432:	02100193          	addi	x3,x0,33
 1000436:	13d71063          	bne	x14,x29,1000556 <fail>

0100043a <test_34>:
 100043a:	4201                	c.li	x4,0
 100043c:	411d                	c.li	x2,7
 100043e:	800000b7          	lui	x1,0x80000
 1000442:	0020d733          	srl	x14,x1,x2
 1000446:	0205                	c.addi	x4,1
 1000448:	4289                	c.li	x5,2
 100044a:	fe5219e3          	bne	x4,x5,100043c <test_34+0x2>
 100044e:	01000eb7          	lui	x29,0x1000
 1000452:	02200193          	addi	x3,x0,34
 1000456:	11d71063          	bne	x14,x29,1000556 <fail>

0100045a <test_35>:
 100045a:	4201                	c.li	x4,0
 100045c:	4139                	c.li	x2,14
 100045e:	800000b7          	lui	x1,0x80000
 1000462:	0001                	c.addi	x0,0
 1000464:	0020d733          	srl	x14,x1,x2
 1000468:	0205                	c.addi	x4,1
 100046a:	4289                	c.li	x5,2
 100046c:	fe5218e3          	bne	x4,x5,100045c <test_35+0x2>
 1000470:	00020eb7          	lui	x29,0x20
 1000474:	02300193          	addi	x3,x0,35
 1000478:	0dd71f63          	bne	x14,x29,1000556 <fail>

0100047c <test_36>:
 100047c:	4201                	c.li	x4,0
 100047e:	417d                	c.li	x2,31
 1000480:	800000b7          	lui	x1,0x80000
 1000484:	0001                	c.addi	x0,0
 1000486:	0001                	c.addi	x0,0
 1000488:	0020d733          	srl	x14,x1,x2
 100048c:	0205                	c.addi	x4,1
 100048e:	4289                	c.li	x5,2
 1000490:	fe5217e3          	bne	x4,x5,100047e <test_36+0x2>
 1000494:	4e85                	c.li	x29,1
 1000496:	02400193          	addi	x3,x0,36
 100049a:	0bd71e63          	bne	x14,x29,1000556 <fail>

0100049e <test_37>:
 100049e:	4201                	c.li	x4,0
 10004a0:	411d                	c.li	x2,7
 10004a2:	0001                	c.addi	x0,0
 10004a4:	800000b7          	lui	x1,0x80000
 10004a8:	0020d733          	srl	x14,x1,x2
 10004ac:	0205                	c.addi	x4,1
 10004ae:	4289                	c.li	x5,2
 10004b0:	fe5218e3          	bne	x4,x5,10004a0 <test_37+0x2>
 10004b4:	01000eb7          	lui	x29,0x1000
 10004b8:	02500193          	addi	x3,x0,37
 10004bc:	09d71d63          	bne	x14,x29,1000556 <fail>

010004c0 <test_38>:
 10004c0:	4201                	c.li	x4,0
 10004c2:	4139                	c.li	x2,14
 10004c4:	0001                	c.addi	x0,0
 10004c6:	800000b7          	lui	x1,0x80000
 10004ca:	0001                	c.addi	x0,0
 10004cc:	0020d733          	srl	x14,x1,x2
 10004d0:	0205                	c.addi	x4,1
 10004d2:	4289                	c.li	x5,2
 10004d4:	fe5217e3          	bne	x4,x5,10004c2 <test_38+0x2>
 10004d8:	00020eb7          	lui	x29,0x20
 10004dc:	02600193          	addi	x3,x0,38
 10004e0:	07d71b63          	bne	x14,x29,1000556 <fail>

010004e4 <test_39>:
 10004e4:	4201                	c.li	x4,0
 10004e6:	417d                	c.li	x2,31
 10004e8:	0001                	c.addi	x0,0
 10004ea:	0001                	c.addi	x0,0
 10004ec:	800000b7          	lui	x1,0x80000
 10004f0:	0020d733          	srl	x14,x1,x2
 10004f4:	0205                	c.addi	x4,1
 10004f6:	4289                	c.li	x5,2
 10004f8:	fe5217e3          	bne	x4,x5,10004e6 <test_39+0x2>
 10004fc:	4e85                	c.li	x29,1
 10004fe:	02700193          	addi	x3,x0,39
 1000502:	05d71a63          	bne	x14,x29,1000556 <fail>

01000506 <test_40>:
 1000506:	40bd                	c.li	x1,15
 1000508:	00105133          	srl	x2,x0,x1
 100050c:	4e81                	c.li	x29,0
 100050e:	02800193          	addi	x3,x0,40
 1000512:	05d11263          	bne	x2,x29,1000556 <fail>

01000516 <test_41>:
 1000516:	02000093          	addi	x1,x0,32
 100051a:	0000d133          	srl	x2,x1,x0
 100051e:	02000e93          	addi	x29,x0,32
 1000522:	02900193          	addi	x3,x0,41
 1000526:	03d11863          	bne	x2,x29,1000556 <fail>

0100052a <test_42>:
 100052a:	000050b3          	srl	x1,x0,x0
 100052e:	4e81                	c.li	x29,0
 1000530:	02a00193          	addi	x3,x0,42
 1000534:	03d09163          	bne	x1,x29,1000556 <fail>

01000538 <test_43>:
 1000538:	40000093          	addi	x1,x0,1024
 100053c:	00001137          	lui	x2,0x1
 1000540:	80010113          	addi	x2,x2,-2048 # 800 <_start-0xfff800>
 1000544:	0020d033          	srl	x0,x1,x2
 1000548:	4e81                	c.li	x29,0
 100054a:	02b00193          	addi	x3,x0,43
 100054e:	01d01463          	bne	x0,x29,1000556 <fail>
 1000552:	00301b63          	bne	x0,x3,1000568 <pass>

01000556 <fail>:
 1000556:	0ff0000f          	fence	iorw,iorw
 100055a:	00018063          	beq	x3,x0,100055a <fail+0x4>
 100055e:	0186                	c.slli	x3,0x1
 1000560:	0011e193          	ori	x3,x3,1
 1000564:	00000073          	ecall

01000568 <pass>:
 1000568:	0ff0000f          	fence	iorw,iorw
 100056c:	4185                	c.li	x3,1
 100056e:	00000073          	ecall
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
