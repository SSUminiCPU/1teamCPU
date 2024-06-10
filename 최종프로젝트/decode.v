module decode(in_address, decode_ce, clk, out_address);
    
    input [15:0] in_address;
    input decode_ce, clk;
    output reg [11:0] out_address;
    
    always @(posedge clk)
        if (decode_ce)
            out_address <= in_address[11:0];
    
endmodule
