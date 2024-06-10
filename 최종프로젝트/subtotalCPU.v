module subtotalCPU(in_data, rst_n, clk,
          out_data, out_address, memrq, rnw);
    
    input [15:0]in_data;
    input rst_n, clk;
    output [15:0] out_data;
    output [11:0] out_address;
    output memrq, rnw;
    wire acc_ce, acc_oe, acc_15, accz;
    wire a_sel, b_sel, decode_ce, fetch_ce;
    wire [2:0] execute_fs;
    wire [3:0] opcode;
    wire [11:0] addr_from_decode, addr_from_fetch;
    wire [15:0] data_execute, data_mux, data_acc_to_execute;
    
    ACC u_acc(.in_data(data_execute), .acc_ce(acc_ce), .acc_oe(acc_oe), .clk(clk),
           .out_to_bus(out_data), .out_data(data_acc_to_execute), .acc_15(acc_15), .accz(accz));
    execute u_execute(.in_A(data_acc_to_execute), .in_B(data_mux), .execute_fs(execute_fs),
           .out(data_execute));
    control_logic u_control_logic(.in_opcode(opcode), .acc_15(acc_15), .accz(accz), .clk(clk), .rst_n(rst_n),
           .a_sel(a_sel), .b_sel(b_sel), .decode_ce(decode_ce), .fetch_ce(fetch_ce), .acc_ce(acc_ce), .acc_oe(acc_oe), .execute_fs(execute_fs),
           .rnw(rnw), .memrq(memrq));
    fetch u_fetch(.in_instruction(in_data), .fetch_ce(fetch_ce), .clk(clk),
          .out_opcode(opcode), .out_address(addr_from_fetch));
    mux_2to1 #(.WORD(12)) u_mux_a(.i0(addr_from_decode), .i1(addr_from_fetch), .sel(a_sel),
                .out(out_address));
    mux_2to1 u_mux_b(.i0({4'b0000, out_address}), .i1(in_data), .sel(b_sel),
                .out(data_mux));
    decode u_decode(.in_address(data_execute), .decode_ce(decode_ce), .clk(clk),
          .out_address(addr_from_decode));

endmodule
