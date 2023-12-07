.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	sw $t0, -4($fp)
	li $t0, 1
	sw $t0, -8($fp)
	li $t0, 1
	sw $t0, -12($fp)
	lw $t0, -4($fp)
	bne $t0, $zero, Label_5
	j Label_18

Label_5:
	lw $t0, -8($fp)
	bne $t0, $zero, Label_7
	j Label_10

Label_7:
	li $t0, 3
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 3
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_10

Label_10:
	lw $t0, -12($fp)
	bne $t0, $zero, Label_12
	j Label_15

Label_12:
	li $t0, 4
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 4
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_15

Label_15:
	li $t0, 1
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 1
	li $v0, 1
	move $a0, $t0
	syscall
	j Label_18

Label_18:
	li $v0, 10
	syscall
