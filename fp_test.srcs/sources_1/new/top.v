`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 15:57:34
// Design Name: 
// Module Name: top
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


module top(
        input wire sysclk,
        output wire[7:0] ja,
        output wire[7:0] jb,
        output wire[7:0] jc,
        output wire[7:0] led
    );
    
    //Source regiters
    reg[31:0] a [31:0];
    reg[31:0] b [31:0];
    
    //Position integer
    integer i = 0;
    
    initial begin: set_up
            $readmemh("a_vec.mem", a);
            $readmemh("b_vec.mem", b);
    end
    
    //axi wires/regs
    reg s_axis_a_tvalid = 1;
    wire s_axis_a_tready;
    wire[31:0] s_axis_a_tdata;
    reg s_axis_b_tvalid = 1;
    wire s_axis_b_tready;
    wire[31:0] s_axis_b_tdata;
    reg s_axis_c_tvalid = 1;
    wire s_axis_c_tready;
    reg[31:0] s_axis_c_tdata = 0;
    wire m_axis_result_tvalid;
    reg m_axis_result_tready = 1;
    wire[31:0] m_axis_result_tdata;
    
    assign s_axis_a_tdata = a[i];
    assign s_axis_b_tdata = b[i];
    
    floating_point_MAC fmac (
      .aclk(sysclk),                                  // input wire aclk
      .s_axis_a_tvalid(s_axis_a_tvalid),            // input wire s_axis_a_tvalid
      .s_axis_a_tready(s_axis_a_tready),            // output wire s_axis_a_tready
      .s_axis_a_tdata(s_axis_a_tdata),              // input wire [31 : 0] s_axis_a_tdata
      .s_axis_b_tvalid(s_axis_b_tvalid),            // input wire s_axis_b_tvalid
      .s_axis_b_tready(s_axis_b_tready),            // output wire s_axis_b_tready
      .s_axis_b_tdata(s_axis_b_tdata),              // input wire [31 : 0] s_axis_b_tdata
      .s_axis_c_tvalid(s_axis_c_tvalid),            // input wire s_axis_c_tvalid
      .s_axis_c_tready(s_axis_c_tready),            // output wire s_axis_c_tready
      .s_axis_c_tdata(s_axis_c_tdata),              // input wire [31 : 0] s_axis_c_tdata
      .m_axis_result_tvalid(m_axis_result_tvalid),  // output wire m_axis_result_tvalid
      .m_axis_result_tready(m_axis_result_tready),  // input wire m_axis_result_tready
      .m_axis_result_tdata(m_axis_result_tdata)    // output wire [31 : 0] m_axis_result_tdata
    );
    
    always @ (posedge sysclk) begin: test
        //deassert tvalid if data received (marked by tready)
        if(s_axis_a_tready == 1) begin
            s_axis_a_tvalid <= 0;
        end
        //deassert tvalid if data received (marked by tready)
        if(s_axis_b_tready == 1) begin
            s_axis_b_tvalid <= 0;
        end
        //deassert tvalid if data received (marked by tready)
        if(s_axis_c_tready == 1) begin
            s_axis_c_tvalid <= 0;
        end
        //next cycle
        if(m_axis_result_tvalid == 1) begin
            i <= i+1;
            s_axis_a_tvalid <= 1;
            s_axis_b_tvalid <= 1;
            s_axis_c_tdata <= m_axis_result_tdata;
            s_axis_c_tvalid <= 1;
        end
    end
    
    assign led = m_axis_result_tdata[31:24];
    assign jc = m_axis_result_tdata[23:16];
    assign jb = m_axis_result_tdata[15:8];
    assign ja = m_axis_result_tdata[7:0];
    
endmodule
