module regfile (
    input wire clk,                  
    input wire [3:0] readReg1, 
    input wire [3:0] readReg2, 
    input wire [3:0] writeReg,
    input wire [15:0] writeData,
    input wire RegWrite,
    output wire [15:0] readData1,    
    output wire [15:0] readData2
);

    reg [15:0] registers [15:0];

    
    assign readData1 = (readReg1 == 4'b0000) ? 16'h0000 : registers[readReg1];
    assign readData2 = (readReg2 == 4'b0000) ? 16'h0000 : registers[readReg2];

    
    always @(posedge clk) begin
        if (RegWrite && writeReg != 4'b0000) begin
            registers[writeReg] <= writeData;
        end
    end

endmodule