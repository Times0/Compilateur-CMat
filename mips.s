.data
	a:	.word 0
	d:	.float 0.0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 4
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -12($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f0, 6.900000
	s.s $f0, -4($fp)
	l.s $f0, -4($fp)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -12($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 3
	la $t1, a
	sw $t0, 0($t1)
	li $t0, 4
	la $t1, a
	sw $t0, 0($t1)
	li $v0, 10
	syscall
