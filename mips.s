.data
	a:	.float 0.0

.globl main
.text
main:
	move $fp, $sp
	li.s $f0, 2.200000
	la $t0, a
	s.s $f0, 0($t0)
	l.s $f12, a
	li $v0, 2
	syscall
	li $v0, 10
	syscall
