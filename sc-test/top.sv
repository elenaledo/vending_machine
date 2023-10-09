`default_nettype none

module top
(
  input  logic       nickel_i,  //5
  input  logic       dime_i,    //10
  input  logic       quarter_i, //25
  output logic       soda_o,
  output logic [2:0] change_o,
  input  logic       clk_i
);

demo dut(.*);
endmodule : top
