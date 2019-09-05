	.file	"SimpleFunctionCall.c"
	.option nopic
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	call	test
	mv	a5,a0
	mv	a0,a5
	lw	ra,12(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.align	2
	.globl	pass
	.type	pass, @function
pass:
	li	a5,1
	mv	a0,a5
	ret
	.size	pass, .-pass
	.align	2
	.globl	get_value
	.type	get_value, @function
get_value:
	li	a5,3
	mv	a0,a5
	ret
	.size	get_value, .-get_value
	.align	2
	.globl	test
	.type	test, @function
test:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	call	get_value
	mv	s0,a0
	call	get_value
	mv	a5,a0
	add	a5,s0,a5
	sw	a5,12(sp)
	lw	a4,12(sp)
	li	a5,6
	bne	a4,a5,.L8
	call	pass
	mv	a5,a0
	j	.L9
.L8:
	call	fail
	mv	a5,a0
.L9:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	test, .-test
	.align	2
	.globl	fail
	.type	fail, @function
fail:
	addi	sp,sp,-16
	li	a5,6
	sw	a5,12(sp)
	lw	a5,12(sp)
	addi	a5,a5,4
	sw	a5,12(sp)
	li	a5,0
	mv	a0,a5
	addi	sp,sp,16
	jr	ra
	.size	fail, .-fail
	.ident	"GCC: (GNU) 8.3.0"
