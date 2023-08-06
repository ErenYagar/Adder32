`timescale 1ns / 1ps
module Adder32
(
input clk,
input rst_n, 
input start,
input A0,
input A1,
input A2,
input A3,
input B0,
input B1,
input B2,
input B3,
output [2:0] sel_AnB,
output finish,
output busy,
output Cout,
output SRCLK,
output SER,
output RCLK
);
reg busy_r;
wire [31:0] sum;
wire busy74151;
wire fin74151;
wire busy_tx;

reg start_d1;
reg start_d2;
wire start_TG;
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
    start_d1 <= 1'b0;
    start_d2 <= 1'b0;
    end
    else
    begin
    start_d1 <= start;
    start_d2 <= start_d1;
    end
end
assign start_TG = start_d1 && !start_d2;

always@(posedge clk or negedge rst_n or posedge finish)
begin
    if(!rst_n || finish)
    begin
    busy_r <= 1'b0;
    end
    else
    begin
        if(start_TG)
        begin
        busy_r <= 1'b1;
        end
        else
        begin
        busy_r <= busy_r;
        end
    end
end
assign busy = busy_r;

test74151_32bit_CLA g0
(
.clk(clk),
.rst_n(rst_n),
.start(start),
.A0(A0),
.A1(A1),
.A2(A2),
.A3(A3),
.B0(B0),
.B1(B1),
.B2(B2),
.B3(B3),
.busy_nxt(busy_tx),
.sel_AnB(sel_AnB),
.Sum(sum),
.Cout(Cout),
.busy(busy74151),
.finish(fin74151)
);

tx g1
(
.clk(clk),
.rst_n(rst_n),
.start(fin74151),
.data(sum),
.busy_nxt(busy74151),
.busy(busy_tx),
.SRCLK(SRCLK),
.SER(SER),
.RCLK(RCLK),
.finish(finish)
);

endmodule