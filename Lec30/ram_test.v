module RAM_test;

    reg  [9:0] address;
    wire [7:0] data_out;
    reg  [7:0] data_in;
    reg  write, select;
    integer k;
    integer myseed;

    ram_3 RAM (
        .data_out(data_out),
        .data_in(data_in),
        .addr(address),
        .wr(write),
        .cs(select)
    );

    initial begin
        $dumpfile("Lec30.vcd");
        $dumpvars(0,RAM_test);
        myseed = 35;

        // Write data
        for (k = 0; k <= 1023; k = k + 1) begin
            address = k;
            data_in = (k + k) % 256;
            write = 1;
            select = 1;
            #2;
            write = 0;
            select = 0;
        end

        // Read random locations
        repeat (20) begin
            #2 address = $random(myseed) % 1024;
            write = 0;
            select = 1;
            $display("Address: %5d, Data: %4d", address, data_out);
        end
    end

endmodule
