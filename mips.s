.data
	a:	.word 0

.globl main
.text
main:
	li $t0, 9
	la $t1, a
	sw $t0, 0($t1)
	lw $a0, a
	li $v0, 1
	syscall
	li $v0, 10
	syscall
