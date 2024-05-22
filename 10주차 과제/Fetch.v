module Fetch (
    input clk,
    input reset,
    output reg [7:0] pc,
    output [7:0] ir
);
    wire [7:0] memory_data;

    Memory memory (
        .addr(pc),
        .data(memory_data)
    );

    initial begin
        pc = 8'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 8'b0;
        end else begin
            pc <= pc + 1;
        end
    end

    assign ir = memory_data;
endmodule
