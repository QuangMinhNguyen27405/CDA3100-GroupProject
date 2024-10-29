# Program_2.asm
# A program that calculate the sum of a sequence of number

# Tell the program where to execute
.globl main

# Data section - Allocate memory
.data
    prompt_start: .asciiz "Please enter an integer to start: "
    prompt_sequence: .asciiz "Please enter the number of number: "
    sum_sequence: .asciiz "The sum of the sequence is: "

# Code
.text
main:
    li  $t5, 0          # initialize sum = 0       

    jal input_stream    # jump to input function
    j   test

input_stream: 
    # Print prompt
    li $v0, 4
    la $a0, prompt_start
    syscall

    # Read an integer
    li  $v0, 5               
    syscall
    move $t1, $v0           # save the input in $t1

    # Print prompt
    li $v0, 4
    la $a0, prompt_sequence
    syscall

    li  $v0, 5               # Syscall to read an integer
    syscall
    move $t2, $v0           # save the input in $t2

    add $t3, $t1, $t2   # save the sum of $t1 and $t2 in $t3

    jr  $ra                 # jump back to function

test: 
    slt $t4, $t1, $t3   # test if $t1 < $t3
    bne $t4, $zero, loop    # if true go to loop
    j print_output      # print the output

loop: 
    add $t5, $t1, $t5   # $t4 = $t4 + $t0
    addi $t1, $t1, 1    # $t1 += 1
    j test

print_output:
    la $a0, sum_sequence
    li $v0, 4       # Syscall to print integer in $a0
    syscall

    move  $a0, $t5        # if not true
    li $v0, 1       # Syscall to print integer in $a0
    syscall

    li $v0, 10      # Syscall to escape program
    syscall




