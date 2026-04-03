module single_cycle (
    input  wire        clk,      
    input  wire        rst_n,    
    output wire [15:0] ALU_out   
);

   //Internal nets
   wire [15:0] pc_out;
   wire [15:0] sgn_ext_jump_addr;
   wire        jump;
   wire [15:0] instruction;
   wire [3:0]  rs, rt, rd, im;
   wire [11:0] jump_addr;
   wire        MemRead, MemWrite, RegWrite, ALUsrc, RegDst, MemtoReg;
   wire [2:0]  ALUOp;
   wire [3:0]  writeReg;
   wire [15:0] writeData_reg;
   wire [15:0] readData1, readData2;
   wire [15:0] MemData;
   wire [15:0] ALU_input1, ALU_input2;
   wire [15:0] imm_sgn_ext;

   
   assign sgn_ext_jump_addr = {{4{jump_addr[11]}}, jump_addr}; // Sign-extend the jump address
   assign writeReg          = (RegDst) ? rd : rt; //Choose to which register to write
   assign writeData_reg     = (MemtoReg) ? MemData : ALU_out; //Choose what data to write on the regfile. Mem or ALU result
   assign ALU_input1        = readData1;
   assign imm_sgn_ext       = {{12{im[3]}}, im};               // Sign-extend the immediate value
   assign ALU_input2        = (ALUsrc) ? imm_sgn_ext : readData2;  //Choose the second ALU operand between reg2 or immediate value

   PC pc (
       .clk(clk), 
       .rst(rst_n), 
       .jump(jump), 
       .jump_address(sgn_ext_jump_addr), 
       .pc_out(pc_out)
   );   

   instruction_memory inst_mem (
       .p_in(pc_out[3:0]),   //Last 4 pcbits since we have only 16 instructions
       .instruction(instruction)
   );

   decoder dec (
       .instruction_in(instruction), //Get the full 16bit instruction
       .rs(rs),                      
       .rt(rt), 
       .rd(rd), 
       .im(im), 
       .jump_addr(jump_addr)
   );

   control_unit cu (
       .opcode(instruction[15:12]), 
       .MemRead(MemRead), 
       .MemWrite(MemWrite), 
       .RegWrite(RegWrite), 
       .ALUsrc(ALUsrc), 
       .RegDst(RegDst), 
       .MemtoReg(MemtoReg), 
       .Jump(jump), 
       .alu_op(ALUOp)
   );

   regfile rf (
       .clk(clk), 
       .readReg1(rs), 
       .readReg2(rt), 
       .RegWrite(RegWrite), 
       .writeData(writeData_reg), 
       .readData1(readData1), 
       .readData2(readData2), 
       .writeReg(writeReg)
   );

   alu alu_unit (
       .A(ALU_input1), 
       .B(ALU_input2), 
       .alu_op(ALUOp), 
       .alu_out(ALU_out)
   );

   data_mem data_memory (
       .clk(clk), 
       .MemWrite(MemWrite), 
       .MemRead(MemRead), 
       .addr(ALU_out), 
       .writeData(readData2), 
       .readData(MemData)
   );

endmodule
