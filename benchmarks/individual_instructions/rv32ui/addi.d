
rv32ui/addi.elf:     file format elf32-littleriscv


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
 10000ee:	00008713          	addi	x14,x1,0
 10000f2:	4e81                	c.li	x29,0
 10000f4:	4189                	c.li	x3,2
 10000f6:	1fd71563          	bne	x14,x29,10002e0 <fail>

010000fa <test_3>:
 10000fa:	4085                	c.li	x1,1
 10000fc:	00108713          	addi	x14,x1,1
 1000100:	4e89                	c.li	x29,2
 1000102:	418d                	c.li	x3,3
 1000104:	1dd71e63          	bne	x14,x29,10002e0 <fail>

01000108 <test_4>:
 1000108:	408d                	c.li	x1,3
 100010a:	00708713          	addi	x14,x1,7
 100010e:	4ea9                	c.li	x29,10
 1000110:	4191                	c.li	x3,4
 1000112:	1dd71763          	bne	x14,x29,10002e0 <fail>

01000116 <test_5>:
 1000116:	4081                	c.li	x1,0
 1000118:	80008713          	addi	x14,x1,-2048
 100011c:	80000e93          	addi	x29,x0,-2048
 1000120:	4195                	c.li	x3,5
 1000122:	1bd71f63          	bne	x14,x29,10002e0 <fail>

01000126 <test_6>:
 1000126:	800000b7          	lui	x1,0x80000
 100012a:	00008713          	addi	x14,x1,0 # 80000000 <_end+0x7effe000>
 100012e:	80000eb7          	lui	x29,0x80000
 1000132:	4199                	c.li	x3,6
 1000134:	1bd71663          	bne	x14,x29,10002e0 <fail>

01000138 <test_7>:
 1000138:	800000b7          	lui	x1,0x80000
 100013c:	80008713          	addi	x14,x1,-2048 # 7ffff800 <_end+0x7effd800>
 1000140:	80000eb7          	lui	x29,0x80000
 1000144:	800e8e93          	addi	x29,x29,-2048 # 7ffff800 <_end+0x7effd800>
 1000148:	419d                	c.li	x3,7
 100014a:	19d71b63          	bne	x14,x29,10002e0 <fail>

0100014e <test_8>:
 100014e:	4081                	c.li	x1,0
 1000150:	7ff08713          	addi	x14,x1,2047
 1000154:	7ff00e93          	addi	x29,x0,2047
 1000158:	41a1                	c.li	x3,8
 100015a:	19d71363          	bne	x14,x29,10002e0 <fail>

0100015e <test_9>:
 100015e:	800000b7          	lui	x1,0x80000
 1000162:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000166:	00008713          	addi	x14,x1,0
 100016a:	80000eb7          	lui	x29,0x80000
 100016e:	fffe8e93          	addi	x29,x29,-1 # 7fffffff <_end+0x7effdfff>
 1000172:	41a5                	c.li	x3,9
 1000174:	17d71663          	bne	x14,x29,10002e0 <fail>

01000178 <test_10>:
 1000178:	800000b7          	lui	x1,0x80000
 100017c:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 1000180:	7ff08713          	addi	x14,x1,2047
 1000184:	80000eb7          	lui	x29,0x80000
 1000188:	7fee8e93          	addi	x29,x29,2046 # 800007fe <_end+0x7effe7fe>
 100018c:	41a9                	c.li	x3,10
 100018e:	15d71963          	bne	x14,x29,10002e0 <fail>

01000192 <test_11>:
 1000192:	800000b7          	lui	x1,0x80000
 1000196:	7ff08713          	addi	x14,x1,2047 # 800007ff <_end+0x7effe7ff>
 100019a:	80000eb7          	lui	x29,0x80000
 100019e:	7ffe8e93          	addi	x29,x29,2047 # 800007ff <_end+0x7effe7ff>
 10001a2:	41ad                	c.li	x3,11
 10001a4:	13d71e63          	bne	x14,x29,10002e0 <fail>

010001a8 <test_12>:
 10001a8:	800000b7          	lui	x1,0x80000
 10001ac:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001b0:	80008713          	addi	x14,x1,-2048
 10001b4:	7ffffeb7          	lui	x29,0x7ffff
 10001b8:	7ffe8e93          	addi	x29,x29,2047 # 7ffff7ff <_end+0x7effd7ff>
 10001bc:	41b1                	c.li	x3,12
 10001be:	13d71163          	bne	x14,x29,10002e0 <fail>

010001c2 <test_13>:
 10001c2:	4081                	c.li	x1,0
 10001c4:	fff08713          	addi	x14,x1,-1
 10001c8:	fff00e93          	addi	x29,x0,-1
 10001cc:	41b5                	c.li	x3,13
 10001ce:	11d71963          	bne	x14,x29,10002e0 <fail>

010001d2 <test_14>:
 10001d2:	fff00093          	addi	x1,x0,-1
 10001d6:	00108713          	addi	x14,x1,1
 10001da:	4e81                	c.li	x29,0
 10001dc:	41b9                	c.li	x3,14
 10001de:	11d71163          	bne	x14,x29,10002e0 <fail>

010001e2 <test_15>:
 10001e2:	fff00093          	addi	x1,x0,-1
 10001e6:	fff08713          	addi	x14,x1,-1
 10001ea:	ffe00e93          	addi	x29,x0,-2
 10001ee:	41bd                	c.li	x3,15
 10001f0:	0fd71863          	bne	x14,x29,10002e0 <fail>

