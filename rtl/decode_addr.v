module decode_addr (
  input wire [7:0] paddr,
  output reg [3:0] select_reg
);

always @(*) begin
  case (paddr)
    8'h00:select_reg <= 4'b0001;
    8'h01:select_reg <= 4'b0010;
    8'h02:select_reg <= 4'b0100;
    default: select_reg <= 4'b0000;
  endcase
end
endmodule
