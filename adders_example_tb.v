`timescale 1ns/1ns
`include "adders_example.v"

module adders_example_tb;

    // Inputs to the UUT
    reg A, B;
    wire S, C;

    // Instantiate the Half Adder module
    half_adder_dataflow uut (S, C, A, B);

    initial begin
        $display("Time\tA B | S C");
        $monitor("%g\t%b %b | %b %b", $time, A, B, S, C);

        // Test cases
        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;

        $finish;
    end

initial begin
    $dumpfile("adders_example.vcd");
    $dumpvars(0, adders_example_tb);
end


endmodule
