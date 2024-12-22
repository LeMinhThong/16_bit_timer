module counter(
  input wire pclk, preset_n, clk_in, en, load, updown,
  input wire [7:0] tdr,
  input wire tcr_reconf,

  output reg [7:0] cnt
);

reg last_clk_in;
wire count_en;
always @(posedge pclk) begin //posedge detection
  last_clk_in <= clk_in;
end
assign count_en = ~last_clk_in & clk_in;

always @(posedge pclk or negedge preset_n) begin //counter
  if (~preset_n) begin
    cnt <= 8'h00;//
  end else begin //preset_n == 1'b1
    if (en) begin
      if (load) begin
        if (tcr_reconf) begin
          cnt <= tdr;
        end else begin
          if (updown) begin
            if (count_en)
              cnt <= cnt - 1;
            else
              cnt <= cnt;
          end else begin //en == 1'b1 & load == 1'b1 & updown == 1'b0
            if (count_en)
              cnt <= cnt + 1;
            else
              cnt <= cnt;
          end
        end
      end else begin //en == 1'b1 & load == 1'b0
        if (updown) begin
          if (tcr_reconf) begin
            cnt <= 8'hff;
          end else begin
            if (count_en)
              cnt <= cnt - 1;
            else
              cnt <= cnt;
          end
        end else begin //en == 1'b1 & load == 1'b0 & updown == 1'b0
          if (tcr_reconf) begin
            cnt <= 8'h00;
          end else begin
            if (count_en)
              cnt <= cnt + 1;
            else 
              cnt <= cnt;
          end
        end
      end
    end else begin //en == 1'b0
      cnt <= cnt;
    end
  end
end
endmodule
