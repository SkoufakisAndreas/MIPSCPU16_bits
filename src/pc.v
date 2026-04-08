module PC(
    input wire clk, rst, en, jump,
    input wire [2:0] jump_address,
    output reg [2:0] pc_out
);
    
    always @(posedge clk) begin
        if (rst) begin
            pc_out <= 3'd0; // Active-High reset (όπως το έχουμε στο top module)
        end else if (en) begin
           
            pc_out <= jump ? jump_address : (pc_out + 1);
        end
    end
endmodule
