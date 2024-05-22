module CPU_tb;
    reg clk;
    reg reset;
    wire [7:0] acc;
    wire [7:0] pc;
    wire [7:0] ir;
    wire [7:0] alu_op1;
    wire [7:0] alu_op2;
    wire [2:0] alu_operation;
    wire [7:0] alu_result;

    // Instantiate the CPU
    CPU cpu (
        .clk(clk),
        .reset(reset),
        .acc(acc),
        .pc_out(pc),
        .ir_out(ir),
        .alu_op1_out(alu_op1),
        .alu_op2_out(alu_op2),
        .alu_operation_out(alu_operation),
        .alu_result_out(alu_result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns period clock
    end

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        #10;
        reset = 0;
        #100;  // Run for 100 time units

        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | PC: %0d | IR: %0d | Acc: %0d | ALU_OP1: %0d | ALU_OP2: %0d | ALU_OP: %0d | ALU_RESULT: %0d", 
                 $time, pc, ir, acc, alu_op1, alu_op2, alu_operation, alu_result);
    end
endmodule
