`default_nettype none

module instruction_memory(
    input  wire [3:0]  p_in,         // PC input (4 bits για 16 εντολές)
    output reg  [15:0] instruction   // 16-bit instruction output
);

    reg [15:0] rom [0:15];           // ROM array: 16 words, 16 bits each
    
    initial begin
        // Format: Opcode(4) | Rs(4) | Rt(4) | Imm/Rd(4)
        rom[0]  = 16'b0110_0000_0011_0111; // addi r3, r0, 7  -> r3 = 7
        rom[1]  = 16'b0110_0000_0100_0101; // addi r4, r0, 5  -> r4 = 5
        rom[2]  = 16'b0001_0011_0100_0101; // sub  r5, r3, r4 -> r5 = 2
        rom[3]  = 16'b0101_0000_0101_0011; // sw   r5, 3(r0)  -> Mem[3] = 2
        rom[4]  = 16'b0000_0011_0100_0101; // add  r5, r3, r4 -> r5 = 12
        rom[5]  = 16'b0101_0000_0101_0010; // sw   r5, 2(r0)  -> Mem[2] = 12
        rom[6]  = 16'b0110_0000_0010_0010; // addi r2, r0, 2  -> r2 = 2
        rom[7]  = 16'b0100_0010_0011_0000; // lw   r3, 0(r2)  -> r3 = Mem[2+0] (12)
        rom[8]  = 16'b0100_0010_0100_0001; // lw   r4, 1(r2)  -> r4 = Mem[2+1] (2)
        rom[9]  = 16'b0010_0011_0100_0101; // xor  r5, r3, r4 -> r5 = 12 ^ 2
        rom[10] = 16'b0011_0011_0100_0110; // or   r6, r3, r4 -> r6 = 12 | 2
        rom[11] = 16'b0110_0000_0001_0001; // addi r1, r0, 1  -> r1 = 1
        rom[12] = 16'b0010_0110_0001_0111; // xor  r7, r6, r1 -> r7 = r6 ^ 1
        rom[13] = 16'b0101_0000_0111_0001; // sw   r7, 1(r0)  -> Mem[1] = r7 result
        rom[14] = 16'b0111_0000_0000_0000; // jump 0           -> Loop to start
        rom[15] = 16'h0000;                // nop              -> No Operation
    end

    always @(*) begin
        instruction = rom[p_in];     // Combinational instruction fetch
    end

endmodule
