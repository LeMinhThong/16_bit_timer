module ip_encoder (
  input wire pwrite,
  input wire psel,
  input wire penable,
  input wire [3:0] select_reg,
  input wire pready,
  input wire [7:0] tdr, tcr, tsr,

  output reg [7:0] prdata
);
  
always @(pwrite or psel or penable or pready) begin
  if (~pwrite & psel & penable & pready) begin
    case (select_reg)
      4'b0001:  prdata <= tdr;
      4'b0010:  prdata <= tcr;
      4'b0100:  prdata <= tsr;
      default:  prdata <= 8'h00;
    endcase
  end
  else
    prdata <= 8'h00;
end
endmodule
