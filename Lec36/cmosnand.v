module cmosnand (f, x, y);
    input x, y;
    output f;

    supply1 vdd;
    supply0 gnd;

    wire a;

    // PMOS pull-up
    pmos p1 (f, vdd, x);
    pmos p2 (f, vdd, y);

    // NMOS pull-down
    nmos n1 (f, a, x);
    nmos n2 (a, gnd, y);

endmodule
