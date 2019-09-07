
rv32ui/srli.elf:     file format elf32-littleriscv


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
 10000f0:	0000d713          	srli	x14,x1,0x0
 10000f4:	80000eb7          	lui	x29,0x80000
 10000f8:	4189                	c.li	x3,2
 10000fa:	23d71263          	bne	x14,x29,100031e <fail>

010000fe <test_3>:
 10000fe:	800000b7          	lui	x1,0x80000
 1000102:	0010d713          	srli	x14,x1,0x1
 1000106:	40000eb7          	lui	x29,0x40000
 100010a:	418d                	c.li	x3,3
 100010c:	21d71963          	bne	x14,x29,100031e <fail>

01000110 <test_4>:
 1000110:	800000b7          	lui	x1,0x80000
 1000114:	0070d713          	srli	x14,x1,0x7
 1000118:	01000eb7          	lui	x29,0x1000
 100011c:	4191                	c.li	x3,4
 100011e:	21d71063          	bne	x14,x29,100031e <fail>

01000122 <test_5>:
 1000122:	800000b7          	lui	x1,0x80000
 1000126:	00e0d713          	srli	x14,x1,0xe
 100012a:	00020eb7          	lui	x29,0x20
 100012e:	4195                	c.li	x3,5
 1000130:	1fd71763          	bne	x14,x29,100031e <fail>

01000134 <test_6>:
 1000134:	800000b7          	lui	x1,0x80000
 1000138:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 100013c:	01f0d713          	srli	x14,x1,0x1f
 1000140:	4e85                	c.li	x29,1
 1000142:	4199                	c.li	x3,6
 1000144:	1dd71d63          	bne	x14,x29,100031e <fail>

01000148 <test_7>:
 1000148:	fff00093          	addi	x1,x0,-1
 100014c:	0000d713          	srli	x14,x1,0x0
 1000150:	fff00e93          	addi	x29,x0,-1
 1000154:	419d                	c.li	x3,7
 1000156:	1dd71463          	bne	x14,x29,100031e <fail>

0100015a <test_8>:
 100015a:	fff00093          	addi	x1,x0,-1
 100015e:	0010d713          	srli	x14,x1,0x1
 1000162:	80000eb7          	lui	x29,0x80000
 1000166:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 100016a:	41a1                	c.li	x3,8
 100016c:	1bd71963          	bne	x14,x29,100031e <fail>

01000170 <test_9>:
 1000170:	fff00093          	addi	x1,x0,-1
 1000174:	0070d713          	srli	x14,x1,0x7
 1000178:	02000eb7          	lui	x29,0x2000
 100017c:	fffe8e93          	addi	x29,x29,-1 # 1ffffff <_end+0xffdfff>
 1000180:	41a5                	c.li	x3,9
 1000182:	19d71e63          	bne	x14,x29,100031e <fail>

01000186 <test_10>:
 1000186:	fff00093          	addi	x1,x0,-1
 100018a:	00e0d713          	srli	x14,x1,0xe
 100018e:	00040eb7          	lui	x29,0x40
 1000192:	fffe8e93          	addi	x29,x29,-1 # 3ffff <_start-0xfc0001>
 1000196:	41a9                	c.li	x3,10
 1000198:	19d71363          	bne	x14,x29,100031e <fail>

0100019c <test_11>:
 100019c:	fff00093          	addi	x1,x0,-1
 10001a0:	01f0d713          	srli	x14,x1,0x1f
 10001a4:	4e85                	c.li	x29,1
 10001a6:	41ad                	c.li	x3,11
 10001a8:	17d71b63          	bne	x14,x29,100031e <fail>

010001ac <test_12>:
 10001ac:	212120b7          	lui	x1,0x21212
 10001b0:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001b4:	0000d713          	srli	x14,x1,0x0
 10001b8:	21212eb7          	lui	x29,0x21212
 10001bc:	121e8e93          	addi	x29,x29,289 # 21212121 <_end+0x20210121>
 10001c0:	41b1                	c.li	x3,12
 10001c2:	15d71e63          	bne	x14,x29,100031e <fail>

010001c6 <test_13>:
 10001c6:	212120b7          	lui	x1,0x21212
 10001ca:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001ce:	0010d713          	srli	x14,x1,0x1
 10001d2:	10909eb7          	lui	x29,0x10909
 10001d6:	090e8e93          	addi	x29,x29,144 # 10909090 <_end+0xf907090>
 10001da:	41b5                	c.li	x3,13
 10001dc:	15d71163          	bne	x14,x29,100031e <fail>

010001e0 <test_14>:
 10001e0:	212120b7          	lui	x1,0x21212
 10001e4:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001e8:	0070d713          	srli	x14,x1,0x7
 10001ec:	00424eb7          	lui	x29,0x424
 10001f0:	242e8e93          	addi	x29,x29,578 # 424242 <_start-0xbdbdbe>
 10001f4:	41b9                	c.li	x3,14
 10001f6:	13d71463          	bne	x14,x29,100031e <fail>

010001fa <test_15>:
 10001fa:	212120b7          	lui	x1,0x21212
 10001fe:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000202:	00e0d713          	srli	x14,x1,0xe
 1000206:	00008eb7          	lui	x29,0x8
 100020a:	484e8e93          	addi	x29,x29,1156 # 8484 <_start-0xff7b7c>
 100020e:	41bd                	c.li	x3,15
 1000210:	11d71763          	bne	x14,x29,100031e <fail>

01000214 <test_16>:
 1000214:	212120b7          	lui	x1,0x21212
 1000218:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 100021c:	01f0d713          	srli	x14,x1,0x1f
 1000220:	4e81                	c.li	x29,0
 1000222:	41c1                	c.li	x3,16
 1000224:	0fd71d63          	bne	x14,x29,100031e <fail>

