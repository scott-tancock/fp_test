`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 15:57:34
// Design Name: 
// Module Name: fp_mpy
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


module fp_mpy(
        input wire [31:0] a,
        input wire [31:0] b,
        output wire [31:0] c
    );
    
    //Exponents
    wire [7:0] a_exp = a[30:23];
    wire [7:0] b_exp = b[30:23];
    //a and b are biased by +127, c needs to be biased by +127, therefore, take off one of the 127s
    //(ae+127) + (be+127) - 127 = ce + 2*127 - 127 = ce+127
    //Normalisation factor applied to keep numbers normal
    wire [7:0] c_exp = (norm_factor - 45) + a_exp + b_exp - 127;
    
    //Mantissas
    wire [22:0] a_man = a[22:0];
    wire [22:0] b_man = b[22:0];
    wire [22:0] c_man = c_ext[(norm_factor)-:23];
    
    //Convert to unsigned binary
    wire [23:0] a_ext = {1'b1,a_man};
    wire [23:0] b_ext = {1'b1,b_man};
    //Multiply.  Need twice the bits for the result.
    //Bit 46 is 2^0, Bit 47 is 2^1.
    wire [47:0] c_ext = a_ext * b_ext;
    wire [5:0] norm_factor = pri_wire;
    wire [5:0] pri_wire;
    pri_enc_r({c_ext[47],c_ext[45:0]}, pri_wire);
    
    //Signs
    wire a_sig = a[31];
    wire b_sig = b[31];
    wire c_sig = a_sig ^ b_sig;
    
    assign c = {c_sig, c_exp, c_man};
    
endmodule
