module system_signals (
  output reg pclk, preset_n
);
initial begin
  pclk = 1'b0;
  preset_n = 1'b0;
  #4; 
  preset_n = 1'b1;
end

always #5 pclk = ~pclk;
endmodule
