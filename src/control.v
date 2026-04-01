module control_unit (input [3:0] opcode,
                     output reg MemRead, MemWrite, RegWrite, ALUsrc, RegDst, MemtoReg, Jump,
                     output reg [2:0] alu_op);
            
        always @(*)
        begin
            MemRead = 0; MemWrite = 0; RegWrite = 0; ALUsrc = 0; RegDst = 0; MemtoReg = 0; Jump = 0;
            alu_op = 3'b000;

            case(opcode)
                4'b0000: begin RegDst=1; ALUsrc=0; MemtoReg=0; RegWrite=1; MemWrite=0; MemRead=0; Jump=0; alu_op=3'b000; end // R-type ADD
                4'b0001: begin RegDst=1; ALUsrc=0; MemtoReg=0; RegWrite=1; MemWrite=0; MemRead=0; Jump=0; alu_op=3'b001; end // R-type SUB
                4'b0010: begin RegDst = 1 ; ALUsrc = 0 ; MemtoReg = 0 ; RegWrite = 1 ; MemWrite = 0 ; MemRead = 0 ; Jump = 0 ; alu_op = 3'b011 ; end // XOR
                4'b0011: begin RegDst = 1 ; ALUsrc = 0 ; MemtoReg = 0 ; RegWrite = 1 ; MemWrite = 0 ; MemRead = 0 ; Jump = 0 ; alu_op = 3'b010 ; end // OR
                4'b0100: begin RegDst=0; ALUsrc=1; MemtoReg=1; RegWrite=1; MemWrite=0; MemRead=1; Jump=0; alu_op=3'b000; end // LW
                4'b0101: begin RegDst=0; ALUsrc=1; MemtoReg=0; RegWrite=0; MemWrite=1; MemRead=0; Jump=0; alu_op=3'b000; end // SW
                4'b0110: begin RegDst=0; ALUsrc=1; MemtoReg=0; RegWrite=1; MemWrite=0; MemRead=0; Jump=0; alu_op=3'b000; end // ADDI
                4'b0111: begin RegDst=0; ALUsrc=0; MemtoReg=0; RegWrite=0; MemWrite=0; MemRead=0; Jump=1; alu_op = 3'b000 ; end // JUMP

                
                default: begin end
            endcase
        end


endmodule