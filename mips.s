.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 5
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
	li.s $f0, 1.000000
	lw $t0, -36($fp)
	s.s $f0, 0($t0)
	li $t0, 5
	li $t1, 1
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
	li.s $f0, 2.000000
	lw $t0, -40($fp)
	s.s $f0, 0($t0)
	li $t0, 5
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
	li.s $f0, 3.000000
	lw $t0, -44($fp)
	s.s $f0, 0($t0)
	li $t0, 11
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -60($fp)
	lw $t0, -60($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -60($fp)
	lw $t0, -60($fp)
	add $t2, $t0, $fp
	sw $t2, -60($fp)
	li.s $f0, 4.000000
	lw $t0, -60($fp)
	s.s $f0, 0($t0)
	li $t0, 11
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
	li.s $f0, 5.000000
	lw $t0, -64($fp)
	s.s $f0, 0($t0)
	li $t0, 11
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
	li.s $f0, 6.000000
	lw $t0, -68($fp)
	s.s $f0, 0($t0)
	li $t0, 5
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
	li $t0, 11
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -76($fp)
	lw $t0, -76($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -76($fp)
	lw $t0, -76($fp)
	add $t2, $t0, $fp
	sw $t2, -76($fp)
	lw $t0, -76($fp)
	l.s $f0, 0($t0)
	lw $t1, -72($fp)
	s.s $f0, 0($t1)
	li $t1, 5
	li $t2, 1
	add $t3, $t1, $t2
	sw $t3, -72($fp)
	lw $t1, -72($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -72($fp)
	lw $t1, -72($fp)
	add $t3, $t1, $fp
	sw $t3, -72($fp)
	li $t1, 11
	li $t2, 1
	add $t3, $t1, $t2
	sw $t3, -76($fp)
	lw $t1, -76($fp)
	li $t2, 4
	mult $t1, $t2
	mflo $t3
	sw $t3, -76($fp)
	lw $t1, -76($fp)
	add $t3, $t1, $fp
	sw $t3, -76($fp)
	lw $t1, -76($fp)
	l.s $f0, 0($t1)
	lw $t2, -72($fp)
	s.s $f0, 0($t2)
	li $t2, 5
	li $t3, 2
	add $t4, $t2, $t3
	sw $t4, -72($fp)
	lw $t2, -72($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -72($fp)
	lw $t2, -72($fp)
	add $t4, $t2, $fp
	sw $t4, -72($fp)
	li $t2, 11
	li $t3, 2
	add $t4, $t2, $t3
	sw $t4, -76($fp)
	lw $t2, -76($fp)
	li $t3, 4
	mult $t2, $t3
	mflo $t4
	sw $t4, -76($fp)
	lw $t2, -76($fp)
	add $t4, $t2, $fp
	sw $t4, -76($fp)
	lw $t2, -76($fp)
	l.s $f0, 0($t2)
	lw $t3, -72($fp)
	s.s $f0, 0($t3)
	li $t3, 5
	li $t4, 0
	add $t5, $t3, $t4
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	add $t5, $t3, $fp
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -96($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -92($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $t3, 5
	li $t4, 1
	add $t5, $t3, $t4
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	add $t5, $t3, $fp
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -96($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -92($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $t3, 5
	li $t4, 2
	add $t5, $t3, $t4
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	li $t4, 4
	mult $t3, $t4
	mflo $t5
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	add $t5, $t3, $fp
	sw $t5, -80($fp)
	lw $t3, -80($fp)
	l.s $f0, 0($t3)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -96($fp)
	li $t3, 9
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 4
	la $a0, -92($fp)
	li $t3, 10
	sb $t3, 0($a0)
	li $t3, 0
	sb $t3, 1($a0)
	syscall
	li $v0, 10
	syscall
