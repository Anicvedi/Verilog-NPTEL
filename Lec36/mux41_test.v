module mux41_test;

    reg s0, s1, i0, i1, i2, i3;
    wire out;
    integer k;

    mux_4to1 MYMUX41 (out, s0, s1, i0, i1, i2, i3);

    initial begin
        for (k = 0; k < 64; k = k + 1) begin
            #5 {s0, s1, i0, i1, i2, i3} = k;
            #1 $display(
                "Sel: %b%b, In: %b%b%b%b, Out: %b",
                s1, s0, i3, i2, i1, i0, out
            );
        end
        $finish;
    end

endmodule
