module count_test();
  reg [7:0] address;
  reg [7:0] wdata, rdata;

testbench tb();

initial begin
  $display("[write_read_test] WAIT_CYCLES = %d", `WAIT_CYCLES);
  #500;
  
  ///// 1 ///////
  address = 8'h1;
  wdata = 8'b0001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 1 ///////
  address = 8'h1;
  wdata = 8'b0001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 2 ///////
  address = 8'h1;
  wdata = 8'b0011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 2 ///////
  address = 8'h1;
  wdata = 8'b0011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 3 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 3 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 4 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 4 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 3 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 2 ///////
  address = 8'h1;
  wdata = 8'b0011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 1 ///////
  address = 8'h1;
  wdata = 8'b0001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 3 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 1 ///////
  address = 8'h1;
  wdata = 8'b0001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 4 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 1 ///////
  address = 8'h1;
  wdata = 8'b0001_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 2 ///////
  address = 8'h1;
  wdata = 8'b0011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 4 ///////
  address = 8'h00;
  wdata = $urandom_range(8'h90,8'haf);
  tb.cpu.WRITE(address, wdata);

  address = 8'h01;
  wdata = 8'b1011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  ///// 2 ///////
  address = 8'h1;
  wdata = 8'b0011_0000;
  tb.cpu.WRITE(address, wdata);
  #500;
  ///////////////
  #50;
  $finish;
end

always @(posedge tb.pclk) begin //checker
  case (tb.timer0.ip_core0.tcr)
    8'b0001_0000: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("tcr: %b, time: %d", tb.timer0.ip_core0.tcr, $time);
        #1;
        if (tb.timer0.cnt == 8'h00) begin
          @(negedge tb.timer0.counter0.count_en);
          if (tb.timer0.cnt == 8'h01) begin
            @(negedge tb.timer0.counter0.count_en);
            if (tb.timer0.cnt == 8'h02) begin
              $display("pass");
            end else begin
              $display("fail\ttime: %d, cnt: %h, expect: 02", $time, tb.timer0.cnt);
            end
          end else begin
            $display("fail\ttime: %d, cnt: %h, expect: 01", $time, tb.timer0.cnt);
          end
        end else begin
          $display("fail\ttime: %d, cnt: %h, expect: 00", $time, tb.timer0.cnt);
        end
      end else begin
      end
    end
    8'b0011_0000: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("tcr: %b, time: %d", tb.timer0.ip_core0.tcr, $time);
        #1;
        if (tb.timer0.cnt == 8'hff) begin
          @(negedge tb.timer0.counter0.count_en);
          if (tb.timer0.cnt == 8'hfe) begin
            @(negedge tb.timer0.counter0.count_en);
            if (tb.timer0.cnt == 8'hfd) begin
              $display("pass");
            end else begin
              $display("fail\ttime: %d, cnt: %h, expect: fd", $time, tb.timer0.cnt);
            end
          end else begin
            $display("fail\ttime: %d, cnt: %h, expect: fe", $time, tb.timer0.cnt);
          end
        end else begin
          $display("fail\ttime: %d, cnt: %h, expect: ff", $time, tb.timer0.cnt);
        end
      end else begin
      end
    end
    8'b1001_0000: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("tcr: %b, tdr: %h, time: %d", tb.timer0.ip_core0.tcr, tb.timer0.tdr, $time);
        #1;
        if (tb.timer0.cnt == tb.timer0.tdr) begin
          @(negedge tb.timer0.counter0.count_en);
          if (tb.timer0.cnt == (tb.timer0.tdr + 1'b1)) begin
            @(negedge tb.timer0.counter0.count_en);
            if (tb.timer0.cnt == (tb.timer0.tdr + 2'b10)) begin
              $display("pass");
            end else begin
              $display("fail\ttime: %d, cnt: %h, expect: %h", $time, tb.timer0.cnt, tb.timer0.tdr + 2'b10);
            end
          end else begin
            $display("fail\ttime: %d, cnt: %h, expect: %h", $time, tb.timer0.cnt, tb.timer0.tdr + 1'b1);
          end
        end else begin
          $display("fail\ttime: %d, cnt: %h, expect: %h", $time, tb.timer0.cnt, tb.timer0.tdr);
        end
      end else begin
      end
    end
    8'b1011_0000: begin
      if (tb.timer0.counter0.tcr_reconf == 1'b1) begin
        $display("tcr: %b, tdr: %h, time: %d", tb.timer0.ip_core0.tcr, tb.timer0.tdr, $time);
        #1;
        if (tb.timer0.cnt == tb.timer0.tdr) begin
          @(negedge tb.timer0.counter0.count_en);
          if (tb.timer0.cnt == (tb.timer0.tdr - 1'b1)) begin
            @(negedge tb.timer0.counter0.count_en);
            if (tb.timer0.cnt == (tb.timer0.tdr - 2'b10)) begin
              $display("pass");
            end else begin
              $display("fail\ttime: %d, cnt: %h, expect: %h", $time, tb.timer0.cnt, tb.timer0.tdr - 2'b10);
            end
          end else begin
            $display("fail\ttime: %d, cnt: %h, expect: %h", $time, tb.timer0.cnt, tb.timer0.tdr - 1'b1);
          end
        end else begin
          $display("fail\ttime: %d, cnt: %h, expect: %h", $time, tb.timer0.cnt, tb.timer0.tdr);
        end
      end else begin
      end
    end
    default: begin
    end
  endcase
end

initial begin //set preset_n
  tb.sys.preset_n = 1'b0;
  #4;
  tb.sys.preset_n = 1'b1;
end
endmodule
