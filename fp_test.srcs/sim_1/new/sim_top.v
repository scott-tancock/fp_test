`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2017 18:12:45
// Design Name: 
// Module Name: sim_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_top(

    );
    
    reg clk = 0;
    
    always begin
        #5 clk <= ~clk;
    end
    
    wire result[31:0];
    wire a[31:0];
    wire b[31:0];
    
    top t(.sysclk(clk), .led(result[31:24]), .jc(result[23:16]), .jb(result[15:8]), .ja(result[7:0]));
endmodule