010001f4 <test_16>:
 10001f4:	800000b7          	lui	x1,0x80000
 10001f8:	fff08093          	addi	x1,x1,-1 # 7fffffff <_end+0x7effdfff>
 10001fc:	00108713          	addi	x14,x1,1
 1000200:	80000eb7          	lui	x29,0x80000
 1000204:	41c1                	c.li	x3,16
 1000206:	0dd71d63          	bne	x14,x29,10002e0 <fail>

0100020a <test_17>:
 100020a:	40b5                	c.li	x1,13
 100020c:	00ad                	c.addi	x1,11
 100020e:	4ee1                	c.li	x29,24
 1000210:	41c5                	c.li	x3,17
 1000212:	0dd09763          	bne	x1,x29,10002e0 <fail>

01000216 <test_18>:
 1000216:	4201                	c.li	x4,0
 1000218:	40b5                	c.li	x1,13
 100021a:	00b08713          	addi	x14,x1,11
 100021e:	00070313          	addi	x6,x14,0
 1000222:	0205                	c.addi	x4,1
 1000224:	4289                	c.li	x5,2
 1000226:	fe5219e3          	bne	x4,x5,1000218 <test_18+0x2>
 100022a:	4ee1                	c.li	x29,24
 100022c:	41c9                	c.li	x3,18
 100022e:	0bd31963          	bne	x6,x29,10002e0 <fail>

01000232 <test_19>:
 1000232:	4201                	c.li	x4,0
 1000234:	40b5                	c.li	x1,13
 1000236:	00a08713          	addi	x14,x1,10
 100023a:	0001                	c.addi	x0,0
 100023c:	00070313          	addi	x6,x14,0
 1000240:	0205                	c.addi	x4,1
 1000242:	4289                	c.li	x5,2
 1000244:	fe5218e3          	bne	x4,x5,1000234 <test_19+0x2>
 1000248:	4edd                	c.li	x29,23
 100024a:	41cd                	c.li	x3,19
 100024c:	09d31a63          	bne	x6,x29,10002e0 <fail>

01000250 <test_20>:
 1000250:	4201                	c.li	x4,0
 1000252:	40b5                	c.li	x1,13
 1000254:	00908713          	addi	x14,x1,9
 1000258:	0001                	c.addi	x0,0
 100025a:	0001                	c.addi	x0,0
 100025c:	00070313          	addi	x6,x14,0
 1000260:	0205                	c.addi	x4,1
 1000262:	4289                	c.li	x5,2
 1000264:	fe5217e3          	bne	x4,x5,1000252 <test_20+0x2>
 1000268:	4ed9                	c.li	x29,22
 100026a:	41d1                	c.li	x3,20
 100026c:	07d31a63          	bne	x6,x29,10002e0 <fail>

01000270 <test_21>:
 1000270:	4201                	c.li	x4,0
 1000272:	40b5                	c.li	x1,13
 1000274:	00b08713          	addi	x14,x1,11
 1000278:	0205                	c.addi	x4,1
 100027a:	4289                	c.li	x5,2
 100027c:	fe521be3          	bne	x4,x5,1000272 <test_21+0x2>
 1000280:	4ee1                	c.li	x29,24
 1000282:	41d5                	c.li	x3,21
 1000284:	05d71e63          	bne	x14,x29,10002e0 <fail>

01000288 <test_22>:
 1000288:	4201                	c.li	x4,0
 100028a:	40b5                	c.li	x1,13
 100028c:	0001                	c.addi	x0,0
 100028e:	00a08713          	addi	x14,x1,10
 1000292:	0205                	c.addi	x4,1
 1000294:	4289                	c.li	x5,2
 1000296:	fe521ae3          	bne	x4,x5,100028a <test_22+0x2>
 100029a:	4edd                	c.li	x29,23
 100029c:	41d9                	c.li	x3,22
 100029e:	05d71163          	bne	x14,x29,10002e0 <fail>

010002a2 <test_23>:
 10002a2:	4201                	c.li	x4,0
 10002a4:	40b5                	c.li	x1,13
 10002a6:	0001                	c.addi	x0,0
 10002a8:	0001                	c.addi	x0,0
 10002aa:	00908713          	addi	x14,x1,9
 10002ae:	0205                	c.addi	x4,1
 10002b0:	4289                	c.li	x5,2
 10002b2:	fe5219e3          	bne	x4,x5,10002a4 <test_23+0x2>
 10002b6:	4ed9                	c.li	x29,22
 10002b8:	41dd                	c.li	x3,23
 10002ba:	03d71363          	bne	x14,x29,10002e0 <fail>

010002be <test_24>:
 10002be:	02000093          	addi	x1,x0,32
 10002c2:	02000e93          	addi	x29,x0,32
 10002c6:	41e1                	c.li	x3,24
 10002c8:	01d09c63          	bne	x1,x29,10002e0 <fail>

010002cc <test_25>:
 10002cc:	02100093          	addi	x1,x0,33
 10002d0:	03208013          	addi	x0,x1,50
 10002d4:	4e81                	c.li	x29,0
 10002d6:	41e5                	c.li	x3,25
 10002d8:	01d01463          	bne	x0,x29,10002e0 <fail>
 10002dc:	00301b63          	bne	x0,x3,10002f2 <pass>

010002e0 <fail>:
 10002e0:	0ff0000f          	fence	iorw,iorw
 10002e4:	00018063          	beq	x3,x0,10002e4 <fail+0x4>
 10002e8:	0186                	c.slli	x3,0x1
 10002ea:	0011e193          	ori	x3,x3,1
 10002ee:	00000073          	ecall

010002f2 <pass>:
 10002f2:	0ff0000f          	fence	iorw,iorw
 10002f6:	4185                	c.li	x3,1
 10002f8:	00000073          	ecall
 10002fc:	0000                	c.unimp
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
