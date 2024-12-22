module cpu_model(
  input pclk, preset_n, pready, pslverr,
  input [7:0] prdata,

  output reg pwrite, psel, penable,
  output reg [7:0] paddr,
  output reg [7:0] pwdata
);

//////////////////    TASK WRITE     ////////////////////

  task WRITE;
    input [7:0] addr, data;

    begin
      //T1
      @(posedge pclk);
      paddr = addr;
      pwrite = 1'b1;
      psel = 1'b1;
      pwdata = data;
      //T2
      @(posedge pclk);
      penable = 1'b1;
      //T3
      @(posedge pclk);
      while (!pready) begin
        @(posedge pclk);
      end
      psel = 1'b0;
      penable = 1'b0;
    end
  endtask

///////////////////    TASK READ       //////////////////
  
  task READ;
    input [7:0] addr;
    output [7:0] rdata;

    begin
      //T1
      @(posedge pclk);
      paddr = addr;
      pwrite = 1'b0;
      psel = 1'b1;
      //T2
      @(posedge pclk);
      penable = 1'b1;
      //T3
      @(posedge pclk);
      while (!pready) begin
        @(posedge pclk);
      end

      rdata = prdata;
      penable = 1'b0;
      psel = 1'b0;
    end
  endtask

//////////////////////////////////////////////////////

endmodule
