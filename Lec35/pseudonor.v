module pseudonor (x, y, f);
    input x, y;
    output f;

    supply0 gnd;

    // NMOS pull-down network
    nmos nx (f, gnd, x);
    nmos ny (f, gnd, y);

    // Pull-up
    pullup (f);
endmodule
