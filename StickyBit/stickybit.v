`timescale 1ps/1ps
module stickybit(
    input clk,rst_n,d,output z
);
    parameter S0 = 1'b0,S1 = 1'b1;
    reg s,ns;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            s <= S1;
        end
        else s <= ns;
    end
    always @(*) begin
        case (s)
            S0: begin ns = S0; z = 0; end
            S1:begin
                if (d) begin
                    ns = S1; z=1;
                end
                else begin ns = S0; z=0; end
            end
            default: ns = S1;
        endcase
    end
endmodule