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
    dut._log.info("Start MIPS Dummy Simulation for Waveforms")

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
    dut._log.info("Reset complete. Starting free-run execution...")

    # --- FREE RUNNING LOOP (No Assertions) ---
    # Τρέχουμε για 20 κύκλους ρολογιού για να δούμε όλη την εκτέλεση
    for cycle in range(20):
        await RisingEdge(dut.clk)
        
        # Παίρνουμε την τιμή κατευθείαν σε μορφή string (binary) 
        # για να αποφύγουμε τα crashes από 'x' ή 'z'
        uio_val = str(dut.uio_out.value)
        uo_val  = str(dut.uo_out.value)
        
        dut._log.info(f"Clock Cycle {cycle}: uio_out={uio_val}, uo_out={uo_val}")

    # Αφήνουμε μερικούς κύκλους στο τέλος πριν κλείσει το simulation
    await ClockCycles(dut.clk, 5)
    dut._log.info("DUMMY SIMULATION COMPLETE. Check your .fst / .vcd file in GTKWave!")
