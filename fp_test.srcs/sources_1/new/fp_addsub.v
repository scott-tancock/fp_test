`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 15:58:05
// Design Name: 
// Module Name: fp_addsub
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


module fp_addsub(
        input wire [31:0] a,
        input wire [31:0] b,
        output wire [31:0] c,
        input wire op
    );
    
    assign c = {c_sig, c_exp, c_man};
    
    wire a_sig = a[31];
    wire b_sig = b[31];
    wire c_sig;
    
    wire [22:0] a_man = a[22:0];
    wire [22:0] b_man = b[22:0];
    wire [22:0] c_man;
    
    wire [7:0] a_exp = a[30:23];
    wire [7:0] b_exp = b[30:23];
    wire [7:0] c_exp;
    
    wire [23:0] a_uman = {1'b1,a_exp};
    wire [23:0] b_uman = {1'b1,b_exp};
    
    reg high_sel;
    reg[7:0] shift;
    
    always @ (a_exp or b_exp or a_uman or b_uman) begin
        if(a_exp > b_exp) begin
            high_sel = 0;
            shift = a_exp - b_exp;
        end
        else if (b_exp > a_exp) begin
            high_sel = 1;  
            shift = b_exp - a_exp;
        end
        else if (a_uman > b_uman) begin
            high_sel = 0;
            shift = 0;
        end
        else if (a_uman < b_uman) begin
            high_sel = 1;
            shift = 0;
        end
        else begin
            high_sel = 0;
            shift = 0;
        end
    end 
    
    reg uop;
    reg res_sig;
    always @ (high_sel or a_sig or b_sig or op) begin
        if (op) begin
            //? - ?
            if (high_sel) begin
                //a - B
                res_sig = ~b_sig; //result will be opposite of B sign
                uop = ~(a_sig ^ b_sig);
            end
            else begin
                //A - b
                res_sig = a_sig; //result will be same as A sign
                uop = ~(a_sig ^ b_sig); //find difference
            end
        end
        else begin
            //? + ?
            if(high_sel) begin
                //A + b
                res_sig = a_sig; //result will be same as A sign
                uop = a_sig ^ b_sig; //accumulate
            end
            else begin
                //a + B
                res_sig = b_sig; //result will be same as B sign
                uop = a_sig ^ b_sig; //accumulate
            end
        end
    end
        
endmodule
