// -------------------- PIPO1 --------------------
module PIPO1 (dout, din, ld, clk);
  input [15:0] din;
  input ld, clk;
  output reg [15:0] dout;

  always @(posedge clk)
    if (ld) dout <= din;
endmodule


// -------------------- PIPO2 --------------------
module PIPO2 (dout, din, ld, clr, clk);
  input [15:0] din;
  input ld, clr, clk;
  output reg [15:0] dout;

  always @(posedge clk)
    if (clr) dout <= 16'b0;
    else if (ld) dout <= din;
endmodule


// -------------------- ADD --------------------
module ADD (out, in1, in2);
  input [15:0] in1, in2;
  output reg [15:0] out;

  always @(*) out = in1 + in2;
endmodule


// -------------------- EQZ --------------------
module EQZ (eqz, data);
  input [15:0] data;
  output eqz;

  assign eqz = (data == 0);
endmodule


// -------------------- CNTR --------------------
module CNTR (dout, din, ld, dec, clk);
  input [15:0] din;
  input ld, dec, clk;
  output reg [15:0] dout;

  always @(posedge clk)
    if (ld) dout <= din;
    else if (dec) dout <= dout - 1;
endmodule


// -------------------- MUL DATAPATH --------------------
module MUL_datapath (eqz, LdA, LdB, LdP, clrP, decB, data_in, clk);
  input LdA, LdB, LdP, clrP, decB, clk;
  input [15:0] data_in;
  output eqz;

  wire [15:0] X, Y, Z, Bout, Bus;

  assign Bus = data_in;

  PIPO1 A (X, Bus, LdA, clk);
  PIPO2 P (Y, Z, LdP, clrP, clk);
  CNTR  B (Bout, Bus, LdB, decB, clk);
  ADD   AD (Z, X, Y);
  EQZ   COMP (eqz, Bout);
endmodule


// -------------------- CONTROLLER --------------------
module controller (LdA, LdB, LdP, clrP, decB, done, clk, eqz, start);
  input clk, eqz, start;
  output reg LdA, LdB, LdP, clrP, decB, done;

  reg [2:0] state;
  parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

  initial state = S0;

  // FSM
  always @(posedge clk) begin
    case (state)
      S0: if (start) state <= S1;
      S1: state <= S2;
      S2: state <= S3;
      S3: if (eqz) state <= S4;
      S4: state <= S4;
      default: state <= S0;
    endcase
  end
  
  // Control signals
  always @(*) begin
  LdA = 0; LdB = 0; LdP = 0;
  clrP = 0; decB = 0; done = 0;

  case (state)
    S1: LdA = 1;

    S2: begin
      LdB = 1;
      clrP = 1;
    end

    S3: begin
      if (!eqz) begin
        LdP = 1;
        decB = 1;
      end
    end

    S4: done = 1;
  endcase
end

endmodule


// -------------------- TESTBENCH --------------------
module MUL_test;
  reg [15:0] data_in;
  reg clk, start;
  wire done, eqz;
  wire LdA, LdB, LdP, clrP, decB;

  MUL_datapath DP (eqz, LdA, LdB, LdP, clrP, decB, data_in, clk);
  controller    CON (LdA, LdB, LdP, clrP, decB, done, clk, eqz, start);

  initial begin
    clk = 0;
    start = 0;
    #5  start = 1;          // aligned with clock
    #200 $finish;
  end

  initial begin
    #15 data_in = 17;
    #10 data_in = 5;
  end

  always #5 clk = ~clk;

  initial begin
    $monitor("%0t\t%d\t%b", $time, DP.Y, done);
    $dumpfile("mul.vcd");
    $dumpvars(0, MUL_test);
  end
endmodule
