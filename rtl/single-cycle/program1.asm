# RISC-V Simple Processor Test
# Tests: ADDI, ADD, SUB, SW, LW, BEQ, JAL

_start:
    # 1. Test I-Type & Register File (Write)
    addi x1, x0, 5      # Load 5 into x1 (x1 = 5)
    addi x2, x0, 10     # Load 10 into x2 (x2 = 10)
    
    # 2. Test R-Type & ALU
    add  x3, x1, x2     # x3 = x1 + x2 (x3 = 15)
    sub  x4, x2, x1     # x4 = x2 - x1 (x4 = 5)

    # 3. Test Memory operations (Store & Load)
    addi x5, x0, 4      # Set x5 = 4 (Memory Base Address)
    sw   x3, 0(x5)      # Store x3 (15) into DataMemory[4]
    lw   x6, 0(x5)      # Load from DataMemory[4] into x6 (x6 should be 15)

    # 4. Test Branching & Control Unit
    beq  x3, x6, pass   # If x3 == x6 (15 == 15), branch to 'pass' label
    
fail:
    # If the branch failed (memory or ALU is broken), execute this
    addi x7, x0, 0      # Set x7 = 0 (Failure flag)
    jal  x0, end        # Jump to infinite loop

pass:
    # If branch succeeded, execute this
    addi x7, x0, 1      # Set x7 = 1 (Success flag)

end:
    # 5. Test J-Type (Infinite Halt Loop)
    jal  x0, end        # Loop here forever to end the simulation