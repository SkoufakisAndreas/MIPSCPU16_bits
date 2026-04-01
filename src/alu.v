module alu 
  #(parameter ADD = 3'b000,
              SUB = 3'b001,
              OR = 3'b010,
              XOR = 3'b011)


(input wire [15:0] A, B,
 input wire [2:0] alu_op,
 output reg [15:0] alu_out);

always @ (*)
   begin
        case(alu_op)
            ADD: alu_out = A + B;
            SUB: alu_out = A - B;
            OR:  alu_out = A | B;
            XOR: alu_out = A ^ B;
            default: alu_out = 16'b0;
        endcase
   end
endmodule
