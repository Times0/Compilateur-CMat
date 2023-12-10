.data

.globl main
.text
main:
	move $fp, $sp
	li.s $f0, 0.000000
	s.s $f0, -4($fp)
	li $t0, 2
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -32($fp)
	lw $t0, -32($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -32($fp)
	lw $t0, -32($fp)
	add $t2, $t0, $fp
	sw $t2, -32($fp)
	li.s $f0, 1.000000
	lw $t0, -32($fp)
	s.s $f0, 0($t0)
	li $t0, 2
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -36($fp)
	lw $t0, -36($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -36($fp)
	lw $t0, -36($fp)
	add $t2, $t0, $fp
	sw $t2, -36($fp)
	lw $t0, -36($fp)
	l.s $f0, 0($t0)
	neg.s $f1, $f0
	s.s $f1, -40($fp)
	li $t1, 2
	li $t2, 1
	add $t3, $t1, $t2
	sw $t3, -44($fp)
	lw $t1, -44($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -44($fp)
	lw $t1, -44($fp)
	add $t3, $t1, $fp
	sw $t3, -44($fp)
	l.s $f1, -40($fp)
	lw $t1, -44($fp)
	s.s $f1, 0($t1)
	li $t1, 2
	li $t2, 0
	add $t3, $t1, $t2
	sw $t3, -48($fp)
	lw $t1, -48($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -48($fp)
	lw $t1, -48($fp)
	add $t3, $t1, $fp
	sw $t3, -48($fp)
	lw $t1, -48($fp)
	l.s $f1, 0($t1)
	li.s $f2, 3.000000
	add.s $f3, $f1, $f2
	s.s $f3, -52($fp)
	li $t2, 2
	li $t3, 2
	add $t4, $t2, $t3
	sw $t4, -56($fp)
	lw $t2, -56($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -56($fp)
	lw $t2, -56($fp)
	add $t4, $t2, $fp
	sw $t4, -56($fp)
	l.s $f1, -52($fp)
	lw $t2, -56($fp)
	s.s $f1, 0($t2)
	li $t2, 2
	li $t3, 1
	add $t4, $t2, $t3
	sw $t4, -60($fp)
	lw $t2, -60($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -60($fp)
	lw $t2, -60($fp)
	add $t4, $t2, $fp
	sw $t4, -60($fp)
	lw $t2, -60($fp)
	l.s $f1, 0($t2)
	li.s $f2, 2.700000
	sub.s $f3, $f1, $f2
	s.s $f3, -64($fp)
	li $t3, 2
	li $t4, 3
	add $t5, $t3, $t4
	sw $t5, -68($fp)
	lw $t3, -68($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -68($fp)
	lw $t3, -68($fp)
	add $t5, $t3, $fp
	sw $t5, -68($fp)
	l.s $f1, -64($fp)
	lw $t3, -68($fp)
	s.s $f1, 0($t3)
	li $t3, 2
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
	li $t3, 2
	li $t4, 3
	add $t5, $t3, $t4
	sw $t5, -76($fp)
	lw $t3, -76($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -76($fp)
	lw $t3, -76($fp)
	add $t5, $t3, $fp
	sw $t5, -76($fp)
	lw $t3, -72($fp)
	l.s $f1, 0($t3)
	lw $t4, -76($fp)
	l.s $f2, 0($t4)
	mul.s $f3, $f1, $f2
	s.s $f3, -80($fp)
	li $t5, 2
	li $t6, 4
	add $t7, $t5, $t6
	sw $t7, -84($fp)
	lw $t5, -84($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -84($fp)
	lw $t5, -84($fp)
	add $t7, $t5, $fp
	sw $t7, -84($fp)
	l.s $f1, -80($fp)
	lw $t5, -84($fp)
	s.s $f1, 0($t5)
	li $t5, 2
	li $t6, 0
	add $t7, $t5, $t6
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	add $t7, $t5, $fp
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	l.s $f1, 0($t5)
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, -112($fp)
	li $t5, 9
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 4
	la $a0, -108($fp)
	li $t5, 10
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $t5, 2
	li $t6, 1
	add $t7, $t5, $t6
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	add $t7, $t5, $fp
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	l.s $f1, 0($t5)
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, -112($fp)
	li $t5, 9
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 4
	la $a0, -108($fp)
	li $t5, 10
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $t5, 2
	li $t6, 2
	add $t7, $t5, $t6
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	add $t7, $t5, $fp
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	l.s $f1, 0($t5)
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, -112($fp)
	li $t5, 9
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 4
	la $a0, -108($fp)
	li $t5, 10
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $t5, 2
	li $t6, 3
	add $t7, $t5, $t6
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	add $t7, $t5, $fp
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	l.s $f1, 0($t5)
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, -112($fp)
	li $t5, 9
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 4
	la $a0, -108($fp)
	li $t5, 10
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $t5, 2
	li $t6, 4
	add $t7, $t5, $t6
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	add $t7, $t5, $fp
	sw $t7, -92($fp)
	lw $t5, -92($fp)
	l.s $f1, 0($t5)
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, -112($fp)
	li $t5, 9
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 4
	la $a0, -108($fp)
	li $t5, 10
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 10
	syscall
