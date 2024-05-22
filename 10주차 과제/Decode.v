module Decode (
    input [7:0] ir,
    output reg [7:0] alu_op1,
    output reg [7:0] alu_op2,
    output reg [2:0] alu_operation,
    input [7:0] acc
);
    always @(*) begin
        case (ir)
            8'h01: begin
                alu_op1 = 8'd3;  // LOAD 3
                alu_op2 = 8'd0;
                alu_operation = 3'b000;  // ADD operation
            end
            8'h02: begin
                alu_op1 = acc;
                alu_op2 = 8'd9;
                alu_operation = 3'b000;  // ADD operation
            end
            default: begin
                alu_op1 = 8'd0;
                alu_op2 = 8'd0;
                alu_operation = 3'b000;  // NOP
            end
        endcase
    end
endmodule
