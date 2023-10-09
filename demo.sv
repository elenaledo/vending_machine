module demo#(
  parameter INIT = 2'b00,
  parameter FIV  = 2'b01,
  parameter TEN  = 2'b10,
  parameter FIF  = 2'b11
)(
  input  logic       nickel_i,  //5
  input  logic       dime_i,    //10
  input  logic       quarter_i, //25
  output logic       soda_o,
  output logic [2:0] change_o,
  input  logic       clk_i
);

  logic [1:0] state, nstate;
  logic [2:0] coin;
  assign coin = {quarter_i,dime_i,nickel_i};

  always_ff@(posedge(clk_i)) begin
    state <= nstate;
    case(state)
      INIT: begin
        case(coin)
          3'b001: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= FIV;
          end
          3'b010: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= TEN;
          end
          3'b100: begin
            soda_o   <= 1'b1;
            change_o <= 3'b001;
            nstate   <= INIT;
          end
          default: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= INIT;
          end
        endcase
      end
      FIV: begin
        case(coin)
          3'b001: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= TEN;
          end
          3'b010: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= FIF;
          end
          3'b100: begin
            soda_o   <= 1'b1;
            change_o <= 3'b010;
            nstate   <= INIT;
          end
          default: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= FIV;
          end
        endcase
      end
      TEN: begin
        case(coin)
          3'b001: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= FIF;
          end
          3'b010: begin
            soda_o   <= 1'b1;
            change_o <= 3'b000;
            nstate   <= INIT;
            end
          3'b100: begin
            soda_o   <= 1'b1;
            change_o <= 3'b011;
            nstate   <= INIT;
            end
          default: begin
            soda_o <= 1'b0;
            change_o <= 3'b000;
            nstate <= TEN;
          end
        endcase
      end
      FIF: begin
        case(coin)
          3'b001: begin
            soda_o   <= 1'b1;
            change_o <= 3'b000;
            nstate   <= INIT;
          end
          3'b010: begin
            soda_o   <= 1'b1;
            change_o <= 3'b001;
            nstate   <= INIT;
            end
          3'b100: begin
            soda_o   <= 1'b1;
            change_o <= 3'b100;
            nstate   <= INIT;
            end
          default: begin
            soda_o   <= 1'b0;
            change_o <= 3'b000;
            nstate   <= FIF;
          end
        endcase
      end
    endcase
  end
  endmodule: demo
