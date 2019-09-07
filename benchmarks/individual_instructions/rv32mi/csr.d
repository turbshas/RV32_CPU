
rv32mi/csr.elf:     file format elf32-littleriscv


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
 100001a:	00000f17          	auipc	x30,0x0
 100001e:	20af0f13          	addi	x30,x30,522 # 1000224 <mtvec_handler>
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
 1000068:	fff28293          	addi	x5,x5,-1 # 7fffffff <_end+0x7effdfef>
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
 10000d8:	00002537          	lui	x10,0x2
 10000dc:	80050513          	addi	x10,x10,-2048 # 1800 <_start-0xffe800>
 10000e0:	30052073          	csrrs	x0,mstatus,x10
 10000e4:	00000297          	auipc	x5,0x0
 10000e8:	01428293          	addi	x5,x5,20 # 10000f8 <reset_vector+0xb8>
 10000ec:	34129073          	csrrw	x0,mepc,x5
 10000f0:	f1402573          	csrrs	x10,mhartid,x0
 10000f4:	30200073          	mret
 10000f8:	3401d073          	csrrwi	x0,mscratch,3

010000fc <test_2>:
 10000fc:	34002573          	csrrs	x10,mscratch,x0
 1000100:	4e8d                	c.li	x29,3
 1000102:	4189                	c.li	x3,2
 1000104:	11d51263          	bne	x10,x29,1000208 <fail>

01000108 <test_3>:
 1000108:	3400f5f3          	csrrci	x11,mscratch,1
 100010c:	4e8d                	c.li	x29,3
 100010e:	418d                	c.li	x3,3
 1000110:	0fd59c63          	bne	x11,x29,1000208 <fail>

01000114 <test_4>:
 1000114:	34026673          	csrrsi	x12,mscratch,4
 1000118:	4e89                	c.li	x29,2
 100011a:	4191                	c.li	x3,4
 100011c:	0fd61663          	bne	x12,x29,1000208 <fail>

01000120 <test_5>:
 1000120:	340156f3          	csrrwi	x13,mscratch,2
 1000124:	4e99                	c.li	x29,6
 1000126:	4195                	c.li	x3,5
 1000128:	0fd69063          	bne	x13,x29,1000208 <fail>

0100012c <test_6>:
 100012c:	0bad2537          	lui	x10,0xbad2
 1000130:	dea50513          	addi	x10,x10,-534 # bad1dea <_end+0xaacfdda>
 1000134:	340515f3          	csrrw	x11,mscratch,x10
 1000138:	4e89                	c.li	x29,2
 100013a:	4199                	c.li	x3,6
 100013c:	0dd59663          	bne	x11,x29,1000208 <fail>

01000140 <test_7>:
 1000140:	00002537          	lui	x10,0x2
 1000144:	dea50513          	addi	x10,x10,-534 # 1dea <_start-0xffe216>
 1000148:	34053573          	csrrc	x10,mscratch,x10
 100014c:	0bad2eb7          	lui	x29,0xbad2
 1000150:	deae8e93          	addi	x29,x29,-534 # bad1dea <_end+0xaacfdda>
 1000154:	419d                	c.li	x3,7
 1000156:	0bd51963          	bne	x10,x29,1000208 <fail>

0100015a <test_8>:
 100015a:	0000c537          	lui	x10,0xc
 100015e:	eef50513          	addi	x10,x10,-273 # beef <_start-0xff4111>
 1000162:	34052573          	csrrs	x10,mscratch,x10
 1000166:	0bad0eb7          	lui	x29,0xbad0
 100016a:	41a1                	c.li	x3,8
 100016c:	09d51e63          	bne	x10,x29,1000208 <fail>

01000170 <test_9>:
 1000170:	34002573          	csrrs	x10,mscratch,x0
 1000174:	0badceb7          	lui	x29,0xbadc
 1000178:	eefe8e93          	addi	x29,x29,-273 # badbeef <_end+0xaad9edf>
 100017c:	41a5                	c.li	x3,9
 100017e:	09d51563          	bne	x10,x29,1000208 <fail>
 1000182:	30102573          	csrrs	x10,misa,x0
 1000186:	02057513          	andi	x10,x10,32
 100018a:	c11d                	c.beqz	x10,10001b0 <test_10+0xe>
 100018c:	6599                	c.lui	x11,0x6
 100018e:	3005a073          	csrrs	x0,mstatus,x11
 1000192:	f0000053          	fmv.w.x	f0,x0
 1000196:	3005b073          	csrrc	x0,mstatus,x11
 100019a:	00002597          	auipc	x11,0x2
 100019e:	e6658593          	addi	x11,x11,-410 # 1002000 <begin_signature>

