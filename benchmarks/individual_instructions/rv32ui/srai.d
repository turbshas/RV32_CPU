
rv32ui/srai.elf:     file format elf32-littleriscv


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
 10000ec:	4081                	c.li	x1,0
 10000ee:	4000d713          	srai	x14,x1,0x0
 10000f2:	4e81                	c.li	x29,0
 10000f4:	4189                	c.li	x3,2
 10000f6:	25d71263          	bne	x14,x29,100033a <fail>

010000fa <test_3>:
 10000fa:	800000b7          	lui	x1,0x80000
 10000fe:	4010d713          	srai	x14,x1,0x1
 1000102:	c0000eb7          	lui	x29,0xc0000
 1000106:	418d                	c.li	x3,3
 1000108:	23d71963          	bne	x14,x29,100033a <fail>

0100010c <test_4>:
 100010c:	800000b7          	lui	x1,0x80000
 1000110:	4070d713          	srai	x14,x1,0x7
 1000114:	ff000eb7          	lui	x29,0xff000
 1000118:	4191                	c.li	x3,4
 100011a:	23d71063          	bne	x14,x29,100033a <fail>

0100011e <test_5>:
 100011e:	800000b7          	lui	x1,0x80000
 1000122:	40e0d713          	srai	x14,x1,0xe
 1000126:	fffe0eb7          	lui	x29,0xfffe0
 100012a:	4195                	c.li	x3,5
 100012c:	21d71763          	bne	x14,x29,100033a <fail>

01000130 <test_6>:
 1000130:	800000b7          	lui	x1,0x80000
 1000134:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 1000138:	41f0d713          	srai	x14,x1,0x1f
 100013c:	fff00e93          	addi	x29,x0,-1
 1000140:	4199                	c.li	x3,6
 1000142:	1fd71c63          	bne	x14,x29,100033a <fail>

01000146 <test_7>:
 1000146:	800000b7          	lui	x1,0x80000
 100014a:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100014e:	4000d713          	srai	x14,x1,0x0
 1000152:	80000eb7          	lui	x29,0x80000
 1000156:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 100015a:	419d                	c.li	x3,7
 100015c:	1dd71f63          	bne	x14,x29,100033a <fail>

01000160 <test_8>:
 1000160:	800000b7          	lui	x1,0x80000
 1000164:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000168:	4010d713          	srai	x14,x1,0x1
 100016c:	40000eb7          	lui	x29,0x40000
 1000170:	fffe8e93          	addi	x29,x29,-1 # 3fffffff <_end+0x3effdfff>
 1000174:	41a1                	c.li	x3,8
 1000176:	1dd71263          	bne	x14,x29,100033a <fail>

0100017a <test_9>:
 100017a:	800000b7          	lui	x1,0x80000
 100017e:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000182:	4070d713          	srai	x14,x1,0x7
 1000186:	01000eb7          	lui	x29,0x1000
 100018a:	fffe8e93          	addi	x29,x29,-1 # ffffff <_start-0x1>
 100018e:	41a5                	c.li	x3,9
 1000190:	1bd71563          	bne	x14,x29,100033a <fail>

01000194 <test_10>:
 1000194:	800000b7          	lui	x1,0x80000
 1000198:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 100019c:	40e0d713          	srai	x14,x1,0xe
 10001a0:	00020eb7          	lui	x29,0x20
 10001a4:	fffe8e93          	addi	x29,x29,-1 # 1ffff <_start-0xfe0001>
 10001a8:	41a9                	c.li	x3,10
 10001aa:	19d71863          	bne	x14,x29,100033a <fail>

010001ae <test_11>:
 10001ae:	800000b7          	lui	x1,0x80000
 10001b2:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001b6:	41f0d713          	srai	x14,x1,0x1f
 10001ba:	4e81                	c.li	x29,0
 10001bc:	41ad                	c.li	x3,11
 10001be:	17d71e63          	bne	x14,x29,100033a <fail>

