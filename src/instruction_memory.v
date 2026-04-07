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
        rom[5]  = 16'b0100_0010_0011_0000; // lw   r3, 0(r2)  -> r3 = Mem[2+0] (12)
        rom[6]  = 16'b0011_0011_0101_0100; // or  r4, r3, r5   -> r4 = 14
        rom[7] = 16'b0111_0000_0000_0000; // jump 0           -> Loop to start
       
    end

    always @(*) begin
        instruction = rom[p_in];     // Combinational instruction fetch
    end

endmodule
