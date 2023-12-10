.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 0
	li $t1, 2
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
	lw $t0, -20($fp)
	li.s $f0, 3.200000
	s.s $f0, 0($t0)
	li $t0, 0
	li $t1, 3
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
	lw $t0, -24($fp)
	li.s $f0, 144.000000
	s.s $f0, 0($t0)
	li $t0, 0
	li $t1, 3
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
	lw $t0, -28($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $t1, 0
	li $t2, 2
	add $t3, $t1, $t2
	sw $t3, -32($fp)
	lw $t1, -32($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -32($fp)
	lw $t1, -32($fp)
	add $t3, $t1, $fp
	sw $t3, -32($fp)
	lw $t1, -32($fp)
	l.s $f0, 0($t1)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t2, 10
	sb $t2, 0($a0)
	li $t2, 0
	sb $t2, 1($a0)
	syscall
	li $t2, 0
	li $t3, 0
	add $t4, $t2, $t3
	sw $t4, -40($fp)
	lw $t2, -40($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -40($fp)
	lw $t2, -40($fp)
	add $t4, $t2, $fp
	sw $t4, -40($fp)
	lw $t2, -40($fp)
	l.s $f0, 0($t2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $t3, 0
	li $t4, 1
	add $t5, $t3, $t4
	sw $t5, -40($fp)
	lw $t3, -40($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -40($fp)
	lw $t3, -40($fp)
	add $t5, $t3, $fp
	sw $t5, -40($fp)
	lw $t3, -40($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t4, 9
	sb $t4, 0($a0)
	li $t4, 0
	sb $t4, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t4, 10
	sb $t4, 0($a0)
	li $t4, 0
	sb $t4, 1($a0)
	syscall
	li $t4, 0
	li $t5, 2
	add $t6, $t4, $t5
	sw $t6, -40($fp)
	lw $t4, -40($fp)
	li $t5, 4
	mult $t4, $t5
	mflo $t6
	sw $t6, -40($fp)
	lw $t4, -40($fp)
	add $t6, $t4, $fp
	sw $t6, -40($fp)
	lw $t4, -40($fp)
	l.s $f0, 0($t4)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t5, 9
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t5, 10
	sb $t5, 0($a0)
	li $t5, 0
	sb $t5, 1($a0)
	syscall
	li $t5, 0
	li $t6, 3
	add $t7, $t5, $t6
	sw $t7, -40($fp)
	lw $t5, -40($fp)
	li $t6, 4
	mult $t5, $t6
	mflo $t7
	sw $t7, -40($fp)
	lw $t5, -40($fp)
	add $t7, $t5, $fp
	sw $t7, -40($fp)
	lw $t5, -40($fp)
	l.s $f0, 0($t5)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t6, 9
	sb $t6, 0($a0)
	li $t6, 0
	sb $t6, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t6, 10
	sb $t6, 0($a0)
	li $t6, 0
	sb $t6, 1($a0)
	syscall
	li $t6, 1
	sw $t6, -36($fp)
	li $v0, 10
	syscall
