`define WAIT_CYCLES 0

module ip_decoder (
  input wire pclk,     
  input wire preset_n, 
  input wire penable,  
  input wire pwrite,   
  input wire psel,
  input wire [3:0] select_reg,
  input wire [7:0] pwdata,
  input wire of, uf,
 
  output reg pready,    
  output reg pslverr,
  output reg [1:0] rst_ofuf_n,
  output reg tcr_reconf,
  output reg [7:0] tdr, tcr, tsr
);

reg [2:0] count;

always @(posedge pclk or negedge preset_n) begin //pready
  if (~preset_n) begin
    pready <= 1'b0;
    count <= 3'b000;
  end else begin //preset_n = 1'b1
    if (psel == 1'b1) begin
      if (count == `WAIT_CYCLES) begin
        pready <= 1'b1;
      end else begin
        pready <= 1'b0;
        count <= count + 1'b1;
      end
    end else begin //psel = 1'b0
      pready <= pready;
      count <= 3'b000;
    end
  end
end

always @(posedge pclk or negedge preset_n) begin //pslverr
  if (~preset_n)
    pslverr <= 1'b0;
  else
    pslverr <= (select_reg == 4'h0) ? 1'b1 : 1'b0;
end

always @(posedge pclk or negedge preset_n) begin //tdr
  if (~preset_n)
    tdr <= 8'h00;
  else
    tdr <= (penable & pwrite & psel & select_reg[0] & pready) ? pwdata : tdr;
end

always @(posedge pclk or negedge preset_n) begin //tcr
  if (~preset_n) begin
    tcr <= 8'h00;
    tcr_reconf <= 1'b0;
  end else begin
    if (penable & pwrite & psel & select_reg[1] & pready) begin
      tcr <= pwdata;
      tcr_reconf <= 1'b1;
    end else begin
      tcr <= tcr;
      tcr_reconf <= 1'b0;
    end
  end
end

//always @(posedge pclk or negedge preset_n) begin //tsr
//  if (~preset_n)
//    tsr <= 8'h00;
//  else begin
//    if (penable & pwrite & psel & select_reg[2] & pready) begin
//      if (pwdata[1:0] == 2'b00) begin
//        tsr <= pwdata;
//        rst_ofuf_n <= 2'b00;
//      end else begin
//        tsr[7:2] <= pwdata[7:2];
//        tsr[1:0] <= tsr[1:0];
//        rst_ofuf_n <= 2'b11;
//      end
//    end else begin
//      tsr[1:0] <= {uf, of};
//      rst_ofuf_n <= 2'b11;
//    end
//  end
//end

always @(posedge pclk or negedge preset_n) begin //tsr
  if (~preset_n)
    tsr <= 8'h00;
  else begin
    if (penable & pwrite & psel & select_reg[2] & pready) begin
      case(pwdata[1:0])
        2'b00:
          begin
            tsr <= pwdata;
            rst_ofuf_n <= 2'b00;
          end
        2'b01:
          begin
            tsr <= {pwdata[7:2], 1'b0, tsr[0]};
            rst_ofuf_n <= 2'b01;
          end
        2'b10:
          begin
            tsr <= {pwdata[7:2], tsr[1], 1'b0};
            rst_ofuf_n <= 2'b10;
          end
        2'b11:
          begin
            tsr <= {pwdata[7:2], tsr[1:0]};
            rst_ofuf_n <= 2'b00;
          end
      endcase
    end else begin
      tsr[1:0] <= {uf, of};
      rst_ofuf_n <= 2'b11;
    end
  end
end
endmodule
