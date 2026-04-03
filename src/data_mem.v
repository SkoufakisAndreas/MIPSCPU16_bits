module data_mem(input clk,
                input MemWrite, MemRead,
                input [1:0] addr,
                input[15:0] writeData,
                output reg [15:0] readData);
    
  reg [15:0] memory [3:0]; // 2 words of 16 bits each

    //Asychronous read
    always @(*)
    begin
        if(MemRead)
            readData = memory[addr];
        else
            readData = 16'b0;
    end

    //Synchronous write
    always @(posedge clk)
    begin
        if(MemWrite)
            memory[addr] <= writeData;
    end

endmodule
