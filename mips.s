.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)
	li $t0, 1
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
	li $t0, 8
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
	lw $t0, -16($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_29

Label_29:
	li $v0, 10
	syscall
