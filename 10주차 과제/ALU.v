module ALU (
    input [7:0] op1,
    input [7:0] op2,
    input [2:0] operation,
    output reg [7:0] result
);
    always @(*) begin
        case (operation)
            3'b000: result = op1 + op2; // ADD
            default: result = 8'b0;     // NOP
        endcase
    end
endmodule
