.data
	a:	.word 0
	d:	.word 0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 2
	neg $t1, $t0
	sw $t1, -4($fp)
	lw $t1, -4($fp)
	la $t2, a
	sw $t1, 0($t2)
	li $t1, 2
	la $t2, d
	sw $t1, 0($t2)
	lw $t1, d
	li $t2, 9
	add $t3, $t1, $t2
	sw $t3, -4($fp)
	lw $t1, -4($fp)
	la $t2, a
	sw $t1, 0($t2)
	lw $a0, a
	li $v0, 1
	syscall
	li $v0, 10
	syscall
