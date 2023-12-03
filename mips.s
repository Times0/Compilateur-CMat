.data
	a:	.float 0.0
	d:	.word 0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 5
	la $t1, d
	sw $t0, 0($t1)
	li $t0, 4
	neg $t1, $t0
	sw $t1, -4($fp)
	lw $t1, -4($fp)
	li $t2, 6
	sub $t3, $t1, $t2
	sw $t3, -4($fp)
	lw $t1, -4($fp)
	mtc1 $t1, $f0
	cvt.s.w $f0, $f0
	la $t1, a
	s.s $f0, 0($t1)
	l.s $f12, a
	li $v0, 2
	syscall
	li $v0, 10
	syscall
