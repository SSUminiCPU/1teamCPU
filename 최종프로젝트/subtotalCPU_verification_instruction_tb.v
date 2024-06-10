`timescale 1 ns/100ps
module subtotalCPU_verification_instruction_tb();
    
    reg rst_n, clk;
    wire [15:0] data_subtotalCPU, data_memory;
    wire [11:0] addr_subtotalCPU;
    wire memrq, rnw;    

    subtotalCPU u_subtotalCPU(.in_data(data_memory), .rst_n(rst_n), .clk(clk),
          .out_data(data_subtotalCPU), .out_address(addr_subtotalCPU), .memrq(memrq), .rnw(rnw));
    memory_32x16 u_memory(.in_data(data_subtotalCPU), .addr(addr_subtotalCPU), .clk(clk), .memrq(memrq), .rw(rnw),
            .out_data(data_memory));

    initial begin
        clk <= 0; rst_n <= 0; force u_memory.rw = 0; force u_memory.memrq = 1; // 초기 설정
        // 프로그램 메모리 설정
        #10 force u_memory.addr =  0; force u_memory.in_data = 16'b_0000_0000_0001_0101; // LDA N1 (M[21])  
        #10 force u_memory.addr =  1; force u_memory.in_data = 16'b_0010_0000_0001_0110; // ADD N2 (M[22])
        #10 force u_memory.addr =  2; force u_memory.in_data = 16'b_0010_0000_0001_0111; // ADD N3 (M[23])
        #10 force u_memory.addr =  3; force u_memory.in_data = 16'b_0010_0000_0001_1000; // ADD N4 (M[24])
        #10 force u_memory.addr =  4; force u_memory.in_data = 16'b_0010_0000_0001_1001; // ADD N5 (M[25])
        #10 force u_memory.addr =  5; force u_memory.in_data = 16'b_0010_0000_0001_1010; // ADD N6 (M[26])
        #10 force u_memory.addr =  6; force u_memory.in_data = 16'b_0111_0000_0000_0000; // STOP
        // 데이터 메모리 설정
        #10 force u_memory.addr = 21; force u_memory.in_data = 16'b_0000_0000_0000_1010; // N1 = 10
        #10 force u_memory.addr = 22; force u_memory.in_data = 16'b_0000_0000_0000_1011; // N2 = 11
        #10 force u_memory.addr = 23; force u_memory.in_data = 16'b_0000_0000_0000_1100; // N3 = 12
        #10 force u_memory.addr = 24; force u_memory.in_data = 16'b_0000_0000_0000_1101; // N4 = 13
        #10 force u_memory.addr = 25; force u_memory.in_data = 16'b_0000_0000_0000_1110; // N5 = 14
        #10 force u_memory.addr = 26; force u_memory.in_data = 16'b_0000_0000_0000_1111; // N6 = 15
        #10 release u_memory.memrq; release u_memory.addr; release u_memory.in_data; release u_memory.rw; 
        #25 rst_n <= 1;

    end

    always
        #5 clk <= ~clk;
    
endmodule
