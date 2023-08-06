`timescale 1ns / 1ps
module test74151_32bit_CLA
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
input busy_nxt,
output [2:0] sel_AnB,
output [31:0] Sum,
output Cout,
output busy,
output finish
);
reg [2:0] sel_AnB_r;
reg start_r1;
reg start_r2;
reg busy_r;
wire start_TG;
reg fin_d1;
reg fin_r;
wire cnt6;
reg cnt6_d1;
reg [2:0] sel_AnB_d2;

parameter div_num = 6;
reg [2:0] cnt2;
reg div2_wave;
wire cnt2_no3;

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
    start_r1 <= 1'b0;
    start_r2 <= 1'b0;
    end
    else
    begin
    start_r1 <= start;
    start_r2 <= start_r1;
    end
end
assign start_TG = start_r1 & !start_r2;

always@(posedge clk or negedge rst_n or posedge fin_d1)
begin
    if(!rst_n || fin_d1)
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

reg cnt6_r;
assign cnt6 = cnt6_r;
always@(posedge div2_wave or negedge rst_n)
begin
    if(!rst_n )
    begin
    cnt6_r <= 1'b0;
    end
    else
    begin
        if(sel_AnB_d2 == 3'd7)
        begin
        cnt6_r <= 1'b1;
        end
        else
        begin
        cnt6_r <= 1'b0;
        end
    end
end

always@(posedge div2_wave or negedge rst_n)
begin
    if(!rst_n )
    begin
    cnt6_d1 <= 1'b0;
    end
    else
    begin
    cnt6_d1 <= cnt6;
    end
end

always@(posedge div2_wave or negedge rst_n or posedge busy_nxt)
begin
    if(!rst_n || busy_nxt)
    begin
    fin_r <= 1'b0;
    end
    else
    begin
        if(cnt6_d1)
        begin
        fin_r <= 1'b1;
        end
        else
        begin
        fin_r <= fin_r;
        end
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n )
    begin
    fin_d1 <= 1'b0;
    end
    else
    begin
    fin_d1 <= fin_r;
    end
end
assign finish = fin_r && fin_d1;

reg cnt2_no3_r;
assign cnt2_no3 = cnt2_no3_r;

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n)
    begin
    cnt2_no3_r <= 1'b0;
    end
    else
    begin
        if(cnt2 == 3'd3)
        begin
        cnt2_no3_r <= 1'b1;
        end
        else
        begin
        cnt2_no3_r <= 1'b0;
        end
    end
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n)
    begin
    cnt2 <= 3'd0;
    end
    else
    begin
        if(cnt2 < div_num-1)
        begin
        cnt2 <= cnt2 + 3'd1;
        end
        else
        begin
        cnt2 <= 3'd0;
        end
    end
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n)
    begin
    div2_wave <= 1'b0;
    end
    else
    begin
        if(cnt2 < div_num/2)
        begin
        div2_wave <= 1'b1;
        end
        else
        begin
        div2_wave <= 1'b0;
        end
    end
end 

always@(posedge div2_wave or negedge rst_n or posedge start_TG or negedge busy_r)
begin
    if(!rst_n || start_TG || !busy_r)
    begin
    sel_AnB_r <= 3'd0;
    end
    else
    begin
        if(sel_AnB_r < 3'd7)
        begin
        sel_AnB_r <= sel_AnB_r + 3'd1;
        end
        else
        begin
        sel_AnB_r <= sel_AnB_r;
        end
    end
end

always@(posedge clk or negedge rst_n or posedge start_TG or negedge busy_r)
begin
    if(!rst_n || start_TG || !busy_r)
    begin
    sel_AnB_d2 <= 3'd0;
    end
    else
    begin
        if(cnt2_no3)
        begin
        sel_AnB_d2 <= sel_AnB_r;
        end
        else
        begin
        sel_AnB_d2 <= sel_AnB_d2;
        end
    end
end
assign sel_AnB = sel_AnB_d2;


reg [7:0] A0_r;
reg [7:0] A1_r;
reg [7:0] A2_r;
reg [7:0] A3_r;
reg [7:0] B0_r;
reg [7:0] B1_r;
reg [7:0] B2_r;
reg [7:0] B3_r;

wire [31:0] Ao;
wire [31:0] Bo;

assign Ao = {A3_r , A2_r, A1_r , A0_r};
assign Bo = {B3_r , B2_r, B1_r , B0_r};

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    A0_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            A0_r[0] <= A0;
            end            
            3'd1:
            begin
            A0_r[1] <= A0;
            end
            3'd2:
            begin
            A0_r[2] <= A0;
            end
            3'd3:
            begin
            A0_r[3] <= A0;
            end
            3'd4:
            begin
            A0_r[4] <= A0;
            end
            3'd5:
            begin
            A0_r[5] <= A0;
            end            
            3'd6:
            begin
            A0_r[6] <= A0;
            end            
            3'd7:
            begin
            A0_r[7] <= A0;
            end
            default:
            begin
            A0_r <= A0_r;
            end
            endcase
    end   
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    A1_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            A1_r[0] <= A1;
            end            
            3'd1:
            begin
            A1_r[1] <= A1;
            end
            3'd2:
            begin
            A1_r[2] <= A1;
            end
            3'd3:
            begin
            A1_r[3] <= A1;
            end
            3'd4:
            begin
            A1_r[4] <= A1;
            end
            3'd5:
            begin
            A1_r[5] <= A1;
            end            
            3'd6:
            begin
            A1_r[6] <= A1;
            end            
            3'd7:
            begin
            A1_r[7] <= A1;
            end
            default:
            begin
            A1_r <= A1_r;
            end
            endcase
    end   
end
always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    A2_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            A2_r[0] <= A2;
            end            
            3'd1:
            begin
            A2_r[1] <= A2;
            end
            3'd2:
            begin
            A2_r[2] <= A2;
            end
            3'd3:
            begin
            A2_r[3] <= A2;
            end
            3'd4:
            begin
            A2_r[4] <= A2;
            end
            3'd5:
            begin
            A2_r[5] <= A2;
            end            
            3'd6:
            begin
            A2_r[6] <= A2;
            end            
            3'd7:
            begin
            A2_r[7] <= A2;
            end
            default:
            begin
            A2_r <= A2_r;
            end
            endcase
    end   
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    A3_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            A3_r[0] <= A3;
            end            
            3'd1:
            begin
            A3_r[1] <= A3;
            end
            3'd2:
            begin
            A3_r[2] <= A3;
            end
            3'd3:
            begin
            A3_r[3] <= A3;
            end
            3'd4:
            begin
            A3_r[4] <= A3;
            end
            3'd5:
            begin
            A3_r[5] <= A3;
            end            
            3'd6:
            begin
            A3_r[6] <= A3;
            end            
            3'd7:
            begin
            A3_r[7] <= A3;
            end
            default:
            begin
            A3_r <= A3_r;
            end
            endcase
    end   
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    B0_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            B0_r[0] <= B0;
            end            
            3'd1:
            begin
            B0_r[1] <= B0;
            end
            3'd2:
            begin
            B0_r[2] <= B0;
            end
            3'd3:
            begin
            B0_r[3] <= B0;
            end
            3'd4:
            begin
            B0_r[4] <= B0;
            end
            3'd5:
            begin
            B0_r[5] <= B0;
            end            
            3'd6:
            begin
            B0_r[6] <= B0;
            end            
            3'd7:
            begin
            B0_r[7] <= B0;
            end
            default:
            begin
            B0_r <= B0_r;
            end
            endcase
    end   
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    B1_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            B1_r[0] <= B1;
            end            
            3'd1:
            begin
            B1_r[1] <= B1;
            end
            3'd2:
            begin
            B1_r[2] <= B1;
            end
            3'd3:
            begin
            B1_r[3] <= B1;
            end
            3'd4:
            begin
            B1_r[4] <= B1;
            end
            3'd5:
            begin
            B1_r[5] <= B1;
            end            
            3'd6:
            begin
            B1_r[6] <= B1;
            end            
            3'd7:
            begin
            B1_r[7] <= B1;
            end
            default:
            begin
            B1_r <= B1_r;
            end
            endcase
    end   
end

always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    B2_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            B2_r[0] <= B2;
            end            
            3'd1:
            begin
            B2_r[1] <= B2;
            end
            3'd2:
            begin
            B2_r[2] <= B2;
            end
            3'd3:
            begin
            B2_r[3] <= B2;
            end
            3'd4:
            begin
            B2_r[4] <= B2;
            end
            3'd5:
            begin
            B2_r[5] <= B2;
            end            
            3'd6:
            begin
            B2_r[6] <= B2;
            end            
            3'd7:
            begin
            B2_r[7] <= B2;
            end
            default:
            begin
            B2_r <= B2_r;
            end
            endcase
    end   
end
always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    B3_r <= 8'd0;
    end
    else
    begin
            case(sel_AnB_d2)
            3'd0:
            begin
            B3_r[0] <= B3;
            end            
            3'd1:
            begin
            B3_r[1] <= B3;
            end
            3'd2:
            begin
            B3_r[2] <= B3;
            end
            3'd3:
            begin
            B3_r[3] <= B3;
            end
            3'd4:
            begin
            B3_r[4] <= B3;
            end
            3'd5:
            begin
            B3_r[5] <= B3;
            end            
            3'd6:
            begin
            B3_r[6] <= B3;
            end            
            3'd7:
            begin
            B3_r[7] <= B3;
            end
            default:
            begin
            B3_r <= B3_r;
            end
            endcase
    end   
end
CLA g0
(
.A(Ao),
.B(Bo),
.S(Sum),
.Cout(Cout)
);


endmodule