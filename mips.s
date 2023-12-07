.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)
	li $t0, 2
	li $t1, 1
	blt $t0, $t1, Label_4
	j Label_6

Label_4:
	li $v0, 4
	la $a0, -28($fp)
	li $t0, 60
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	j Label_6

Label_6:
	li $t0, 2
	li $t1, 1
	ble $t0, $t1, Label_8
	j Label_10

Label_8:
	li $v0, 4
	la $a0, -32($fp)
	li $t0, 60
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_10

Label_10:
	li $t0, 2
	li $t1, 1
	bgt $t0, $t1, Label_12
	j Label_14

Label_12:
	li $v0, 4
	la $a0, -28($fp)
	li $t0, 62
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	j Label_14

Label_14:
	li $t0, 2
	li $t1, 1
	bge $t0, $t1, Label_16
	j Label_18

Label_16:
	li $v0, 4
	la $a0, -32($fp)
	li $t0, 62
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_18

Label_18:
	li $t0, 2
	li $t1, 2
	beq $t0, $t1, Label_20
	j Label_22

Label_20:
	li $v0, 4
	la $a0, -32($fp)
	li $t0, 61
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_22

Label_22:
	li $t0, 1
	li $t1, 1
	bne $t0, $t1, Label_26
	j Label_24

Label_24:
	li $t0, 1
	li $t1, 2
	bgt $t0, $t1, Label_26
	j Label_30

Label_26:
	lw $t0, -4($fp)
	li $t1, 0
	bne $t0, $t1, Label_28
	j Label_30

Label_28:
	li $v0, 4
	la $a0, -32($fp)
	li $t0, 33
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_30

Label_30:
	li $t0, 1
	sw $t0, -12($fp)
	li $v0, 10
	syscall
