.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 9
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 3
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)
	li $t0, 2
	li $t1, 9
	mult $t0, $t1
	mflo $t2
	sw $t2, -12($fp)
	li $t0, 1
	lw $t1, -12($fp)
	add $t2, $t0, $t1
	sw $t2, -16($fp)
	li $t0, 4
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -20($fp)
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	add $t2, $t0, $t1
	sw $t2, -24($fp)
	lw $t0, -24($fp)
	li $t1, 7
	add $t2, $t0, $t1
	sw $t2, -28($fp)
	lw $t0, -28($fp)
	li $v0, 1
	move $a0, $t0
	syscall

Label_10:
	lw $t0, -8($fp)
	li $t1, 5
	blt $t0, $t1, Label_12
	j Label_18

Label_12:
	lw $t0, -8($fp)
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
	lw $t0, -8($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -32($fp)
	lw $t0, -32($fp)
	sw $t0, -8($fp)
	lw $t0, -4($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -4($fp)
	j Label_10

Label_18:
	li $t0, 1
	sw $t0, -32($fp)
	li $v0, 10
	syscall
