.data
	a:	.float 0.0
	d:	.word 0

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
	add $t2, $t0, $t1
	sw $t2, -8($fp)
	lw $t0, -8($fp)
	li $t1, 4
	sub $t2, $t0, $t1
	sw $t2, -12($fp)
	lw $t0, -12($fp)
	li $t1, 6
	add $t2, $t0, $t1
	sw $t2, -16($fp)
	lw $t0, -16($fp)
	mtc1 $t0, $f0
	cvt.s.w $f0, $f0
	la $t0, a
	s.s $f0, 0($t0)
	li $t0, 2
	neg $t1, $t0
	sw $t1, -20($fp)
	lw $t1, -20($fp)
	mtc1 $t1, $f0
	cvt.s.w $f0, $f0
	la $t1, a
	s.s $f0, 0($t1)
	li $t1, 5
	la $t2, d
	sw $t1, 0($t2)
	li.s $f0, 5.200000
	la $t1, a
	s.s $f0, 0($t1)
	l.s $f0, a
	li $v0, 2
	mov.s $f12, $f0
	syscall
	lw $t1, d
	li $v0, 1
	move $a0, $t1
	syscall
	li $v0, 10
	syscall
