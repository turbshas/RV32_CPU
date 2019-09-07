
rv32si/csr.elf:     file format elf32-littleriscv


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
 10000b0:	00000297          	auipc	x5,0x0
 10000b4:	12828293          	addi	x5,x5,296 # 10001d8 <stvec_handler>
 10000b8:	00028e63          	beq	x5,x0,10000d4 <reset_vector+0x94>
 10000bc:	10529073          	csrrw	x0,stvec,x5
 10000c0:	0000b2b7          	lui	x5,0xb
 10000c4:	10928293          	addi	x5,x5,265 # b109 <_start-0xff4ef7>
 10000c8:	30229073          	csrrw	x0,medeleg,x5
 10000cc:	30202373          	csrrs	x6,medeleg,x0
 10000d0:	f66291e3          	bne	x5,x6,1000032 <handle_exception>
 10000d4:	30005073          	csrrwi	x0,mstatus,0
 10000d8:	00001537          	lui	x10,0x1
 10000dc:	80050513          	addi	x10,x10,-2048 # 800 <_start-0xfff800>
 10000e0:	30052073          	csrrs	x0,mstatus,x10
 10000e4:	02200513          	addi	x10,x0,34
 10000e8:	30352073          	csrrs	x0,mideleg,x10
 10000ec:	00000297          	auipc	x5,0x0
 10000f0:	01428293          	addi	x5,x5,20 # 1000100 <reset_vector+0xc0>
 10000f4:	34129073          	csrrw	x0,mepc,x5
 10000f8:	f1402573          	csrrs	x10,mhartid,x0
 10000fc:	30200073          	mret
 1000100:	1401d073          	csrrwi	x0,sscratch,3

01000104 <test_2>:
 1000104:	14002573          	csrrs	x10,sscratch,x0
 1000108:	4e8d                	c.li	x29,3
 100010a:	4189                	c.li	x3,2
 100010c:	0bd51763          	bne	x10,x29,10001ba <fail>

01000110 <test_3>:
 1000110:	1400f5f3          	csrrci	x11,sscratch,1
 1000114:	4e8d                	c.li	x29,3
 1000116:	418d                	c.li	x3,3
 1000118:	0bd59163          	bne	x11,x29,10001ba <fail>

0100011c <test_4>:
 100011c:	14026673          	csrrsi	x12,sscratch,4
 1000120:	4e89                	c.li	x29,2
 1000122:	4191                	c.li	x3,4
 1000124:	09d61b63          	bne	x12,x29,10001ba <fail>

01000128 <test_5>:
 1000128:	140156f3          	csrrwi	x13,sscratch,2
 100012c:	4e99                	c.li	x29,6
 100012e:	4195                	c.li	x3,5
 1000130:	09d69563          	bne	x13,x29,10001ba <fail>

01000134 <test_6>:
 1000134:	0bad2537          	lui	x10,0xbad2
 1000138:	dea50513          	addi	x10,x10,-534 # bad1dea <_end+0xaacfdda>
 100013c:	140515f3          	csrrw	x11,sscratch,x10
 1000140:	4e89                	c.li	x29,2
 1000142:	4199                	c.li	x3,6
 1000144:	07d59b63          	bne	x11,x29,10001ba <fail>

01000148 <test_7>:
 1000148:	00002537          	lui	x10,0x2
 100014c:	dea50513          	addi	x10,x10,-534 # 1dea <_start-0xffe216>
 1000150:	14053573          	csrrc	x10,sscratch,x10
 1000154:	0bad2eb7          	lui	x29,0xbad2
 1000158:	deae8e93          	addi	x29,x29,-534 # bad1dea <_end+0xaacfdda>
 100015c:	419d                	c.li	x3,7
 100015e:	05d51e63          	bne	x10,x29,10001ba <fail>

01000162 <test_8>:
 1000162:	0000c537          	lui	x10,0xc
 1000166:	eef50513          	addi	x10,x10,-273 # beef <_start-0xff4111>
 100016a:	14052573          	csrrs	x10,sscratch,x10
 100016e:	0bad0eb7          	lui	x29,0xbad0
 1000172:	41a1                	c.li	x3,8
 1000174:	05d51363          	bne	x10,x29,10001ba <fail>

01000178 <test_9>:
 1000178:	14002573          	csrrs	x10,sscratch,x0
 100017c:	0badceb7          	lui	x29,0xbadc
 1000180:	eefe8e93          	addi	x29,x29,-273 # badbeef <_end+0xaad9edf>
 1000184:	41a5                	c.li	x3,9
 1000186:	03d51a63          	bne	x10,x29,10001ba <fail>
 100018a:	10000293          	addi	x5,x0,256
 100018e:	1002b073          	csrrc	x0,sstatus,x5
 1000192:	00000297          	auipc	x5,0x0
 1000196:	01028293          	addi	x5,x5,16 # 10001a2 <test_12>
 100019a:	14129073          	csrrw	x0,sepc,x5
 100019e:	10200073          	sret

010001a2 <test_12>:
 10001a2:	0001                	c.addi	x0,0
 10001a4:	4e81                	c.li	x29,0
 10001a6:	41b1                	c.li	x3,12
 10001a8:	01d01963          	bne	x0,x29,10001ba <fail>

010001ac <finish>:
 10001ac:	0ff0000f          	fence	iorw,iorw
 10001b0:	4185                	c.li	x3,1
 10001b2:	00000073          	ecall
 10001b6:	00301b63          	bne	x0,x3,10001cc <pass>

010001ba <fail>:
 10001ba:	0ff0000f          	fence	iorw,iorw
 10001be:	00018063          	beq	x3,x0,10001be <fail+0x4>
 10001c2:	0186                	c.slli	x3,0x1
 10001c4:	0011e193          	ori	x3,x3,1
 10001c8:	00000073          	ecall

010001cc <pass>:
 10001cc:	0ff0000f          	fence	iorw,iorw
 10001d0:	4185                	c.li	x3,1
 10001d2:	00000073          	ecall
 10001d6:	0001                	c.addi	x0,0

010001d8 <stvec_handler>:
 10001d8:	42a5                	c.li	x5,9
 10001da:	0051e563          	bltu	x3,x5,10001e4 <stvec_handler+0xc>
 10001de:	42ad                	c.li	x5,11
 10001e0:	0032fc63          	bgeu	x5,x3,10001f8 <privileged>
 10001e4:	142022f3          	csrrs	x5,scause,x0
 10001e8:	4321                	c.li	x6,8
 10001ea:	fc6298e3          	bne	x5,x6,10001ba <fail>
 10001ee:	0ff0000f          	fence	iorw,iorw
 10001f2:	4185                	c.li	x3,1
 10001f4:	00000073          	ecall

010001f8 <privileged>:
 10001f8:	142022f3          	csrrs	x5,scause,x0
 10001fc:	4309                	c.li	x6,2
 10001fe:	fa629ee3          	bne	x5,x6,10001ba <fail>
 1000202:	141022f3          	csrrs	x5,sepc,x0
 1000206:	0291                	c.addi	x5,4
 1000208:	14129073          	csrrw	x0,sepc,x5
 100020c:	10200073          	sret
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
