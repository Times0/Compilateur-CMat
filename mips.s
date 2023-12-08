.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)
	li $t0, 2
	li $t1, 9
	mult $t0, $t1
	mflo $t2
	sw $t2, -12($fp)
	li $t0, 1
	lw $t1, -12($fp)
	add $t2, $t0, $t1
	sw $t2, -16($fp)
	li $t0, 4
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -20($fp)
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	add $t2, $t0, $t1
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	li $t1, 7
	add $t2, $t0, $t1
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 2
	li $t1, 1
	blt $t0, $t1, Label_10
	j Label_12

Label_10:
	li $v0, 4
	la $a0, -48($fp)
	li $t0, 60
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	j Label_17

Label_12:
	li $t0, 2
	li $t1, 1
	bgt $t0, $t1, Label_14
	j Label_17

Label_14:
	li $v0, 4
	la $a0, -48($fp)
	li $t0, 62
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	j Label_17
	j Label_17
	li $v0, 10
	syscall
