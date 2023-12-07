.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 2
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)
	li $t0, 2
	sw $t0, -12($fp)
	lw $t0, -4($fp)
	bne $t0, $zero, Label_5
	j Label_29

Label_5:
	lw $t0, -12($fp)
	bne $t0, $zero, Label_7
	j Label_9

Label_7:
	lw $t0, -8($fp)
	bne $t0, $zero, Label_11
	j Label_9

Label_9:
	lw $t0, -8($fp)
	bne $t0, $zero, Label_11
	j Label_20

Label_11:
	lw $t0, -12($fp)
	bne $t0, $zero, Label_13
	j Label_16

Label_13:
	li $t0, 5
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 5
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_16

Label_16:
	li $t0, 3
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 3
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 9
	sw $t0, -16($fp)
	j Label_20

Label_20:
	lw $t0, -12($fp)
	bne $t0, $zero, Label_22
	j Label_25

Label_22:
	li $t0, 4
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 4
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_25

Label_25:
	li $t0, 1
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 1
	li $v0, 1
	move $a0, $t0
	syscall
	lw $t0, -12($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_29

Label_29:
	li $v0, 4
	la $a0, -36($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -36($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	lw $t0, -8($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -36($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	lw $t0, -12($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -36($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	lw $t0, -4($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	sw $t0, -4($fp)
	li $v0, 4
	la $a0, -216($fp)
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
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -44($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -44($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f0, 2.500000
	neg.s $f1, $f0
	s.s $f1, -24($fp)
	l.s $f1, -24($fp)
	cvt.w.s $f1, $f1
	mfc1 $t0, $f1
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -44($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f1, 1.000000
	li.s $f2, 2.500000
	sub.s $f3, $f1, $f2
	s.s $f3, -24($fp)
	l.s $f1, -24($fp)
	cvt.w.s $f1, $f1
	mfc1 $t0, $f1
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -48($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f1, 1.000000
	li.s $f2, 2.500000
	add.s $f3, $f1, $f2
	s.s $f3, -28($fp)
	l.s $f1, -28($fp)
	cvt.w.s $f1, $f1
	mfc1 $t0, $f1
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -52($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 5
	mult $t0, $t1
	mflo $t2
	sw $t2, -32($fp)
	lw $t0, -32($fp)
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -56($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 24
	li $t1, 6
	div $t0, $t1
	mflo $t2
	sw $t2, -36($fp)
	lw $t0, -36($fp)
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -60($fp)
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
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -244($fp)
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
	s.s $f1, -16($fp)
	l.s $f1, -16($fp)
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f1, 2.500000
	neg.s $f2, $f1
	s.s $f2, -44($fp)
	l.s $f2, -44($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -64($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.900000
	li.s $f3, 2.500000
	sub.s $f4, $f2, $f3
	s.s $f4, -44($fp)
	l.s $f2, -44($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -68($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.900000
	li.s $f3, 2.500000
	add.s $f4, $f2, $f3
	s.s $f4, -48($fp)
	l.s $f2, -48($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -72($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 3.500000
	li.s $f3, 5.500000
	mul.s $f4, $f2, $f3
	s.s $f4, -52($fp)
	l.s $f2, -52($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -76($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 24.500000
	li.s $f3, 6.500000
	div.s $f4, $f2, $f3
	s.s $f4, -56($fp)
	l.s $f2, -56($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -80($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 26
	li $t1, 6
	div $t0, $t1
	mfhi $t2
	sw $t2, -60($fp)
	lw $t0, -60($fp)
	mtc1 $t0, $f2
	cvt.s.w $f2, $f2
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -292($fp)
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
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 1
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, -84($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.000000
	li.s $f3, 2.500000
	add.s $f4, $f2, $f3
	s.s $f4, -64($fp)
	l.s $f2, -64($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -88($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 2.000000
	li.s $f3, 2.500000
	mul.s $f4, $f2, $f3
	s.s $f4, -68($fp)
	l.s $f2, -68($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -92($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 2.500000
	li.s $f3, 2.000000
	div.s $f4, $f2, $f3
	s.s $f4, -72($fp)
	l.s $f2, -72($fp)
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -96($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.500000
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li.s $f3, 1.000000
	add.s $f4, $f2, $f3
	s.s $f4, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -100($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li.s $f2, 1.500000
	s.s $f2, -16($fp)
	l.s $f2, -16($fp)
	li.s $f3, 1.000000
	add.s $f4, $f2, $f3
	s.s $f4, -16($fp)
	l.s $f2, -16($fp)
	li $v0, 2
	mov.s $f12, $f2
	syscall
	li $v0, 4
	la $a0, -104($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -156($fp)
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
	li $v0, 10
	syscall
