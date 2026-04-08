module decoder (
    input wire [15:0] instruction_in,
    output reg [2:0] rs, rt, rd,
    output reg [5:0] im,
    output reg [2:0] jump_addr);

    wire [3:0] opcode = instruction_in[15:12];

    always @(*)
    begin
        rs = 3'b000;
        rt = 3'b000;
        rd = 3'b000;
        im = 6'd0; 
        jump_addr = 3'd0;

        case(opcode)
            4'b0000, 4'b0001, 4'b0010, 4'b0011: // R-type
            begin 
                rs = instruction_in[11:9];
                rt = instruction_in[8:6];
                rd = instruction_in[5:3];
            end

            4'b0100, 4'b0101, 4'b0110: 
            begin
                rs = instruction_in[11:9];  //SW, LW, XOR
                rt = instruction_in[8:6];
                im = instruction_in[5:0]; 
            end

            4'b0111: 
            begin
                jump_addr = instruction_in[2:0]; // Jump
            end 
            default: ; 
        endcase
    end

endmodule
