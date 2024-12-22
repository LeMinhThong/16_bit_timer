module ofuf_test();

reg [7:0] address;
reg [7:0] wdata, rdata;

integer repeatCount = 0;
integer of_event=0, of_pass=0, of_false=0;
integer uf_event=0, uf_pass=0, uf_false=0;

integer of_clear_event=0, of_clear_pass=0, of_clear_false=0;
integer uf_clear_event=0, uf_clear_pass=0, uf_clear_false=0;

testbench tb();

initial begin
  $display("[write_read_test] WAIT_CYCLES = %d", `WAIT_CYCLES);
  #100;
//////////////////////////////////////
// of

  repeatCount = 0;
  repeat(4) begin
    address = 8'h00;
    wdata = 8'hf0;
    tb.cpu.WRITE(address, wdata);
    
    address = 8'h01;
    wdata = 8'b1001_0000;
    tb.cpu.WRITE(address, wdata);
    #600;
    of_event = of_event + 1;
    
    case(repeatCount)
      0:
        begin
          wdata = 8'h00;
          of_clear_event = of_clear_event + 1;
          uf_clear_event = uf_clear_event + 1;
        end
      1:
        begin
          wdata = 8'h01;
          uf_clear_event = uf_clear_event + 1;
        end
      2:
        begin
          wdata = 8'h02;
          of_clear_event = of_clear_event + 1;
        end
      3:
        begin
          wdata = 8'h03;
        end
    endcase
  
    address = 8'h02;
    tb.cpu.WRITE(address, wdata);
    #100;

    repeatCount = repeatCount + 1;
  end
///////////////////////////////////////
// uf

  repeatCount = 0;
  repeat(4) begin
    address = 8'h00;
    wdata = 8'h0f;
    tb.cpu.WRITE(address, wdata);
    
    address = 8'h01;
    wdata = 8'b1011_0000;
    tb.cpu.WRITE(address, wdata);
    #600;
    uf_event = uf_event + 1;
  
    case(repeatCount)
      0:
        begin
          wdata = 8'h00;
          of_clear_event = of_clear_event + 1;
          uf_clear_event = uf_clear_event + 1;
        end
      1:
        begin
          wdata = 8'h01;
          uf_clear_event = uf_clear_event + 1;
        end
      2:
        begin
          wdata = 8'h02;
          of_clear_event = of_clear_event + 1;
        end
      3:
        begin
          wdata = 8'h03;
        end
    endcase
  
    address = 8'h02;
    tb.cpu.WRITE(address, wdata);
    #100;

    repeatCount = repeatCount + 1;
  end
  
///////////////////////////////////////
// ofuf

  repeatCount = 0;
  repeat(4) begin

    address = 8'h00;
    wdata = 8'h0f;
    tb.cpu.WRITE(address, wdata);
    
    address = 8'h01;
    wdata = 8'b1011_0000;
    tb.cpu.WRITE(address, wdata);
    #600;
    uf_event = uf_event + 1;
  
    address = 8'h00;
    wdata = 8'hf0;
    tb.cpu.WRITE(address, wdata);
    
    address = 8'h01;
    wdata = 8'b1001_0000;
    tb.cpu.WRITE(address, wdata);
    #600;
    of_event = of_event + 1;

    case(repeatCount)
      0:
        begin
          wdata = 8'h00;
          of_clear_event = of_clear_event + 1;
          uf_clear_event = uf_clear_event + 1;
        end
      1:
        begin
          wdata = 8'h01;
          uf_clear_event = uf_clear_event + 1;
        end
      2:
        begin
          wdata = 8'h02;
          of_clear_event = of_clear_event + 1;
        end
      3:
        begin
          wdata = 8'h03;
        end
    endcase
  
    address = 8'h02;
    tb.cpu.WRITE(address, wdata);
    #100;

    repeatCount = repeatCount + 1;
  end
  #50;
  
  $display("\noverrall\n");
  $display("of_event expected: %d", of_event);
  $display("of_event relity: %d\tpass: %d\tfalse: %d\n", of_pass+of_false, of_pass, of_false);

  $display("uf_event expected: %d", uf_event);
  $display("uf_event relity: %d\tpass: %d\tfalse: %d\n", uf_pass+uf_false, uf_pass, uf_false);

  $display("clear of expected: %d", of_clear_event);
  $display("clear of relity: %d\tpass: %d\tfalse: %d\n", of_clear_pass+of_clear_false, of_clear_pass, of_clear_false);

  $display("clear uf expected: %d", uf_clear_event);
  $display("clear uf relity: %d\tpass: %d\tfalse: %d\n", uf_clear_pass+uf_clear_false, uf_clear_pass, uf_clear_false);

  #50;
  $finish;
end

initial begin //set preset_n
  tb.sys.preset_n = 1'b0;
  #50;
  tb.sys.preset_n = 1'b1;
end


always @(tb.timer0.cnt) begin //set checker
  case (tb.timer0.cnt)
    8'hff: begin
      @(tb.timer0.cnt);
      if(tb.timer0.cnt == 8'h00) begin
        #1;
        if(tb.timer0.of == 1'b1) begin
          $display("pass of test %d", $time);
          of_pass = of_pass + 1;
        end else begin
          $display ("false of test %d", $time);
          of_false = of_false + 1;
        end
      end else begin
      end
    end

    8'h00: begin
      @(tb.timer0.cnt);
      if(tb.timer0.cnt == 8'hff) begin
        #1;
        if(tb.timer0.uf == 1'b1) begin
          $display("pass uf test %d", $time);
          uf_pass = uf_pass + 1;
        end else begin
          $display ("false uf test %d", $time);
          uf_false = uf_false + 1;
        end
      end else begin
      end
    end
  endcase
end

always @(tb.paddr) begin //clear of checker
  if(tb.paddr == 8'h02) begin
    if(tb.pwdata[0] == 1'b0) begin
      @(negedge tb.penable)
      #1;
      if(tb.timer0.tsr[0] == 1'b0) begin
        of_clear_pass = of_clear_pass + 1;
        $display("pass clear of\t%d", $time);
      end else begin
        $display("false clear of\t%d", $time);
        of_clear_false = of_clear_false + 1;
      end
    end else begin
    end
  end else begin
  end
end

always @(tb.paddr) begin //clear uf checker
  if(tb.paddr == 8'h02) begin
    if(tb.pwdata[1] == 1'b0) begin
      @(negedge tb.penable)
      #1;
      if(tb.timer0.tsr[1] == 1'b0) begin
        $display("pass clear uf\t%d", $time);
        uf_clear_pass = uf_clear_pass + 1;
      end else begin
        $display("false clear uf\t%d", $time);
        uf_clear_false = uf_clear_false + 1;
      end
    end else begin
    end
  end else begin
  end
end

endmodule
