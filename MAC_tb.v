`timescale 1ns / 1ps

module MAC_tb;
    reg clk, test_en, test_rst;
    reg[7:0] i0, i1;
    wire valid;
    wire[17:0] test_out;
    
    parameter T = 2; //clock period 
    
    MAC uut (.clk(clk), .rst(test_rst), .en(test_en), .a(i0), .b(i1), .valid(valid), .acc(test_out));
    
    always begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial begin
        test_rst = 1'b1;
        test_en = 1'b1;
        i0 = 8'b00000001;
        i1 = 8'b00000100;
        #(5*T);
        test_rst = 1'b0;
        #(T);
        i0 = 8'b00000010;
        i1 = 8'b00000101;
        #(T);
        i0 = 8'b00000011;
        i1 = 8'b00000110;
    end
       
endmodule
