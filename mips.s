.data

.globl main
.text
main:
	move $fp, $sp
	sw $t-1, -16($fp)
	li $t-1, 0
	li $t0, 0
	add $t1, $t-1, $t0
	sw $t1, -20($fp)
	lw $t-1, -20($fp)
	li $t0, 4
	mult $t-1, $t0
	mflo $t1
	sw $t1, -20($fp)
	lw $t-1, -20($fp)
	add $t1, $t-1, $fp
	sw $t1, -20($fp)
	li.s $f0, 1.000000
	lw $t-1, -20($fp)
	s.s $f0, 0($t-1)
	li $t-2, 0
	li $t-1, 0
	add $t0, $t-2, $t-1
	sw $t0, -36($fp)
	lw $t-2, -36($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -36($fp)
	lw $t-2, -36($fp)
	add $t0, $t-2, $fp
	sw $t0, -36($fp)
	li $t-2, 5
	li $t-1, 0
	add $t0, $t-2, $t-1
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	add $t0, $t-2, $fp
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	l.s $f0, 0($t-2)
	lw $t-1, -36($fp)
	s.s $f0, 0($t-1)
	li $t-2, 0
	li $t-1, 1
	add $t0, $t-2, $t-1
	sw $t0, -36($fp)
	lw $t-2, -36($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -36($fp)
	lw $t-2, -36($fp)
	add $t0, $t-2, $fp
	sw $t0, -36($fp)
	li $t-2, 5
	li $t-1, 1
	add $t0, $t-2, $t-1
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	add $t0, $t-2, $fp
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	l.s $f0, 0($t-2)
	lw $t-1, -36($fp)
	s.s $f0, 0($t-1)
	li $t-2, 0
	li $t-1, 2
	add $t0, $t-2, $t-1
	sw $t0, -36($fp)
	lw $t-2, -36($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -36($fp)
	lw $t-2, -36($fp)
	add $t0, $t-2, $fp
	sw $t0, -36($fp)
	li $t-2, 5
	li $t-1, 2
	add $t0, $t-2, $t-1
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	add $t0, $t-2, $fp
	sw $t0, -40($fp)
	lw $t-2, -40($fp)
	l.s $f0, 0($t-2)
	lw $t-1, -36($fp)
	s.s $f0, 0($t-1)
	li $t-2, 0
	li $t-1, 0
	add $t0, $t-2, $t-1
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	add $t0, $t-2, $fp
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	l.s $f0, 0($t-2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t-2, 9
	sb $t-2, 0($a0)
	li $t-2, 0
	sb $t-2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t-2, 10
	sb $t-2, 0($a0)
	li $t-2, 0
	sb $t-2, 1($a0)
	syscall
	li $t-2, 0
	li $t-1, 1
	add $t0, $t-2, $t-1
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	add $t0, $t-2, $fp
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	l.s $f0, 0($t-2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t-2, 9
	sb $t-2, 0($a0)
	li $t-2, 0
	sb $t-2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t-2, 10
	sb $t-2, 0($a0)
	li $t-2, 0
	sb $t-2, 1($a0)
	syscall
	li $t-2, 0
	li $t-1, 2
	add $t0, $t-2, $t-1
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	li $t-1, 4
	mult $t-2, $t-1
	mflo $t0
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	add $t0, $t-2, $fp
	sw $t0, -44($fp)
	lw $t-2, -44($fp)
	l.s $f0, 0($t-2)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t-2, 9
	sb $t-2, 0($a0)
	li $t-2, 0
	sb $t-2, 1($a0)
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t-2, 10
	sb $t-2, 0($a0)
	li $t-2, 0
	sb $t-2, 1($a0)
	syscall
	li $v0, 10
	syscall
