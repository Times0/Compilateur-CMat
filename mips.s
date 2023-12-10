.data

.globl main
.text
main:
	move $fp, $sp
	li.s $f0, 9.660000
	s.s $f0, -16($fp)
	li.s $f0, 999.000000
	l.s $f1, -16($fp)
	add.s $f2, $f0, $f1
	s.s $f2, -20($fp)
	li $t0, 0
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	add $t2, $t0, $fp
	sw $t2, -24($fp)
	l.s $f0, -20($fp)
	cvt.w.s $f0, $f0
	mfc1 $t0, $f0
	lw $t1, -24($fp)
	sw $t0, 0($t1)
	li $t0, 0
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	add $t2, $t0, $fp
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	lw $t0, 0($t0)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
