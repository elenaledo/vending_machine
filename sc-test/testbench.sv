module testbench;
  logic  nickle_tb_i;
  logic  dime_tb_i;
  logic  quarter_tb_i;
  logic  clk_i = 1;
  logic [4:0] change_tb_o;
  logic       soda_tb_o;

demo dut (.clk_i(clk_i), .nickle_i(nickle_tb_i), .dime_i(dime_tb_i), .quarter_i(quarter_tb_i), .change_o(change_tb_o), .soda_o(soda_tb_o));
  
  always #50 clk_i = ~clk_i;
  initial begin

  #0   nickle_tb_i = 1'b1; dime_tb_i = 1'b0; quarter_tb_i = 1'b0;
  #100 nickle_tb_i = 1'b1; dime_tb_i = 1'b0; quarter_tb_i = 1'b0;
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b1; quarter_tb_i = 1'b0; //20
  
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b0; quarter_tb_i = 1'b1; //25
  
  
  #100 nickle_tb_i = 1'b1; dime_tb_i = 1'b0; quarter_tb_i = 1'b0;
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b0; quarter_tb_i = 1'b1; //30
  
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b1; quarter_tb_i = 1'b0;
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b0; quarter_tb_i = 1'b1; //35
  
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b1; quarter_tb_i = 1'b0;
  #100 nickle_tb_i = 1'b1; dime_tb_i = 1'b0; quarter_tb_i = 1'b0;
  #100 nickle_tb_i = 1'b0; dime_tb_i = 1'b0; quarter_tb_i = 1'b1; //40
  

  $dumpfile("test.vcd");
  $finish;
  end
endmodule 
  
