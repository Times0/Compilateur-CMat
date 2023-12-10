.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 9
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 1
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
	lw $t0, -24($fp)
	li.s $f0, 3.200000
	s.s $f0, 0($t0)
	li $t0, 1
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
	li.s $f0, 144.000000
	s.s $f0, 0($t0)
	li $t0, 1
	li $t1, 3
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
	lw $t0, -32($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $t0, 1
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
	lw $t0, -36($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	li $t1, 0
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
	lw $t0, -44($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
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
	lw $t0, -44($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	li $t1, 2
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
	lw $t0, -44($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	li $t1, 3
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
	lw $t0, -44($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	sw $t0, -40($fp)
	li $v0, 10
	syscall
