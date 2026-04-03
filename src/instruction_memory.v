module instruction_memory(
    input  [3:0]  p_in,         // PC or Address input
    output reg [15:0] instruction
);

    reg [15:0] rom [0:15];  
    
    initial begin
        // Format: Opcode(4) | Rs(4) | Rt(4) | Imm(4)
        rom[0]  = 16'b0110_0000_0011_0111; // addi r3, r0, 7  -> r3 = 7
        rom[1]  = 16'b0110_0000_0100_0101; // addi r4, r0, 5  -> r4 = 5
        rom[2]  = 16'b0001_0011_0100_0101; // sub  r5, r3, r4 -> r5 = 2
        rom[3]  = 16'b0101_0000_0101_0100; // sw   r5, 4(r0)  -> ALU = 4 (Address)
        rom[4]  = 16'b0000_0011_0100_0101; // add  r5, r3, r4 -> r5 = 12
        rom[5]  = 16'b0101_0000_0101_0110; // sw   r5, 6(r0)  -> ALU = 6 (Address)
        rom[6]  = 16'b0110_0000_0010_0010; // addi r2, r0, 2  -> r2 = 2
        rom[7]  = 16'b0100_0010_0011_0010; // lw   r3, 2(r2)  -> ALU = 4 (Address)
        rom[8]  = 16'b0100_0010_0100_0100; // lw   r4, 4(r2)  -> ALU = 6(Address)
        rom[9]  = 16'b0010_0011_0100_0101; // xor  r5, r3, r4 -> ALU = 4 ^ 12 (Εξαρτάται από data_mem)
        rom[10] = 16'b0011_0011_0100_0110; // or   r6, r3, r4 
        rom[11] = 16'b0110_0000_0001_0001; // addi r1, r0, 1  -> r1 = 1 (Ασφαλές 1 αντί για 15)
        rom[12] = 16'b0010_0110_0001_0111; // xor  r7, r6, r1 
        rom[13] = 16'b0101_0000_0111_0111; // sw   r7, 7(r0)  -> ALU = 7 (Address)
        rom[14] = 16'b0111_0000_0000_0000; // jump 0
        rom[15] = 16'h0000;
    end

    always @(*) begin
        instruction = rom[p_in];
    end
endmodule