.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 0
	li $t1, 3
	add $t2, $t0, $t1
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	add $t2, $t1, $fp
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	li.s $f0, 144.000000
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
	add $t2, $t1, $fp
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $t1, 1
	sw $t1, -28($fp)
	li $v0, 10
	syscall
