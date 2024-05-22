module Memory (
    input [7:0] addr,
    output [7:0] data
);
    reg [7:0] mem [0:255];

    initial begin
        // Load program
        mem[0] = 8'h01;  // LOAD 3
        mem[1] = 8'h02;  // ADD 9
        mem[2] = 8'hFF;  // HALT
    end

    assign data = mem[addr];
endmodule
