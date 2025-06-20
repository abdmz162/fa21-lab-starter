.import lotsofaccumulators.s#finale

.data
# Test arrays
arr1: .word 0                          # for accumulatorone
arr2: .word 1,2,3,4,5,6,7,0           # for accumulatortwo
arr3: .word -1,-1,-1,0               # for accumulatorfour
arr4: .word 1,0                      # for accumulatorfive

TestPassed: .asciiz "Test Passed!\n"
TestFailed: .asciiz "Test Failed!\n"

.text
main:
    # Test 1: accumulatorone should fail (ra not saved), correct result is 0
    la a0, arr1
    jal accumulatorone
    li t0, 0
    bne a0, t0, Fail

    la a0, arr1
    jal accumulatorthree
    li t0, 0
    bne a0, t0, Fail

    # Test 2: accumulatortwo corrupts stack or crashes
    la a0, arr2
    jal accumulatortwo
    li t0, 28
    bne a0, t0, Fail

    la a0, arr2
    jal accumulatorthree
    li t0, 28
    bne a0, t0, Fail

    # Test 3: accumulatorfour uses uninitialized t2 (wrong result)
    la a0, arr3
    jal accumulatorfour
    li t0, -3
    bne a0, t0, Fail

    la a0, arr3
    jal accumulatorthree
    li t0, -3
    bne a0, t0, Fail

    # Test 4: accumulatorfive double-counts the first value
    la a0, arr4
    jal accumulatorfive
    li t0, 1
    bne a0, t0, Fail

    la a0, arr4
    jal accumulatorthree
    li t0, 1
    bne a0, t0, Fail

    j Pass

Fail:
    la a0, TestFailed
    jal print_string
    j Exit

Pass:
    la a0, TestPassed
    jal print_string

Exit:
    li a0, 10
    ecall

print_string:
    mv a1, a0
    li a0, 4
    ecall
    jr ra
