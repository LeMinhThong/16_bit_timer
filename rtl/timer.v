module timer(
  input wire pclk,
  input wire preset_n,
  input wire pwrite,
  input wire psel,
  input wire penable,
  input wire [7:0] paddr,
  input wire [7:0] pwdata,

  output wire pready,
  output wire pslverr,
  output wire [7:0] prdata
);

wire [7:0] tdr, tcr, tsr, cnt;
wire clk_in, of, uf;
wire [1:0] rst_ofuf_n;
wire tcr_reconf;

ip_core ip_core0 (
  .pclk           (pclk),
  .preset_n       (preset_n),
  .pwrite         (pwrite),
  .psel           (psel),
  .penable        (penable),
  .paddr          (paddr),
  .pwdata         (pwdata),
  .of             (of),
  .uf             (uf),
                               
  .pready         (pready),
  .pslverr        (pslverr),
  .prdata         (prdata),
  .tdr            (tdr),
  .tcr            (tcr),
  .tsr            (tsr),
  .rst_ofuf_n     (rst_ofuf_n),
  .tcr_reconf     (tcr_reconf)
);

select_clock select_clock0 (
  .pclk           (pclk),
  .preset_n       (preset_n),
  .cks            (tcr[1:0]),
  .tcr_reconf     (tcr_reconf),

  .clk_in         (clk_in)
);

counter counter0(
  .pclk           (pclk),
  .preset_n       (preset_n),
  .clk_in         (clk_in),
  .en             (tcr[4]),
  .load           (tcr[7]),
  .updown         (tcr[5]),
  .tdr            (tdr),
  .tcr_reconf     (tcr_reconf),

  .cnt            (cnt)
);

ofuf_detector ofuf_detector0 (
  .cnt            (cnt),
  .preset_n       (preset_n),
  .of             (of),
  .uf             (uf),
  .rst_ofuf_n       (rst_ofuf_n)
);
endmodule