010001c2 <test_12>:
 10001c2:	818180b7          	lui	x1,0x81818
 10001c6:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10001ca:	4000d713          	srai	x14,x1,0x0
 10001ce:	81818eb7          	lui	x29,0x81818
 10001d2:	181e8e93          	addi	x29,x29,385 # 81818181 <_end+0x80816181>
 10001d6:	41b1                	c.li	x3,12
 10001d8:	17d71163          	bne	x14,x29,100033a <fail>

010001dc <test_13>:
 10001dc:	818180b7          	lui	x1,0x81818
 10001e0:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10001e4:	4010d713          	srai	x14,x1,0x1
 10001e8:	c0c0ceb7          	lui	x29,0xc0c0c
 10001ec:	0c0e8e93          	addi	x29,x29,192 # c0c0c0c0 <_end+0xbfc0a0c0>
 10001f0:	41b5                	c.li	x3,13
 10001f2:	15d71463          	bne	x14,x29,100033a <fail>

010001f6 <test_14>:
 10001f6:	818180b7          	lui	x1,0x81818
 10001fa:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 10001fe:	4070d713          	srai	x14,x1,0x7
 1000202:	ff030eb7          	lui	x29,0xff030
 1000206:	303e8e93          	addi	x29,x29,771 # ff030303 <_end+0xfe02e303>
 100020a:	41b9                	c.li	x3,14
 100020c:	13d71763          	bne	x14,x29,100033a <fail>

01000210 <test_15>:
 1000210:	818180b7          	lui	x1,0x81818
 1000214:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 1000218:	40e0d713          	srai	x14,x1,0xe
 100021c:	fffe0eb7          	lui	x29,0xfffe0
 1000220:	606e8e93          	addi	x29,x29,1542 # fffe0606 <_end+0xfefde606>
 1000224:	41bd                	c.li	x3,15
 1000226:	11d71a63          	bne	x14,x29,100033a <fail>

0100022a <test_16>:
 100022a:	818180b7          	lui	x1,0x81818
 100022e:	18108093          	addi	x1,x1,385 # 81818181 <_end+0x80816181>
 1000232:	41f0d713          	srai	x14,x1,0x1f
 1000236:	fff00e93          	addi	x29,x0,-1
 100023a:	41c1                	c.li	x3,16
 100023c:	0fd71f63          	bne	x14,x29,100033a <fail>

01000240 <test_17>:
 1000240:	800000b7          	lui	x1,0x80000
 1000244:	4070d093          	srai	x1,x1,0x7
 1000248:	ff000eb7          	lui	x29,0xff000
 100024c:	41c5                	c.li	x3,17
 100024e:	0fd09663          	bne	x1,x29,100033a <fail>

01000252 <test_18>:
 1000252:	4201                	c.li	x4,0
 1000254:	800000b7          	lui	x1,0x80000
 1000258:	4070d713          	srai	x14,x1,0x7
 100025c:	00070313          	addi	x6,x14,0
 1000260:	0205                	c.addi	x4,1
 1000262:	4289                	c.li	x5,2
 1000264:	fe5218e3          	bne	x4,x5,1000254 <test_18+0x2>
 1000268:	ff000eb7          	lui	x29,0xff000
 100026c:	41c9                	c.li	x3,18
 100026e:	0dd31663          	bne	x6,x29,100033a <fail>

01000272 <test_19>:
 1000272:	4201                	c.li	x4,0
 1000274:	800000b7          	lui	x1,0x80000
 1000278:	40e0d713          	srai	x14,x1,0xe
 100027c:	0001                	c.addi	x0,0
 100027e:	00070313          	addi	x6,x14,0
 1000282:	0205                	c.addi	x4,1
 1000284:	4289                	c.li	x5,2
 1000286:	fe5217e3          	bne	x4,x5,1000274 <test_19+0x2>
 100028a:	fffe0eb7          	lui	x29,0xfffe0
 100028e:	41cd                	c.li	x3,19
 1000290:	0bd31563          	bne	x6,x29,100033a <fail>

