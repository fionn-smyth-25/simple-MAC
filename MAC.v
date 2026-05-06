`timescale 1ns / 1ps

module MAC
#(parameter N = 8, //data width
  parameter COUNT = 4, //number of MAC operations
  parameter K = 2*N + $clog2(COUNT)) //acc width (larger for overflow)
(
    input clk, rst, en,
    input[N-1:0] a, b,
    output reg valid, //goes high when acc is ready and stable
    output reg[K-1:0] acc //output bit width larger for overflow
);

    reg[$clog2(COUNT)-1:0] count;

    always @ (posedge clk) begin
        if (rst) begin
            acc <= 0;
            valid <= 0;
            count <= 0;
        end
        else if (en) begin
            acc <= acc + (a * b); //MAC
            
            if (count == COUNT-1) begin
                valid <= 1; //valid high when count MAC operations performed 
                count <= 0; //reset count
            end
            else begin
                count <= count + 1; //increment count
                valid <= 0;                
            end
        end
        else begin
            valid <= 0;
        end
    end
   
endmodule
