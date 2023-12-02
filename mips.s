.data
	a:	.word 0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 9
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -4($fp)
	lw $t0, -4($fp)
	li $t1, 3
	add $t2, $t0, $t1
	sw $t2, -8($fp)
	lw $t0, -8($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $a0, a
	li $v0, 1
	syscall
	li $v0, 10
	syscall
