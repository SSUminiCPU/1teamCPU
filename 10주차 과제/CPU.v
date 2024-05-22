module CPU (
    input clk,
    input reset,
    output [7:0] acc,  // Accumulator
    output [7:0] pc_out,
    output [7:0] ir_out,
    output [7:0] alu_op1_out,
    output [7:0] alu_op2_out,
    output [2:0] alu_operation_out,
    output [7:0] alu_result_out
);
    wire [7:0] pc;
    wire [7:0] ir;
    wire [7:0] alu_op1;
    wire [7:0] alu_op2;
    wire [2:0] alu_operation;
    wire [7:0] alu_result;

    // Fetch Stage
    Fetch fetch (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .ir(ir)
    );

    // Decode Stage
    Decode decode (
        .ir(ir),
        .alu_op1(alu_op1),
        .alu_op2(alu_op2),
        .alu_operation(alu_operation),
        .acc(acc)
    );

    // Execute Stage
    Execute execute (
        .clk(clk),
        .reset(reset),
        .alu_op1(alu_op1),
        .alu_op2(alu_op2),
        .alu_operation(alu_operation),
        .acc(acc),
        .alu_result(alu_result)
    );

    assign pc_out = pc;
    assign ir_out = ir;
    assign alu_op1_out = alu_op1;
    assign alu_op2_out = alu_op2;
    assign alu_operation_out = alu_operation;
    assign alu_result_out = alu_result;
endmodule
