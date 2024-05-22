module Execute (
    input clk,
    input reset,
    input [7:0] alu_op1,
    input [7:0] alu_op2,
    input [2:0] alu_operation,
    output reg [7:0] acc,
    output [7:0] alu_result
);
    ALU alu (
        .op1(alu_op1),
        .op2(alu_op2),
        .operation(alu_operation),
        .result(alu_result)
    );

    initial begin
        acc = 8'b0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            acc <= 8'b0;
        end else begin
            acc <= alu_result;
        end
    end
endmodule
