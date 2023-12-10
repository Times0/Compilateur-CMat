.data

.globl main
.text
main:
	move $fp, $sp
	li.s $f0, 9.000000
	s.s $f0, -4($fp)
	li $t0, 2
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	add $t2, $t0, $fp
	sw $t2, -28($fp)
	li.s $f0, 1.000000
	lw $t0, -28($fp)
	s.s $f0, 0($t0)
	li $t0, 2
	li $t1, 1
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
	li.s $f0, 4.500000
	lw $t0, -32($fp)
	s.s $f0, 0($t0)
	li $t0, 2
	li $t1, 2
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
	li.s $f0, 3.000000
	lw $t0, -36($fp)
	s.s $f0, 0($t0)
	li $t0, 2
	li $t1, 3
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
	li.s $f0, 144.000000
	lw $t0, -40($fp)
	s.s $f0, 0($t0)
	li $t0, 2
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
	li $t0, 2
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
	lw $t0, -44($fp)
	l.s $f0, 0($t0)
	lw $t1, -48($fp)
	s.s $f0, 0($t1)
	li $t1, 2
	li $t2, 2
	add $t3, $t1, $t2
	sw $t3, -52($fp)
	lw $t1, -52($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -52($fp)
	lw $t1, -52($fp)
	add $t3, $t1, $fp
	sw $t3, -52($fp)
	li $t1, 2
	li $t2, 3
	add $t3, $t1, $t2
	sw $t3, -56($fp)
	lw $t1, -56($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -56($fp)
	lw $t1, -56($fp)
	add $t3, $t1, $fp
	sw $t3, -56($fp)
	lw $t1, -52($fp)
	l.s $f0, 0($t1)
	lw $t2, -56($fp)
	s.s $f0, 0($t2)
	li $t2, 2
	li $t3, 0
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
	lw $t2, -64($fp)
	l.s $f0, 0($t2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t2, 9
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -80($fp)
	li $t2, 10
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $t2, 2
	li $t3, 1
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
	lw $t2, -64($fp)
	l.s $f0, 0($t2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t2, 9
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -80($fp)
	li $t2, 10
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $t2, 2
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
	lw $t2, -64($fp)
	l.s $f0, 0($t2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t2, 9
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -80($fp)
	li $t2, 10
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $t2, 2
	li $t3, 3
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
	lw $t2, -64($fp)
	l.s $f0, 0($t2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t2, 9
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -80($fp)
	li $t2, 10
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $t2, 8
	sw $t2, -8($fp)
	lw $t2, -8($fp)
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 10
	syscall
