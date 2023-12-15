.data
	a:	.float 0.0
	c:	.word 0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 0
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -16($fp)
	lw $t0, -16($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -16($fp)
	lw $t0, -16($fp)
	add $t2, $t0, $fp
	sw $t2, -16($fp)
	li.s $f0, 1.000000
	lw $t0, -16($fp)
	s.s $f0, 0($t0)
	li $t0, 0
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	add $t2, $t0, $fp
	sw $t2, -20($fp)
	li.s $f0, 2.000000
	lw $t0, -20($fp)
	s.s $f0, 0($t0)
	li $t0, 0
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	add $t2, $t0, $fp
	sw $t2, -24($fp)
	li.s $f0, 3.000000
	lw $t0, -24($fp)
	s.s $f0, 0($t0)
	li $t0, 6
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -40($fp)
	lw $t0, -40($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -40($fp)
	lw $t0, -40($fp)
	add $t2, $t0, $fp
	sw $t2, -40($fp)
	li.s $f0, 4.000000
	lw $t0, -40($fp)
	s.s $f0, 0($t0)
	li $t0, 6
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -44($fp)
	lw $t0, -44($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -44($fp)
	lw $t0, -44($fp)
	add $t2, $t0, $fp
	sw $t2, -44($fp)
	li.s $f0, 5.000000
	lw $t0, -44($fp)
	s.s $f0, 0($t0)
	li $t0, 6
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -48($fp)
	lw $t0, -48($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -48($fp)
	lw $t0, -48($fp)
	add $t2, $t0, $fp
	sw $t2, -48($fp)
	li.s $f0, 6.000000
	lw $t0, -48($fp)
	s.s $f0, 0($t0)
	li $t0, 12
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	add $t2, $t0, $fp
	sw $t2, -64($fp)
	li $t0, 0
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	add $t2, $t0, $fp
	sw $t2, -68($fp)
	li $t0, 6
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -72($fp)
	lw $t0, -72($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -72($fp)
	lw $t0, -72($fp)
	add $t2, $t0, $fp
	sw $t2, -72($fp)
	lw $t0, -64($fp)
	lw $t1, -68($fp)
	l.s $f0, 0($t1)
	lw $t2, -72($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 12
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	add $t2, $t0, $fp
	sw $t2, -64($fp)
	li $t0, 0
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	add $t2, $t0, $fp
	sw $t2, -68($fp)
	li $t0, 6
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -72($fp)
	lw $t0, -72($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -72($fp)
	lw $t0, -72($fp)
	add $t2, $t0, $fp
	sw $t2, -72($fp)
	lw $t0, -64($fp)
	lw $t1, -68($fp)
	l.s $f0, 0($t1)
	lw $t2, -72($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 12
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	add $t2, $t0, $fp
	sw $t2, -64($fp)
	li $t0, 0
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	add $t2, $t0, $fp
	sw $t2, -68($fp)
	li $t0, 6
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -72($fp)
	lw $t0, -72($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -72($fp)
	lw $t0, -72($fp)
	add $t2, $t0, $fp
	sw $t2, -72($fp)
	lw $t0, -64($fp)
	lw $t1, -68($fp)
	l.s $f0, 0($t1)
	lw $t2, -72($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 0
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	add $t2, $t0, $fp
	sw $t2, -64($fp)
	li $t0, 12
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	add $t2, $t0, $fp
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	l.s $f0, 0($t0)
	lw $t1, -64($fp)
	s.s $f0, 0($t1)
	li $t1, 0
	li $t2, 1
	add $t3, $t1, $t2
	sw $t3, -64($fp)
	lw $t1, -64($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -64($fp)
	lw $t1, -64($fp)
	add $t3, $t1, $fp
	sw $t3, -64($fp)
	li $t1, 12
	li $t2, 1
	add $t3, $t1, $t2
	sw $t3, -68($fp)
	lw $t1, -68($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -68($fp)
	lw $t1, -68($fp)
	add $t3, $t1, $fp
	sw $t3, -68($fp)
	lw $t1, -68($fp)
	l.s $f0, 0($t1)
	lw $t2, -64($fp)
	s.s $f0, 0($t2)
	li $t2, 0
	li $t3, 2
	add $t4, $t2, $t3
	sw $t4, -64($fp)
	lw $t2, -64($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -64($fp)
	lw $t2, -64($fp)
	add $t4, $t2, $fp
	sw $t4, -64($fp)
	li $t2, 12
	li $t3, 2
	add $t4, $t2, $t3
	sw $t4, -68($fp)
	lw $t2, -68($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -68($fp)
	lw $t2, -68($fp)
	add $t4, $t2, $fp
	sw $t4, -68($fp)
	lw $t2, -68($fp)
	l.s $f0, 0($t2)
	lw $t3, -64($fp)
	s.s $f0, 0($t3)
	li $t3, 0
	li $t4, 0
	add $t5, $t3, $t4
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	add $t5, $t3, $fp
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -88($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $t3, 0
	li $t4, 1
	add $t5, $t3, $t4
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	add $t5, $t3, $fp
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -88($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $t3, 0
	li $t4, 2
	add $t5, $t3, $t4
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	add $t5, $t3, $fp
	sw $t5, -72($fp)
	lw $t3, -72($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -88($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li.s $f0, 2.100000
	la $t3, a
	s.s $f0, 0($t3)
	li $t3, 1
	la $t4, c
	sw $t3, 0($t4)
	l.s $f0, a
	l.s $f1, c
	add.s $f2, $f0, $f1
	s.s $f2, -64($fp)
	l.s $f0, -64($fp)
	s.s $f0, -68($fp)
	li $v0, 10
	syscall
