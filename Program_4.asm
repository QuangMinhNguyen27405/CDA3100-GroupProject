.data
    prompt:     .asciiz "Please enter an integer: "
    binMsg:     .asciiz "The binary is: "
    hexMsg:     .asciiz "The hexadecimal is: 0x"
    continueMsg:.asciiz "Would you like to convert another integer? (0 or 1) "
    newline:    .asciiz "\n"
    hexChars:   .asciiz "0123456789ABCDEF"

.text
.globl main

main:
while:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall
    
    # Get number from user
    li $v0, 5
    syscall
    move $s0, $v0   # Save input in $s0
    
    # Print binary message
    li $v0, 4
    la $a0, binMsg
    syscall
    
    # Convert to binary
    move $t0, $s0   # Number to convert
    li $t1, 31      # Start from leftmost bit
    li $t2, 0       # Flag for leading zeros
    
binLoop:
    # Get current bit using shift and mask
    srlv $t3, $t0, $t1    # Shift right
    andi $t3, $t3, 1      # Mask to get current bit
    
    # Skip leading zeros
    bne $t3, 1, checkZero
    li $t2, 1            # Set flag when we find first 1
    
checkZero:
    beqz $t2, skipPrint  # Skip if still in leading zeros
    
    # Print current bit
    li $v0, 1
    move $a0, $t3
    syscall
    
skipPrint:
    addi $t1, $t1, -1     # Move to next bit
    bgez $t1, binLoop     # Continue if not done
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Print hex message
    li $v0, 4
    la $a0, hexMsg
    syscall
    
    # Convert to hex
    move $t0, $s0        # Number to convert
    li $t1, 28          
    la $t2, hexChars    # Load hex chars address
    
hexLoop:
    # Get current nibble
    srlv $t3, $t0, $t1   # Shift right
    andi $t3, $t3, 0xF   # Mask to get nibble
    
    # Get hex character
    add $t4, $t2, $t3    # Add offset to hex chars address
    lb $a0, ($t4)        # Load hex character
    
    # Print hex digit
    li $v0, 11
    syscall
    
    addi $t1, $t1, -4    
    bgez $t1, hexLoop    # Continue if not done
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall
    
    # Ask to continue
    li $v0, 4
    la $a0, continueMsg
    syscall
    
    # Get response
    li $v0, 5
    syscall
    
    # If response is 1, continue loop
    beq $v0, 1, while
    
    # Exit program
    li $v0, 10
    syscall