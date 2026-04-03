# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
"""
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Set the input values you want to test
    dut.ui_in.value = 20
    dut.uio_in.value = 30

    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk, 1)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == 50

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.
"""
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start MIPS Simulation")

    # Ρολόι στα 10MHz (100ns period)
    clock = Clock(dut.clk, 100, unit="ns")
    cocotb.start_soon(clock.start())

    # --- RESET PHASE ---
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    dut._log.info("Reset complete. Starting instructions...")

    # --- EXPECTED VALUES (ALU Results) ---
    # Ενημερωμένα με τις σωστές τιμές βάσει της εκτέλεσης του MIPS
    # [addi, addi, sub, sw, add, sw, addi, lw, lw, xor, or, addi, xor, sw]
    expected_alu = [7, 5, 2, 4, 12, 6, 2, 4, 6, 14, 14, 1, 15, 7]

    # --- EXECUTION & ASSERTIONS LOOP ---
    for i, expected in enumerate(expected_alu):
        await RisingEdge(dut.clk)
        
        # Συνδυάζουμε τα 16 bits της εξόδου
        actual_value = (int(dut.uio_out.value) << 8) | int(dut.uo_out.value)
        
        dut._log.info(f"Instruction {i}: Expected ALU={expected}, Got={actual_value}")
        
        assert actual_value == expected, f"Error at Instr {i}: Expected {expected}, got {actual_value}"

    await ClockCycles(dut.clk, 2)
    dut._log.info("ALL 14 MIPS INSTRUCTIONS PASSED SUCCESSFULLY!")