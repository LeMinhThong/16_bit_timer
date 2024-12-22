module cks_test();
  reg [7:0] address;
  reg [7:0] wdata, rdata;

  integer delay;

testbench tb();

initial begin
  $display("[write_read_test] WAIT_CYCLES = %d", `WAIT_CYCLES);
  #100;

//////  cks = 00 ////////
  address = 8'h01;
  wdata = 8'b0001_0000;
  tb.cpu.WRITE(address, wdata);
  delay = wdata[1:0];
  #((delay+1)*1000);

  
//////  cks = 01 ////////
  address = 8'h01;
  wdata = 8'b0001_0001;
  tb.cpu.WRITE(address, wdata);
  delay = wdata[1:0];
  #((delay+1)*1000);

//////  cks = 10 ////////
  address = 8'h01;
  wdata = 8'b0001_0010;
  tb.cpu.WRITE(address, wdata);
  delay = wdata[1:0];
  #((delay+1)*1000);

//////  cks = 11 ////////
  address = 8'h01;
  wdata = 8'b0001_0011;
  tb.cpu.WRITE(address, wdata);
  delay = wdata[1:0];
  #((delay+1)*1000);

  #50;
  $finish;
end
time time0, time1;
always @(posedge tb.timer0.pclk) begin //checker
  case (tb.timer0.select_clock0.cks)
    2'b00: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("cks: %b, time: %d", tb.timer0.select_clock0.cks, $time);
        #1;
        @(negedge tb.timer0.counter0.count_en);
        time0 = $time;
        @(negedge tb.timer0.counter0.count_en);
        time1 = $time;
        if ((time1 - time0)/10 == 2) begin
          $display("pass");
        end else begin
          $display("fail, period: %d", time1 - time0);
        end
      end else begin
      end
    end
    2'b01: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("cks: %b, time: %d", tb.timer0.select_clock0.cks, $time);
        #1;
        @(negedge tb.timer0.counter0.count_en);
        time0 = $time;
        @(negedge tb.timer0.counter0.count_en);
        time1 = $time;
        if ((time1 - time0)/10 == 4) begin
          $display("pass");
        end else begin
          $display("fail, period: %d", time1 - time0);
        end
      end else begin
      end
    end
    2'b10: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("cks: %b, time: %d", tb.timer0.select_clock0.cks, $time);
        #1;
        @(negedge tb.timer0.counter0.count_en);
        time0 = $time;
        @(negedge tb.timer0.counter0.count_en);
        time1 = $time;
        if ((time1 - time0)/10 == 8) begin
          $display("pass");
        end else begin
          $display("fail, period: %d", time1 - time0);
        end
      end else begin
      end
    end
    2'b11: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("cks: %b, time: %d", tb.timer0.select_clock0.cks, $time);
        #1;
        @(negedge tb.timer0.counter0.count_en);
        time0 = $time;
        @(negedge tb.timer0.counter0.count_en);
        time1 = $time;
        if ((time1 - time0)/10 == 16) begin
          $display("pass");
        end else begin
          $display("fail, period: %d", time1 - time0);
        end
      end else begin
      end
    end
  endcase
end

initial begin //set preset_n
  tb.sys.preset_n = 1'b0;
  #50;
  tb.sys.preset_n = 1'b1;
end
endmodule
