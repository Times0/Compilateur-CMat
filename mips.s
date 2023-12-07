.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	sw $t0, -4($fp)
	li $t0, 1
	sw $t0, -8($fp)
	li $t0, 0
	sw $t0, -12($fp)
	lw $t0, -4($fp)
	bne $t0, $zero, Label_5
	j Label_25

Label_5:
	lw $t0, -8($fp)
	bne $t0, $zero, Label_7
	j Label_16

Label_7:
	lw $t0, -12($fp)
	bne $t0, $zero, Label_9
	j Label_12

Label_9:
	li $t0, 5
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 5
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_12

Label_12:
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
	j Label_16

Label_16:
	lw $t0, -12($fp)
	bne $t0, $zero, Label_18
	j Label_21

Label_18:
	li $t0, 4
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 4
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_21

Label_21:
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
	j Label_25

Label_25:
	li $v0, 10
	syscall
