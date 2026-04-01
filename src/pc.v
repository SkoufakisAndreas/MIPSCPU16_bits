module PC(
  input clk,
  input rst,
  input jump,
  input [15:0] jump_address,
  output reg [15:0] pc_out
);

  reg [15:0] p_c;
  wire [15:0] pc_next;

  assign pc_next = jump ? jump_address : (p_c + 1);

  always @(posedge clk) begin
    if (!rst)
      p_c <= 16'd0;
    else if (p_c >= 16'd15)  // Only 16 instructions
      p_c <= 16'd0;
    else
      p_c <= pc_next;
  end

  always @(*) begin
    pc_out = p_c;
  end

endmodule