01000294 <test_20>:
 1000294:	4201                	c.li	x4,0
 1000296:	800000b7          	lui	x1,0x80000
 100029a:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 100029e:	41f0d713          	srai	x14,x1,0x1f
 10002a2:	0001                	c.addi	x0,0
 10002a4:	0001                	c.addi	x0,0
 10002a6:	00070313          	addi	x6,x14,0
 10002aa:	0205                	c.addi	x4,1
 10002ac:	4289                	c.li	x5,2
 10002ae:	fe5214e3          	bne	x4,x5,1000296 <test_20+0x2>
 10002b2:	fff00e93          	addi	x29,x0,-1
 10002b6:	41d1                	c.li	x3,20
 10002b8:	09d31163          	bne	x6,x29,100033a <fail>

010002bc <test_21>:
 10002bc:	4201                	c.li	x4,0
 10002be:	800000b7          	lui	x1,0x80000
 10002c2:	4070d713          	srai	x14,x1,0x7
 10002c6:	0205                	c.addi	x4,1
 10002c8:	4289                	c.li	x5,2
 10002ca:	fe521ae3          	bne	x4,x5,10002be <test_21+0x2>
 10002ce:	ff000eb7          	lui	x29,0xff000
 10002d2:	41d5                	c.li	x3,21
 10002d4:	07d71363          	bne	x14,x29,100033a <fail>

010002d8 <test_22>:
 10002d8:	4201                	c.li	x4,0
 10002da:	800000b7          	lui	x1,0x80000
 10002de:	0001                	c.addi	x0,0
 10002e0:	40e0d713          	srai	x14,x1,0xe
 10002e4:	0205                	c.addi	x4,1
 10002e6:	4289                	c.li	x5,2
 10002e8:	fe5219e3          	bne	x4,x5,10002da <test_22+0x2>
 10002ec:	fffe0eb7          	lui	x29,0xfffe0
 10002f0:	41d9                	c.li	x3,22
 10002f2:	05d71463          	bne	x14,x29,100033a <fail>

010002f6 <test_23>:
 10002f6:	4201                	c.li	x4,0
 10002f8:	800000b7          	lui	x1,0x80000
 10002fc:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 1000300:	0001                	c.addi	x0,0
 1000302:	0001                	c.addi	x0,0
 1000304:	41f0d713          	srai	x14,x1,0x1f
 1000308:	0205                	c.addi	x4,1
 100030a:	4289                	c.li	x5,2
 100030c:	fe5216e3          	bne	x4,x5,10002f8 <test_23+0x2>
 1000310:	fff00e93          	addi	x29,x0,-1
 1000314:	41dd                	c.li	x3,23
 1000316:	03d71263          	bne	x14,x29,100033a <fail>

0100031a <test_24>:
 100031a:	40405093          	srai	x1,x0,0x4
 100031e:	4e81                	c.li	x29,0
 1000320:	41e1                	c.li	x3,24
 1000322:	01d09c63          	bne	x1,x29,100033a <fail>

01000326 <test_25>:
 1000326:	02100093          	addi	x1,x0,33
 100032a:	40a0d013          	srai	x0,x1,0xa
 100032e:	4e81                	c.li	x29,0
 1000330:	41e5                	c.li	x3,25
 1000332:	01d01463          	bne	x0,x29,100033a <fail>
 1000336:	00301b63          	bne	x0,x3,100034c <pass>

0100033a <fail>:
 100033a:	0ff0000f          	fence	iorw,iorw
 100033e:	00018063          	beq	x3,x0,100033e <fail+0x4>
 1000342:	0186                	c.slli	x3,0x1
 1000344:	0011e193          	ori	x3,x3,1
 1000348:	00000073          	ecall

0100034c <pass>:
 100034c:	0ff0000f          	fence	iorw,iorw
 1000350:	4185                	c.li	x3,1
 1000352:	00000073          	ecall
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
