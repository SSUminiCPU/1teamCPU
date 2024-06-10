module execute(in_A, in_B, execute_fs, out);
    
    input [15:0] in_A, in_B;
    input [2:0] execute_fs;
    output reg [15:0] out;
    
    always @(*) begin
        case (execute_fs)
            3'd0: out <= 16'b0;
            3'd1: out <= in_A + in_B;
            3'd2: out <= in_A - in_B;
            3'd3: out <= in_B;
            3'd4: out <= in_B + 1;
            default: out <= 16'b_zzzz_zzzz_zzzz_zzz;
        endcase
    end
    
endmodule