01000228 <test_17>:
 1000228:	800000b7          	lui	x1,0x80000
 100022c:	0070d093          	srli	x1,x1,0x7
 1000230:	01000eb7          	lui	x29,0x1000
 1000234:	41c5                	c.li	x3,17
 1000236:	0fd09463          	bne	x1,x29,100031e <fail>

0100023a <test_18>:
 100023a:	4201                	c.li	x4,0
 100023c:	800000b7          	lui	x1,0x80000
 1000240:	0070d713          	srli	x14,x1,0x7
 1000244:	00070313          	addi	x6,x14,0
 1000248:	0205                	c.addi	x4,1
 100024a:	4289                	c.li	x5,2
 100024c:	fe5218e3          	bne	x4,x5,100023c <test_18+0x2>
 1000250:	01000eb7          	lui	x29,0x1000
 1000254:	41c9                	c.li	x3,18
 1000256:	0dd31463          	bne	x6,x29,100031e <fail>

0100025a <test_19>:
 100025a:	4201                	c.li	x4,0
 100025c:	800000b7          	lui	x1,0x80000
 1000260:	00e0d713          	srli	x14,x1,0xe
 1000264:	0001                	c.addi	x0,0
 1000266:	00070313          	addi	x6,x14,0
 100026a:	0205                	c.addi	x4,1
 100026c:	4289                	c.li	x5,2
 100026e:	fe5217e3          	bne	x4,x5,100025c <test_19+0x2>
 1000272:	00020eb7          	lui	x29,0x20
 1000276:	41cd                	c.li	x3,19
 1000278:	0bd31363          	bne	x6,x29,100031e <fail>

0100027c <test_20>:
 100027c:	4201                	c.li	x4,0
 100027e:	800000b7          	lui	x1,0x80000
 1000282:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 1000286:	01f0d713          	srli	x14,x1,0x1f
 100028a:	0001                	c.addi	x0,0
 100028c:	0001                	c.addi	x0,0
 100028e:	00070313          	addi	x6,x14,0
 1000292:	0205                	c.addi	x4,1
 1000294:	4289                	c.li	x5,2
 1000296:	fe5214e3          	bne	x4,x5,100027e <test_20+0x2>
 100029a:	4e85                	c.li	x29,1
 100029c:	41d1                	c.li	x3,20
 100029e:	09d31063          	bne	x6,x29,100031e <fail>

010002a2 <test_21>:
 10002a2:	4201                	c.li	x4,0
 10002a4:	800000b7          	lui	x1,0x80000
 10002a8:	0070d713          	srli	x14,x1,0x7
 10002ac:	0205                	c.addi	x4,1
 10002ae:	4289                	c.li	x5,2
 10002b0:	fe521ae3          	bne	x4,x5,10002a4 <test_21+0x2>
 10002b4:	01000eb7          	lui	x29,0x1000
 10002b8:	41d5                	c.li	x3,21
 10002ba:	07d71263          	bne	x14,x29,100031e <fail>

010002be <test_22>:
 10002be:	4201                	c.li	x4,0
 10002c0:	800000b7          	lui	x1,0x80000
 10002c4:	0001                	c.addi	x0,0
 10002c6:	00e0d713          	srli	x14,x1,0xe
 10002ca:	0205                	c.addi	x4,1
 10002cc:	4289                	c.li	x5,2
 10002ce:	fe5219e3          	bne	x4,x5,10002c0 <test_22+0x2>
 10002d2:	00020eb7          	lui	x29,0x20
 10002d6:	41d9                	c.li	x3,22
 10002d8:	05d71363          	bne	x14,x29,100031e <fail>

010002dc <test_23>:
 10002dc:	4201                	c.li	x4,0
 10002de:	800000b7          	lui	x1,0x80000
 10002e2:	00108093          	addi	x1,x1,1 # 80000001 <_end+0x7effe001>
 10002e6:	0001                	c.addi	x0,0
 10002e8:	0001                	c.addi	x0,0
 10002ea:	01f0d713          	srli	x14,x1,0x1f
 10002ee:	0205                	c.addi	x4,1
 10002f0:	4289                	c.li	x5,2
 10002f2:	fe5216e3          	bne	x4,x5,10002de <test_23+0x2>
 10002f6:	4e85                	c.li	x29,1
 10002f8:	41dd                	c.li	x3,23
 10002fa:	03d71263          	bne	x14,x29,100031e <fail>

010002fe <test_24>:
 10002fe:	00405093          	srli	x1,x0,0x4
 1000302:	4e81                	c.li	x29,0
 1000304:	41e1                	c.li	x3,24
 1000306:	01d09c63          	bne	x1,x29,100031e <fail>

0100030a <test_25>:
 100030a:	02100093          	addi	x1,x0,33
 100030e:	00a0d013          	srli	x0,x1,0xa
 1000312:	4e81                	c.li	x29,0
 1000314:	41e5                	c.li	x3,25
 1000316:	01d01463          	bne	x0,x29,100031e <fail>
 100031a:	00301b63          	bne	x0,x3,1000330 <pass>

0100031e <fail>:
 100031e:	0ff0000f          	fence	iorw,iorw
 1000322:	00018063          	beq	x3,x0,1000322 <fail+0x4>
 1000326:	0186                	c.slli	x3,0x1
 1000328:	0011e193          	ori	x3,x3,1
 100032c:	00000073          	ecall

01000330 <pass>:
 1000330:	0ff0000f          	fence	iorw,iorw
 1000334:	4185                	c.li	x3,1
 1000336:	00000073          	ecall
 100033a:	0000                	c.unimp
 100033c:	0000                	c.unimp
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
