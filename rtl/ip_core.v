module ip_core (
  input wire pclk,
  input wire preset_n,
  input wire pwrite,
  input wire psel,
  input wire penable,
  input wire [7:0] paddr,
  input wire [7:0] pwdata,
  input wire of, uf,

  output wire pready,
  output wire pslverr,
  output wire tcr_reconf,
  output wire [1:0] rst_ofuf_n,
  output wire [7:0] prdata,
  output wire [7:0] tdr, tcr, tsr
);

wire [3:0] select_reg;
//wire [7:0] tcr_in, tdr_in, tsr_in;

decode_addr decode_addr0 (
  .paddr      (paddr),
  .select_reg (select_reg)
);

ip_decoder ip_decoder0 (
  .pclk       (pclk),
  .preset_n   (preset_n),
  .penable    (penable),
  .pwrite     (pwrite),
  .psel       (psel),
  .select_reg (select_reg),
  .pwdata     (pwdata),
  .of         (of),
  .uf         (uf),

  .pready     (pready),
  .pslverr    (pslverr),
  .tdr        (tdr),
  .tcr        (tcr),
  .tsr        (tsr),
  .rst_ofuf_n   (rst_ofuf_n),
  .tcr_reconf  (tcr_reconf)
);

ip_encoder ip_encoder0 (
  .pwrite     (pwrite),
  .psel       (psel),
  .penable    (penable),
  .select_reg (select_reg),
  .pready     (pready),
  .tdr        (tdr),
  .tcr        (tcr),
  .tsr        (tsr),

  .prdata(prdata)
);
endmodule
