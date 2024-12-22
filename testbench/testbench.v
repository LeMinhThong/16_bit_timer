module testbench();
wire pclk, preset_n, pwrite, psel, penable;
wire [7:0] paddr;
wire [7:0] pwdata;

wire pready, pslverr;
wire [7:0] prdata;

system_signals sys(
  .pclk     (pclk),
  .preset_n (preset_n)
);

cpu_model cpu(
  .pclk     (pclk),
  .preset_n (preset_n),
  .prdata   (prdata),
  .pready   (pready),
  .pslverr  (pslverr),

  .pwrite   (pwrite),
  .psel     (psel),
  .penable  (penable),
  .paddr    (paddr),
  .pwdata   (pwdata)
);

timer timer0(
  .pclk     (pclk),
  .preset_n (preset_n),
  .pwrite   (pwrite),
  .psel     (psel),
  .penable  (penable),
  .paddr    (paddr),
  .pwdata   (pwdata),

  .prdata   (prdata),
  .pready   (pready),
  .pslverr  (pslverr)
);

endmodule
