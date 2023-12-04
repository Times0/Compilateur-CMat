.data
	a:	.word 0
	d:	.float 0.0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 0
	li $t1, 0
	or $t2, $t0, $t1
	sw $t2, -4($fp)
	lw $t0, -4($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -8($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 0
	li $t1, 1
	or $t2, $t0, $t1
	sw $t2, -8($fp)
	lw $t0, -8($fp)
	li $t1, 1
	and $t2, $t0, $t1
	sw $t2, -12($fp)
	lw $t0, -12($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
