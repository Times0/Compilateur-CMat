.data
	a:	.float 0.0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -4($fp)
	lw $t0, -4($fp)
	li $t1, 3
	mult $t0, $t1
	mflo $t2
	sw $t2, -8($fp)
	lw $t0, -8($fp)
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	la $t0, a
	s.s $f0, 0($t0)
	l.s $f12, a
	li $v0, 2
	syscall
	li $v0, 10
	syscall
