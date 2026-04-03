`default_nettype none

module tt_um_mips_cpu (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

 
  wire [15:0] cpu_alu_result;

  
  single_cycle my_mips (
      .clk(clk),
      .rst_n(rst_n),
      .ALU_out(cpu_alu_result) 
  );

  
  assign uo_out  = cpu_alu_result[7:0];   
  assign uio_out = cpu_alu_result[15:8];  

  assign uio_oe  = 8'hFF;
  
  wire _unused = &{ui_in, uio_in, ena, 1'b0};

endmodule
