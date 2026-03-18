module cmosmux_test;

    reg sel, in0, in1;
    wire out;
    integer k;

    // Instantiate DUT
    mux_2to1 MUX21 (out, sel, in0, in1);

    initial begin
        for (k = 0; k < 8; k = k + 1) begin
            #5 {sel, in0, in1} = k;   // correct 3-bit assignment
            #1 $display(
                "Sel: %b, In0: %b, In1: %b, Out: %b",
                 sel, in0, in1, out
            );
        end
        $finish;
    end

endmodule
