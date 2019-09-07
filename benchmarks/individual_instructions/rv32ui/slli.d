
rv32ui/slli.elf:     file format elf32-littleriscv


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
 10000ec:	4085                	c.li	x1,1
 10000ee:	00009713          	slli	x14,x1,0x0
 10000f2:	4e85                	c.li	x29,1
 10000f4:	4189                	c.li	x3,2
 10000f6:	1fd71963          	bne	x14,x29,10002e8 <fail>

010000fa <test_3>:
 10000fa:	4085                	c.li	x1,1
 10000fc:	00109713          	slli	x14,x1,0x1
 1000100:	4e89                	c.li	x29,2
 1000102:	418d                	c.li	x3,3
 1000104:	1fd71263          	bne	x14,x29,10002e8 <fail>

01000108 <test_4>:
 1000108:	4085                	c.li	x1,1
 100010a:	00709713          	slli	x14,x1,0x7
 100010e:	08000e93          	addi	x29,x0,128
 1000112:	4191                	c.li	x3,4
 1000114:	1dd71a63          	bne	x14,x29,10002e8 <fail>

01000118 <test_5>:
 1000118:	4085                	c.li	x1,1
 100011a:	00e09713          	slli	x14,x1,0xe
 100011e:	6e91                	c.lui	x29,0x4
 1000120:	4195                	c.li	x3,5
 1000122:	1dd71363          	bne	x14,x29,10002e8 <fail>

01000126 <test_6>:
 1000126:	4085                	c.li	x1,1
 1000128:	01f09713          	slli	x14,x1,0x1f
 100012c:	80000eb7          	lui	x29,0x80000
 1000130:	4199                	c.li	x3,6
 1000132:	1bd71b63          	bne	x14,x29,10002e8 <fail>

01000136 <test_7>:
 1000136:	fff00093          	addi	x1,x0,-1
 100013a:	00009713          	slli	x14,x1,0x0
 100013e:	fff00e93          	addi	x29,x0,-1
 1000142:	419d                	c.li	x3,7
 1000144:	1bd71263          	bne	x14,x29,10002e8 <fail>

01000148 <test_8>:
 1000148:	fff00093          	addi	x1,x0,-1
 100014c:	00109713          	slli	x14,x1,0x1
 1000150:	ffe00e93          	addi	x29,x0,-2
 1000154:	41a1                	c.li	x3,8
 1000156:	19d71963          	bne	x14,x29,10002e8 <fail>

0100015a <test_9>:
 100015a:	fff00093          	addi	x1,x0,-1
 100015e:	00709713          	slli	x14,x1,0x7
 1000162:	f8000e93          	addi	x29,x0,-128
 1000166:	41a5                	c.li	x3,9
 1000168:	19d71063          	bne	x14,x29,10002e8 <fail>

0100016c <test_10>:
 100016c:	fff00093          	addi	x1,x0,-1
 1000170:	00e09713          	slli	x14,x1,0xe
 1000174:	ffffceb7          	lui	x29,0xffffc
 1000178:	41a9                	c.li	x3,10
 100017a:	17d71763          	bne	x14,x29,10002e8 <fail>

0100017e <test_11>:
 100017e:	fff00093          	addi	x1,x0,-1
 1000182:	01f09713          	slli	x14,x1,0x1f
 1000186:	80000eb7          	lui	x29,0x80000
 100018a:	41ad                	c.li	x3,11
 100018c:	15d71e63          	bne	x14,x29,10002e8 <fail>

01000190 <test_12>:
 1000190:	212120b7          	lui	x1,0x21212
 1000194:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 1000198:	00009713          	slli	x14,x1,0x0
 100019c:	21212eb7          	lui	x29,0x21212
 10001a0:	121e8e93          	addi	x29,x29,289 # 21212121 <_end+0x20210121>
 10001a4:	41b1                	c.li	x3,12
 10001a6:	15d71163          	bne	x14,x29,10002e8 <fail>

010001aa <test_13>:
 10001aa:	212120b7          	lui	x1,0x21212
 10001ae:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001b2:	00109713          	slli	x14,x1,0x1
 10001b6:	42424eb7          	lui	x29,0x42424
 10001ba:	242e8e93          	addi	x29,x29,578 # 42424242 <_end+0x41422242>
 10001be:	41b5                	c.li	x3,13
 10001c0:	13d71463          	bne	x14,x29,10002e8 <fail>

010001c4 <test_14>:
 10001c4:	212120b7          	lui	x1,0x21212
 10001c8:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001cc:	00709713          	slli	x14,x1,0x7
 10001d0:	90909eb7          	lui	x29,0x90909
 10001d4:	080e8e93          	addi	x29,x29,128 # 90909080 <_end+0x8f907080>
 10001d8:	41b9                	c.li	x3,14
 10001da:	11d71763          	bne	x14,x29,10002e8 <fail>

010001de <test_15>:
 10001de:	212120b7          	lui	x1,0x21212
 10001e2:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001e6:	00e09713          	slli	x14,x1,0xe
 10001ea:	48484eb7          	lui	x29,0x48484
 10001ee:	41bd                	c.li	x3,15
 10001f0:	0fd71c63          	bne	x14,x29,10002e8 <fail>

010001f4 <test_16>:
 10001f4:	212120b7          	lui	x1,0x21212
 10001f8:	12108093          	addi	x1,x1,289 # 21212121 <_end+0x20210121>
 10001fc:	01f09713          	slli	x14,x1,0x1f
 1000200:	80000eb7          	lui	x29,0x80000
 1000204:	41c1                	c.li	x3,16
 1000206:	0fd71163          	bne	x14,x29,10002e8 <fail>

