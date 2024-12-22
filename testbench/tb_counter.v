module tb_counter();
reg pclk, preset_n, en, load, updown; 
reg [1:0] cks;
reg [3:0] tdr;
wire [3:0] cnt;

wire clk_in;
select_clock select_clock0 (
  .pclk       (pclk),
  .rst_n      (preset_n),
  .cks        (cks),

  .clk_in     (clk_in)
);

counter counter0 (
  .pclk       (pclk),
  .preset_n   (preset_n),
  .clk_in     (clk_in),
  .en         (en),
  .load       (load),
  .updown     (updown),
  .tdr        (tdr),

  .cnt        (cnt)
);

initial begin
  pclk = 1'b0; 
  preset_n = 1'b0;
  cks = 2'b00;   
        
  en = 1'b0;   
  load = 1'b0; 
  updown = 1'b0;
  tdr = 4'h0;  
  #5 preset_n = 1'b1;
  #15;

  cks = 2'b01;   
        
  en = 1'b1;   
  load = 1'b0; 
  updown = 1'b1;
  tdr = 4'h3;
  #800 preset_n = 1'b0;
  #140 preset_n = 1'b1;
  #500 $finish;
end

always #10 pclk = ~pclk;
endmodule