010001a2 <test_10>:
 10001a2:	0005a027          	fsw	f0,0(x11)
 10001a6:	4188                	c.lw	x10,0(x11)
 10001a8:	4e85                	c.li	x29,1
 10001aa:	41a9                	c.li	x3,10
 10001ac:	05d51e63          	bne	x10,x29,1000208 <fail>
 10001b0:	30102573          	csrrs	x10,misa,x0
 10001b4:	8151                	c.srli	x10,0x14
 10001b6:	8905                	c.andi	x10,1
 10001b8:	c129                	c.beqz	x10,10001fa <finish>
 10001ba:	000022b7          	lui	x5,0x2
 10001be:	80028293          	addi	x5,x5,-2048 # 1800 <_start-0xffe800>
 10001c2:	3002b073          	csrrc	x0,mstatus,x5
 10001c6:	00000297          	auipc	x5,0x0
 10001ca:	01028293          	addi	x5,x5,16 # 10001d6 <test_11>
 10001ce:	34129073          	csrrw	x0,mepc,x5
 10001d2:	30200073          	mret

010001d6 <test_11>:
 10001d6:	0ff00513          	addi	x10,x0,255
 10001da:	c0001573          	csrrw	x10,cycle,x0
 10001de:	0ff00e93          	addi	x29,x0,255
 10001e2:	41ad                	c.li	x3,11
 10001e4:	03d51263          	bne	x10,x29,1000208 <fail>

010001e8 <test_12>:
 10001e8:	0ff00513          	addi	x10,x0,255
 10001ec:	30002573          	csrrs	x10,mstatus,x0
 10001f0:	0ff00e93          	addi	x29,x0,255
 10001f4:	41b1                	c.li	x3,12
 10001f6:	01d51963          	bne	x10,x29,1000208 <fail>

010001fa <finish>:
 10001fa:	0ff0000f          	fence	iorw,iorw
 10001fe:	4185                	c.li	x3,1
 1000200:	00000073          	ecall
 1000204:	00301b63          	bne	x0,x3,100021a <pass>

01000208 <fail>:
 1000208:	0ff0000f          	fence	iorw,iorw
 100020c:	00018063          	beq	x3,x0,100020c <fail+0x4>
 1000210:	0186                	c.slli	x3,0x1
 1000212:	0011e193          	ori	x3,x3,1
 1000216:	00000073          	ecall

0100021a <pass>:
 100021a:	0ff0000f          	fence	iorw,iorw
 100021e:	4185                	c.li	x3,1
 1000220:	00000073          	ecall

01000224 <mtvec_handler>:
 1000224:	42a5                	c.li	x5,9
 1000226:	0051e563          	bltu	x3,x5,1000230 <mtvec_handler+0xc>
 100022a:	42ad                	c.li	x5,11
 100022c:	0032fc63          	bgeu	x5,x3,1000244 <privileged>
 1000230:	342022f3          	csrrs	x5,mcause,x0
 1000234:	4321                	c.li	x6,8
 1000236:	fc6299e3          	bne	x5,x6,1000208 <fail>
 100023a:	0ff0000f          	fence	iorw,iorw
 100023e:	4185                	c.li	x3,1
 1000240:	00000073          	ecall

01000244 <privileged>:
 1000244:	342022f3          	csrrs	x5,mcause,x0
 1000248:	4309                	c.li	x6,2
 100024a:	fa629fe3          	bne	x5,x6,1000208 <fail>
 100024e:	341022f3          	csrrs	x5,mepc,x0
 1000252:	0291                	c.addi	x5,4
 1000254:	34129073          	csrrw	x0,mepc,x5
 1000258:	30200073          	mret
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	0001                	c.addi	x0,0
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	c.jal	fffff980 <_end+0xfeffd970>
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
  1a:	326d                	c.jal	fffff9c4 <_end+0xfeffd9b4>
  1c:	3070                	c.fld	f12,224(x8)
  1e:	615f 7032 5f30      	0x5f307032615f
  24:	3266                	c.fldsp	f4,120(x2)
  26:	3070                	c.fld	f12,224(x8)
  28:	645f 7032 5f30      	0x5f307032645f
  2e:	30703263          	0x30703263
	...
