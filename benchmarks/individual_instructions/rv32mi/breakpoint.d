
rv32mi/breakpoint.elf:     file format elf32-littleriscv


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
 100001e:	1bef0f13          	addi	x30,x30,446 # 10001d8 <mtvec_handler>
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
 10000f8:	4189                	c.li	x3,2
 10000fa:	7a001073          	csrrw	x0,tselect,x0
 10000fe:	7a0025f3          	csrrs	x11,tselect,x0
 1000102:	0cb01663          	bne	x0,x11,10001ce <pass>
 1000106:	00000617          	auipc	x12,0x0
 100010a:	02260613          	addi	x12,x12,34 # 1000128 <reset_vector+0xe8>
 100010e:	7a261073          	csrrw	x0,tdata2,x12
 1000112:	20000537          	lui	x10,0x20000
 1000116:	04450513          	addi	x10,x10,68 # 20000044 <_end+0x1effe034>
 100011a:	7a151073          	csrrw	x0,tdata1,x10
 100011e:	7a1025f3          	csrrs	x11,tdata1,x0
 1000122:	00b51763          	bne	x10,x11,1000130 <reset_vector+0xf0>
 1000126:	0001                	c.addi	x0,0
 1000128:	08000a63          	beq	x0,x0,10001bc <fail>
 100012c:	418d                	c.li	x3,3
 100012e:	4208                	c.lw	x10,0(x12)
 1000130:	4191                	c.li	x3,4
 1000132:	20000537          	lui	x10,0x20000
 1000136:	04150513          	addi	x10,x10,65 # 20000041 <_end+0x1effe031>
 100013a:	7a151073          	csrrw	x0,tdata1,x10
 100013e:	7a1025f3          	csrrs	x11,tdata1,x0
 1000142:	00b51d63          	bne	x10,x11,100015c <reset_vector+0x11c>
 1000146:	00002617          	auipc	x12,0x2
 100014a:	eba60613          	addi	x12,x12,-326 # 1002000 <begin_signature>
 100014e:	7a261073          	csrrw	x0,tdata2,x12
 1000152:	4210                	c.lw	x12,0(x12)
 1000154:	c625                	c.beqz	x12,10001bc <fail>
 1000156:	4195                	c.li	x3,5
 1000158:	00062023          	sw	x0,0(x12)
 100015c:	4199                	c.li	x3,6
 100015e:	20000537          	lui	x10,0x20000
 1000162:	04250513          	addi	x10,x10,66 # 20000042 <_end+0x1effe032>
 1000166:	7a151073          	csrrw	x0,tdata1,x10
 100016a:	7a1025f3          	csrrs	x11,tdata1,x0
 100016e:	04b51563          	bne	x10,x11,10001b8 <reset_vector+0x178>
 1000172:	c210                	c.sw	x12,0(x12)
 1000174:	419d                	c.li	x3,7
 1000176:	4210                	c.lw	x12,0(x12)
 1000178:	e231                	c.bnez	x12,10001bc <fail>
 100017a:	4505                	c.li	x10,1
 100017c:	7a051073          	csrrw	x0,tselect,x10
 1000180:	7a0025f3          	csrrs	x11,tselect,x0
 1000184:	04b51563          	bne	x10,x11,10001ce <pass>
 1000188:	20000537          	lui	x10,0x20000
 100018c:	04150513          	addi	x10,x10,65 # 20000041 <_end+0x1effe031>
 1000190:	7a151073          	csrrw	x0,tdata1,x10
 1000194:	00002697          	auipc	x13,0x2
 1000198:	e7068693          	addi	x13,x13,-400 # 1002004 <data2>
 100019c:	7a269073          	csrrw	x0,tdata2,x13
 10001a0:	41a1                	c.li	x3,8
 10001a2:	4294                	c.lw	x13,0(x13)
 10001a4:	ce81                	c.beqz	x13,10001bc <fail>
 10001a6:	41a9                	c.li	x3,10
 10001a8:	00002617          	auipc	x12,0x2
 10001ac:	e5860613          	addi	x12,x12,-424 # 1002000 <begin_signature>
 10001b0:	c210                	c.sw	x12,0(x12)
 10001b2:	41ad                	c.li	x3,11
 10001b4:	4210                	c.lw	x12,0(x12)
 10001b6:	e219                	c.bnez	x12,10001bc <fail>
 10001b8:	00301b63          	bne	x0,x3,10001ce <pass>

010001bc <fail>:
 10001bc:	0ff0000f          	fence	iorw,iorw
 10001c0:	00018063          	beq	x3,x0,10001c0 <fail+0x4>
 10001c4:	0186                	c.slli	x3,0x1
 10001c6:	0011e193          	ori	x3,x3,1
 10001ca:	00000073          	ecall

010001ce <pass>:
 10001ce:	0ff0000f          	fence	iorw,iorw
 10001d2:	4185                	c.li	x3,1
 10001d4:	00000073          	ecall

010001d8 <mtvec_handler>:
 10001d8:	0011f293          	andi	x5,x3,1
 10001dc:	fe0290e3          	bne	x5,x0,10001bc <fail>
 10001e0:	428d                	c.li	x5,3
 10001e2:	34202373          	csrrs	x6,mcause,x0
 10001e6:	fc629be3          	bne	x5,x6,10001bc <fail>
 10001ea:	341022f3          	csrrs	x5,mepc,x0
 10001ee:	0291                	c.addi	x5,4
 10001f0:	34129073          	csrrw	x0,mepc,x5
 10001f4:	30200073          	mret
 10001f8:	0000                	c.unimp
 10001fa:	0000                	c.unimp
	...

Disassembly of section .tohost:

01001000 <tohost>:
	...

01001040 <fromhost>:
	...

Disassembly of section .data:

01002000 <begin_signature>:
 1002000:	0000                	c.unimp
	...

01002004 <data2>:
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
