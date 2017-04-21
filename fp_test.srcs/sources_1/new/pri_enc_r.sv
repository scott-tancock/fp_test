`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 16:44:31
// Design Name: 
// Module Name: pri_enc_r
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


module pri_enc_r(
        input wire [46:0] onehot,
        output reg [5:0] code,
        output wire trigger
    );
    
    integer i;
    
    always begin: encode
        for(i = 0; i < 47; i = i + 1) begin: encode_step
            if(onehot[i]) begin: detected
                code = i;
            end
        end
    end
    
endmodule
