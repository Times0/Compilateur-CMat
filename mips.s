.data
	a:	.word 0
	d:	.float 0.0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	la $t1, a
	sw $t0, 0($t1)
	li $t0, 2
	li $t1, 2
	or $t2, $t0, $t1
	sw $t2, -4($fp)
	lw $t0, -4($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 1
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -4($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	bne $t0, $zero, Label_9
	j Label_11

Label_9:
	li $t0, 2
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 2
	li $v0, 1
	move $a0, $t0
	syscall

Label_11:
	li $v0, 10
	syscall
