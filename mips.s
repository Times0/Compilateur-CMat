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
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 84
	sb $t0, 0($a0)
	li $t0, 101
	sb $t0, 1($a0)
	li $t0, 115
	sb $t0, 2($a0)
	li $t0, 116
	sb $t0, 3($a0)
	li $t0, 32
	sb $t0, 4($a0)
	li $t0, 100
	sb $t0, 5($a0)
	li $t0, 101
	sb $t0, 6($a0)
	li $t0, 115
	sb $t0, 7($a0)
	li $t0, 32
	sb $t0, 8($a0)
	li $t0, 111
	sb $t0, 9($a0)
	li $t0, 112
	sb $t0, 10($a0)
	li $t0, -61
	sb $t0, 11($a0)
	li $t0, -87
	sb $t0, 12($a0)
	li $t0, 114
	sb $t0, 13($a0)
	li $t0, 97
	sb $t0, 14($a0)
	li $t0, 116
	sb $t0, 15($a0)
	li $t0, 105
	sb $t0, 16($a0)
	li $t0, 111
	sb $t0, 17($a0)
	li $t0, 110
	sb $t0, 18($a0)
	li $t0, 115
	sb $t0, 19($a0)
	li $t0, 32
	sb $t0, 20($a0)
	li $t0, 97
	sb $t0, 21($a0)
	li $t0, 114
	sb $t0, 22($a0)
	li $t0, 105
	sb $t0, 23($a0)
	li $t0, 116
	sb $t0, 24($a0)
	li $t0, 104
	sb $t0, 25($a0)
	li $t0, 109
	sb $t0, 26($a0)
	li $t0, -61
	sb $t0, 27($a0)
	li $t0, -87
	sb $t0, 28($a0)
	li $t0, 116
	sb $t0, 29($a0)
	li $t0, 105
	sb $t0, 30($a0)
	li $t0, 113
	sb $t0, 31($a0)
	li $t0, 117
	sb $t0, 32($a0)
	li $t0, 101
	sb $t0, 33($a0)
	li $t0, 115
	sb $t0, 34($a0)
	li $t0, 32
	sb $t0, 35($a0)
	li $t0, 115
	sb $t0, 36($a0)
	li $t0, 117
	sb $t0, 37($a0)
	li $t0, 114
	sb $t0, 38($a0)
	li $t0, 32
	sb $t0, 39($a0)
	li $t0, 105
	sb $t0, 40($a0)
	li $t0, 110
	sb $t0, 41($a0)
	li $t0, 116
	sb $t0, 42($a0)
	li $t0, 10
	sb $t0, 43($a0)
	li $t0, 0
	sb $t0, 44($a0)
	syscall
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 1
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f0, 2.500000
	neg.s $f1, $f0
	s.s $f1, -4($fp)
	l.s $f1, -4($fp)
	cvt.w.s $f1, $f1
	mfc1 $t0, $f1
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f1, 1.000000
	li.s $f2, 2.500000
	sub.s $f3, $f1, $f2
	s.s $f3, -4($fp)
	l.s $f1, -4($fp)
	cvt.w.s $f1, $f1
	mfc1 $t0, $f1
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f1, 1.000000
	li.s $f2, 2.500000
	add.s $f3, $f1, $f2
	s.s $f3, -8($fp)
	l.s $f1, -8($fp)
	cvt.w.s $f1, $f1
	mfc1 $t0, $f1
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 5
	mult $t0, $t1
	mflo $t2
	sw $t2, -12($fp)
	lw $t0, -12($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 24
	li $t1, 6
	div $t0, $t1
	mflo $t2
	sw $t2, -16($fp)
	lw $t0, -16($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 26
	li $t1, 6
	div $t0, $t1
	mfhi $t2
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -20($fp)
	li $t0, 84
	sb $t0, 0($a0)
	li $t0, 101
	sb $t0, 1($a0)
	li $t0, 115
	sb $t0, 2($a0)
	li $t0, 116
	sb $t0, 3($a0)
	li $t0, 32
	sb $t0, 4($a0)
	li $t0, 100
	sb $t0, 5($a0)
	li $t0, 101
	sb $t0, 6($a0)
	li $t0, 115
	sb $t0, 7($a0)
	li $t0, 32
	sb $t0, 8($a0)
	li $t0, 111
	sb $t0, 9($a0)
	li $t0, 112
	sb $t0, 10($a0)
	li $t0, -61
	sb $t0, 11($a0)
	li $t0, -87
	sb $t0, 12($a0)
	li $t0, 114
	sb $t0, 13($a0)
	li $t0, 97
	sb $t0, 14($a0)
	li $t0, 116
	sb $t0, 15($a0)
	li $t0, 105
	sb $t0, 16($a0)
	li $t0, 111
	sb $t0, 17($a0)
	li $t0, 110
	sb $t0, 18($a0)
	li $t0, 115
	sb $t0, 19($a0)
	li $t0, 32
	sb $t0, 20($a0)
	li $t0, 97
	sb $t0, 21($a0)
	li $t0, 114
	sb $t0, 22($a0)
	li $t0, 105
	sb $t0, 23($a0)
	li $t0, 116
	sb $t0, 24($a0)
	li $t0, 104
	sb $t0, 25($a0)
	li $t0, 109
	sb $t0, 26($a0)
	li $t0, -61
	sb $t0, 27($a0)
	li $t0, -87
	sb $t0, 28($a0)
	li $t0, 116
	sb $t0, 29($a0)
	li $t0, 105
	sb $t0, 30($a0)
	li $t0, 113
	sb $t0, 31($a0)
	li $t0, 117
	sb $t0, 32($a0)
	li $t0, 101
	sb $t0, 33($a0)
	li $t0, 115
	sb $t0, 34($a0)
	li $t0, 32
	sb $t0, 35($a0)
	li $t0, 115
	sb $t0, 36($a0)
	li $t0, 117
	sb $t0, 37($a0)
	li $t0, 114
	sb $t0, 38($a0)
	li $t0, 32
	sb $t0, 39($a0)
	li $t0, 102
	sb $t0, 40($a0)
	li $t0, 108
	sb $t0, 41($a0)
	li $t0, 111
	sb $t0, 42($a0)
	li $t0, 97
	sb $t0, 43($a0)
	li $t0, 116
	sb $t0, 44($a0)
	li $t0, 10
	sb $t0, 45($a0)
	li $t0, 0
	sb $t0, 46($a0)
	syscall
	li.s $f1, 1.900000
	la $t0, d
	s.s $f1, 0($t0)
	l.s $f1, d
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f1, 2.500000
	neg.s $f2, $f1
	s.s $f2, -24($fp)
	l.s $f2, -24($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.900000
	li.s $f3, 2.500000
	sub.s $f4, $f2, $f3
	s.s $f4, -24($fp)
	l.s $f2, -24($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.900000
	li.s $f3, 2.500000
	add.s $f4, $f2, $f3
	s.s $f4, -28($fp)
	l.s $f2, -28($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 3.500000
	li.s $f3, 5.500000
	mul.s $f4, $f2, $f3
	s.s $f4, -32($fp)
	l.s $f2, -32($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 24.500000
	li.s $f3, 6.500000
	div.s $f4, $f2, $f3
	s.s $f4, -36($fp)
	l.s $f2, -36($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 26
	li $t1, 6
	div $t0, $t1
	mfhi $t2
	sw $t2, -40($fp)
	lw $t0, -40($fp)
	mtc1 $t0, $f2
	cvt.s.w $f2, $f2
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -40($fp)
	li $t0, 84
	sb $t0, 0($a0)
	li $t0, 101
	sb $t0, 1($a0)
	li $t0, 115
	sb $t0, 2($a0)
	li $t0, 116
	sb $t0, 3($a0)
	li $t0, 32
	sb $t0, 4($a0)
	li $t0, 100
	sb $t0, 5($a0)
	li $t0, 101
	sb $t0, 6($a0)
	li $t0, 115
	sb $t0, 7($a0)
	li $t0, 32
	sb $t0, 8($a0)
	li $t0, 111
	sb $t0, 9($a0)
	li $t0, 112
	sb $t0, 10($a0)
	li $t0, -61
	sb $t0, 11($a0)
	li $t0, -87
	sb $t0, 12($a0)
	li $t0, 114
	sb $t0, 13($a0)
	li $t0, 97
	sb $t0, 14($a0)
	li $t0, 116
	sb $t0, 15($a0)
	li $t0, 105
	sb $t0, 16($a0)
	li $t0, 111
	sb $t0, 17($a0)
	li $t0, 110
	sb $t0, 18($a0)
	li $t0, 115
	sb $t0, 19($a0)
	li $t0, 32
	sb $t0, 20($a0)
	li $t0, 97
	sb $t0, 21($a0)
	li $t0, 114
	sb $t0, 22($a0)
	li $t0, 105
	sb $t0, 23($a0)
	li $t0, 116
	sb $t0, 24($a0)
	li $t0, 104
	sb $t0, 25($a0)
	li $t0, 109
	sb $t0, 26($a0)
	li $t0, -61
	sb $t0, 27($a0)
	li $t0, -87
	sb $t0, 28($a0)
	li $t0, 116
	sb $t0, 29($a0)
	li $t0, 105
	sb $t0, 30($a0)
	li $t0, 113
	sb $t0, 31($a0)
	li $t0, 117
	sb $t0, 32($a0)
	li $t0, 101
	sb $t0, 33($a0)
	li $t0, 115
	sb $t0, 34($a0)
	li $t0, 32
	sb $t0, 35($a0)
	li $t0, 115
	sb $t0, 36($a0)
	li $t0, 117
	sb $t0, 37($a0)
	li $t0, 114
	sb $t0, 38($a0)
	li $t0, 32
	sb $t0, 39($a0)
	li $t0, 105
	sb $t0, 40($a0)
	li $t0, 110
	sb $t0, 41($a0)
	li $t0, 116
	sb $t0, 42($a0)
	li $t0, 32
	sb $t0, 43($a0)
	li $t0, 101
	sb $t0, 44($a0)
	li $t0, 116
	sb $t0, 45($a0)
	li $t0, 32
	sb $t0, 46($a0)
	li $t0, 102
	sb $t0, 47($a0)
	li $t0, 108
	sb $t0, 48($a0)
	li $t0, 111
	sb $t0, 49($a0)
	li $t0, 97
	sb $t0, 50($a0)
	li $t0, 116
	sb $t0, 51($a0)
	li $t0, 10
	sb $t0, 52($a0)
	li $t0, 0
	sb $t0, 53($a0)
	syscall
	li.s $f2, 1.000000
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.000000
	li.s $f3, 2.500000
	add.s $f4, $f2, $f3
	s.s $f4, -44($fp)
	l.s $f2, -44($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 2.000000
	li.s $f3, 2.500000
	mul.s $f4, $f2, $f3
	s.s $f4, -48($fp)
	l.s $f2, -48($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 2.500000
	li.s $f3, 2.000000
	div.s $f4, $f2, $f3
	s.s $f4, -52($fp)
	l.s $f2, -52($fp)
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.500000
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li.s $f3, 1.000000
	add.s $f4, $f2, $f3
	la $t0, d
	s.s $f4, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.500000
	la $t0, d
	s.s $f2, 0($t0)
	l.s $f2, d
	li.s $f3, 1.000000
	add.s $f4, $f2, $f3
	la $t0, d
	s.s $f4, 0($t0)
	l.s $f2, d
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -60($fp)
	li $t0, 70
	sb $t0, 0($a0)
	li $t0, 105
	sb $t0, 1($a0)
	li $t0, 110
	sb $t0, 2($a0)
	li $t0, 32
	sb $t0, 3($a0)
	li $t0, 100
	sb $t0, 4($a0)
	li $t0, 101
	sb $t0, 5($a0)
	li $t0, 115
	sb $t0, 6($a0)
	li $t0, 32
	sb $t0, 7($a0)
	li $t0, 116
	sb $t0, 8($a0)
	li $t0, 101
	sb $t0, 9($a0)
	li $t0, 115
	sb $t0, 10($a0)
	li $t0, 116
	sb $t0, 11($a0)
	li $t0, 115
	sb $t0, 12($a0)
	li $t0, 10
	sb $t0, 13($a0)
	li $t0, 0
	sb $t0, 14($a0)
	syscall
	li $t0, 0
	li $t1, 0
	or $t2, $t0, $t1
	sw $t2, -64($fp)
	lw $t0, -64($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 2
	li $t1, 2
	and $t2, $t0, $t1
	sw $t2, -68($fp)
	lw $t0, -68($fp)
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 4
	la $t1, a
	sw $t0, 0($t1)
	lw $t0, a
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 6.900000
	s.s $f2, -72($fp)
	l.s $f2, -72($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $t0, 9
	sw $t0, -52($fp)
	lw $t0, -52($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, 0($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	l.s $f2, -48($fp)
	li $v0, 2
	mov.s $f12, $f2
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
