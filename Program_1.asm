# Program_1.asm
# Program contains function that make time decision

# Tell the program where to execute
.globl main

# Allocate memory
.data
    prompt: .asciiz "Please enter a time in hour (1 - 24): "
    text_morning: .asciiz "It is morning.\n"
    text_noon: .asciiz "It is noon.\n"
    text_afternoon: .asciiz "It is afternoon.\n"
    text_invalid: .asciiz "Invalid input! Please enter a number between 1 and 24.\n"

# Code 
.text
main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5               # Syscall to read an integer
    syscall
    move $t1, $v0           # save the input in $t1

    # case 1: the input is less than 1 or greater than 24
    blt $t1, 1, invalid_case
    bgt $t1, 24, invalid_case

    # case 2: the input is valid
    blt $t1, 12, morning    # input is less than 12
    beq $t1, 12, noon       # input is equal to 12
    bgt $t1, 12, afternoon  # input is greater than 12

print_decision:
    li $v0, 4       # Syscall to print string in $a0
    syscall

    li $v0, 10      # Syscall to escape program
    syscall

invalid_case:
    la $a0, text_invalid
    j print_decision
morning: 
    la $a0, text_morning
    j print_decision
noon:
    la $a0, text_noon
    j print_decision
afternoon:
    la $a0, text_afternoon 
    j print_decision

