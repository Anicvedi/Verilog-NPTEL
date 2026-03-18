module mux_2to1 (out, s, i0, i1);
    input s, i0, i1;
    output out;
    wire sbar;

    // Inverter for select
    not (sbar, s);

    // Transmission-gate based MUX
    cmos cmos_a (out, i0, sbar, s);   // when s=0 → i0
    cmos cmos_b (out, i1, s, sbar);   // when s=1 → i1

endmodule
