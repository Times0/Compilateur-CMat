.data
	a:	.float 0.0
	c:	.word 0

.globl main
.text
main:
	move $fp, $sp
	li.s $f0, 2.100000
	la $t0, a
	s.s $f0, 0($t0)
	li $t0, 1
	la $t1, c
	sw $t0, 0($t1)
	l.s $f0, a
	l.s $f1, c
	add.s $f2, $f0, $f1
	s.s $f2, -4($fp)
	l.s $f0, -4($fp)
	s.s $f0, -8($fp)
	l.s $f0, -8($fp)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -32($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	l.s $f0, c
	l.s $f1, a
	add.s $f2, $f0, $f1
	s.s $f2, -12($fp)
	l.s $f0, -12($fp)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 10
	syscall
