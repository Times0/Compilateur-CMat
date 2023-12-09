.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 9
	sw $t0, -4($fp)
	li $t0, 1
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
	li $t1, 5
	sw $t1, 0($t0)
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
	add $t2, $t1, $fp
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	lw $t0, 0($t0)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
