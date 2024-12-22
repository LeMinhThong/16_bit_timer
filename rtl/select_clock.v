module select_clock(
input wire        pclk, preset_n,
input wire        tcr_reconf,
input wire [1:0]  cks,

output reg        clk_in
);

reg clk2, clk4, clk8, clk16;
//assign rst_n = ~(~preset_n || tcr_reconf);

//always @(posedge pclk or negedge preset_n or posedge tcr_reconf) begin //clk2
always @(posedge pclk or negedge preset_n) begin
  if (~preset_n) begin
    clk2 <= 1'b0;
  end else begin
    if (tcr_reconf)
      clk2 <= 1'b1;
    else
      clk2 <= ~clk2;
  end
end

//always @(posedge clk2 or negedge preset_n or posedge tcr_reconf) begin //clk4
always @(posedge clk2 or negedge preset_n) begin
  if (~preset_n) begin
    clk4 <= 1'b0;      
  end else begin
    if (tcr_reconf)
      clk4 <= 1'b1;
    else
      clk4 <= ~clk4;
  end
end

//always @(posedge clk4 or negedge preset_n or posedge tcr_reconf) begin //clk8
always @(posedge clk4 or negedge preset_n) begin
  if (~preset_n) begin
    clk8 <= 1'b0;      
  end else begin
    if (tcr_reconf)
      clk8 <= 1'b1;
    else
      clk8 <= ~clk8;
  end
end

//always @(posedge clk8 or negedge preset_n or posedge tcr_reconf) begin //clk16
always @(posedge clk8 or negedge preset_n) begin
  if (~preset_n) begin
    clk16 <= 1'b0;      
  end else begin
    if (tcr_reconf)
      clk16 <= 1'b1;
    else
      clk16 <= ~clk16;
  end
end

//reg clk2, clk4, clk8, clk16;
////assign rst_n = ~(~preset_n || tcr_reconf);
//
////always @(posedge pclk or negedge preset_n or posedge tcr_reconf) begin //clk2
//always @(posedge pclk or negedge preset_n or posedge tcr_reconf) begin
//  if (~preset_n) begin
//    clk2 <= 1'b0;
//  end else begin
//    if (tcr_reconf)
//      clk2 <= 1'b0;
//    else
//      clk2 <= ~clk2;
//  end
//end
//
////always @(posedge clk2 or negedge preset_n or posedge tcr_reconf) begin //clk4
//always @(posedge clk2 or negedge preset_n or posedge tcr_reconf) begin
//  if (~preset_n) begin
//    clk4 <= 1'b0;      
//  end else begin
//    if (tcr_reconf)
//      clk4 <= 1'b0;
//    else
//      clk4 <= ~clk4;
//  end
//end
//
////always @(posedge clk4 or negedge preset_n or posedge tcr_reconf) begin //clk8
//always @(posedge clk4 or negedge preset_n or posedge tcr_reconf) begin
//  if (~preset_n) begin
//    clk8 <= 1'b0;      
//  end else begin
//    if (tcr_reconf)
//      clk8 <= 1'b0;
//    else
//      clk8 <= ~clk8;
//  end
//end
//
////always @(posedge clk8 or negedge preset_n or posedge tcr_reconf) begin //clk16
//always @(posedge clk8 or negedge preset_n or posedge tcr_reconf) begin
//  if (~preset_n) begin
//    clk16 <= 1'b0;      
//  end else begin
//    if (tcr_reconf)
//      clk16 <= 1'b0;
//    else
//      clk16 <= ~clk16;
//  end
//end

always @(clk2 or clk4 or clk8 or clk16 or cks) begin
  case(cks)
    2'b00: clk_in <= clk2;
    2'b01: clk_in <= clk4;
    2'b10: clk_in <= clk8;
    2'b11: clk_in <= clk16;
  endcase
end
endmodule
