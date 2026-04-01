module decoder (
    input wire [15:0] instruction_in,
    output reg [3:0] rs, rt, rd,
    output reg [3:0] im,
    output reg [11:0] jump_addr);

    wire [3:0] opcode = instruction_in[15:12];

    always @(*)
    begin
        rs = 4'b0000;
        rt = 4'b0000;
        rd = 4'b0000;
        im = 4'b0; 
        jump_addr = 12'b0;

        case(opcode)
            4'b0000, 4'b0001, 4'b0010, 4'b0011: // R-type
            begin 
                rs = instruction_in[11:8];
                rt = instruction_in[7:4];
                rd = instruction_in[3:0];
            end

            4'b0100, 4'b0101, 4'b0110: 
            begin
                rs = instruction_in[11:8];  //SW, LW, XOR
                rt = instruction_in[7:4];
                im = instruction_in[3:0]; 
            end

            4'b0111: 
            begin
                jump_addr = instruction_in[11:0]; // Jump
            end 
            default: ; 
        endcase
    end

endmodule