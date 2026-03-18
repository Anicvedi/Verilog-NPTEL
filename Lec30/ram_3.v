module ram_3 (
    output [7:0] data_out,
    input  [7:0] data_in,
    input  [9:0] addr,
    input  wr,
    input  cs
);

    parameter addr_size = 10;
    parameter word_size = 8;
    parameter memory_size = 1024;

    reg [word_size-1:0] mem [0:memory_size-1];

    assign data_out = mem[addr];

    always @ (wr or cs)
    begin
        if (wr && cs)
            mem[addr] = data_in;
    end

endmodule