0100020a <test_17>:
 100020a:	4085                	c.li	x1,1
 100020c:	009e                	c.slli	x1,0x7
 100020e:	08000e93          	addi	x29,x0,128
 1000212:	41c5                	c.li	x3,17
 1000214:	0dd09a63          	bne	x1,x29,10002e8 <fail>

01000218 <test_18>:
 1000218:	4201                	c.li	x4,0
 100021a:	4085                	c.li	x1,1
 100021c:	00709713          	slli	x14,x1,0x7
 1000220:	00070313          	addi	x6,x14,0
 1000224:	0205                	c.addi	x4,1
 1000226:	4289                	c.li	x5,2
 1000228:	fe5219e3          	bne	x4,x5,100021a <test_18+0x2>
 100022c:	08000e93          	addi	x29,x0,128
 1000230:	41c9                	c.li	x3,18
 1000232:	0bd31b63          	bne	x6,x29,10002e8 <fail>

01000236 <test_19>:
 1000236:	4201                	c.li	x4,0
 1000238:	4085                	c.li	x1,1
 100023a:	00e09713          	slli	x14,x1,0xe
 100023e:	0001                	c.addi	x0,0
 1000240:	00070313          	addi	x6,x14,0
 1000244:	0205                	c.addi	x4,1
 1000246:	4289                	c.li	x5,2
 1000248:	fe5218e3          	bne	x4,x5,1000238 <test_19+0x2>
 100024c:	6e91                	c.lui	x29,0x4
 100024e:	41cd                	c.li	x3,19
 1000250:	09d31c63          	bne	x6,x29,10002e8 <fail>

01000254 <test_20>:
 1000254:	4201                	c.li	x4,0
 1000256:	4085                	c.li	x1,1
 1000258:	01f09713          	slli	x14,x1,0x1f
 100025c:	0001                	c.addi	x0,0
 100025e:	0001                	c.addi	x0,0
 1000260:	00070313          	addi	x6,x14,0
 1000264:	0205                	c.addi	x4,1
 1000266:	4289                	c.li	x5,2
 1000268:	fe5217e3          	bne	x4,x5,1000256 <test_20+0x2>
 100026c:	80000eb7          	lui	x29,0x80000
 1000270:	41d1                	c.li	x3,20
 1000272:	07d31b63          	bne	x6,x29,10002e8 <fail>

01000276 <test_21>:
 1000276:	4201                	c.li	x4,0
 1000278:	4085                	c.li	x1,1
 100027a:	00709713          	slli	x14,x1,0x7
 100027e:	0205                	c.addi	x4,1
 1000280:	4289                	c.li	x5,2
 1000282:	fe521be3          	bne	x4,x5,1000278 <test_21+0x2>
 1000286:	08000e93          	addi	x29,x0,128
 100028a:	41d5                	c.li	x3,21
 100028c:	05d71e63          	bne	x14,x29,10002e8 <fail>

01000290 <test_22>:
 1000290:	4201                	c.li	x4,0
 1000292:	4085                	c.li	x1,1
 1000294:	0001                	c.addi	x0,0
 1000296:	00e09713          	slli	x14,x1,0xe
 100029a:	0205                	c.addi	x4,1
 100029c:	4289                	c.li	x5,2
 100029e:	fe521ae3          	bne	x4,x5,1000292 <test_22+0x2>
 10002a2:	6e91                	c.lui	x29,0x4
 10002a4:	41d9                	c.li	x3,22
 10002a6:	05d71163          	bne	x14,x29,10002e8 <fail>

010002aa <test_23>:
 10002aa:	4201                	c.li	x4,0
 10002ac:	4085                	c.li	x1,1
 10002ae:	0001                	c.addi	x0,0
 10002b0:	0001                	c.addi	x0,0
 10002b2:	01f09713          	slli	x14,x1,0x1f
 10002b6:	0205                	c.addi	x4,1
 10002b8:	4289                	c.li	x5,2
 10002ba:	fe5219e3          	bne	x4,x5,10002ac <test_23+0x2>
 10002be:	80000eb7          	lui	x29,0x80000
 10002c2:	41dd                	c.li	x3,23
 10002c4:	03d71263          	bne	x14,x29,10002e8 <fail>

010002c8 <test_24>:
 10002c8:	01f01093          	slli	x1,x0,0x1f
 10002cc:	4e81                	c.li	x29,0
 10002ce:	41e1                	c.li	x3,24
 10002d0:	01d09c63          	bne	x1,x29,10002e8 <fail>

010002d4 <test_25>:
 10002d4:	02100093          	addi	x1,x0,33
 10002d8:	01409013          	slli	x0,x1,0x14
 10002dc:	4e81                	c.li	x29,0
 10002de:	41e5                	c.li	x3,25
 10002e0:	01d01463          	bne	x0,x29,10002e8 <fail>
 10002e4:	00301b63          	bne	x0,x3,10002fa <pass>

010002e8 <fail>:
 10002e8:	0ff0000f          	fence	iorw,iorw
 10002ec:	00018063          	beq	x3,x0,10002ec <fail+0x4>
 10002f0:	0186                	c.slli	x3,0x1
 10002f2:	0011e193          	ori	x3,x3,1
 10002f6:	00000073          	ecall

010002fa <pass>:
 10002fa:	0ff0000f          	fence	iorw,iorw
 10002fe:	4185                	c.li	x3,1
 1000300:	00000073          	ecall
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
