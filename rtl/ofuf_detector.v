module ofuf_detector(
  input wire [7:0] cnt,
  input wire preset_n,
  input wire [1:0] rst_ofuf_n,

  output reg of, uf
);

reg of_con, uf_con;

assign of_con_rst_n = preset_n && ~of;
assign uf_con_rst_n = preset_n && ~uf;

assign uf_rst_n = preset_n && rst_ofuf_n[1];
assign of_rst_n = preset_n && rst_ofuf_n[0];

always @(cnt or negedge of_con_rst_n) begin //of_con
  if (!of_con_rst_n) 
    of_con <= 1'b0;
  else begin
    if (cnt == 8'hff)
      of_con <= 1'b1;
    else
      of_con <= 1'b0;
  end
end

always @(cnt or of_con or negedge of_rst_n) begin //of
  if(!of_rst_n) 
    of <= 1'b0;
  else begin
    if (cnt == 8'h00 && of_con)
      of <= 1'b1;
    else
      of <= of;
  end
end

always @(cnt or negedge uf_con_rst_n) begin //uf_con
  if (!uf_con_rst_n) 
    uf_con <= 1'b0;
  else begin
    if (cnt == 8'h00)
      uf_con <= 1'b1;
    else
      uf_con <= 1'b0;
  end
end

always @(cnt or uf_con or negedge uf_rst_n) begin //uf
  if(!uf_rst_n) 
    uf <= 1'b0;
  else begin
    if (cnt == 8'hff && uf_con)
      uf <= 1'b1;
    else
      uf <= uf;
  end
end
endmodule

