.globl factorial

.data
n: .word 5

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    addi sp, sp, -8        # Make space on stack
    sw ra, 4(sp)           # Save return address
    sw a0, 0(sp)           # Save argument n

    li t0, 1               # Base case check: if n == 1
    beq a0, t0, base_case

    addi a0, a0, -1        # a0 = a0 - 1
    jal ra, factorial      # Recursive call factorial(n - 1)

    lw t1, 0(sp)           # Restore original n
    mul a0, a0, t1         # a0 = (n - 1)! * n

    lw ra, 4(sp)           # Restore return address
    addi sp, sp, 8         # Clean up stack
    jr ra                  # Return

base_case:
    li a0, 1               # factorial(1) = 1
    lw ra, 4(sp)           # Restore return address
    addi sp, sp, 8         # Clean up stack
    jr ra                  # Return
