module tb_select_clock();
reg pclk, rst_n;
reg [1:0] cks;

wire clk_in;
select_clock select_clock1(
  .pclk     (pclk),
  .rst_n    (rst_n),
  .cks      (cks),

  .clk_in   (clk_in)
);

  initial begin
    pclk = 1'b0;
    rst_n = 1'b0;
    cks = 2'b00;
    #5;
    rst_n = 1'b1;
    #15;
    
    #200;
    cks = 2'b01;
    #400;
    cks = 2'b10;
    #800;
    cks = 2'b11;
    #1600;
    $finish;
  end

  always begin //set clock
    #10;
    pclk = ~pclk;
  end
endmodule
