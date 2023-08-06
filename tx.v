`timescale 1ns / 1ps
module tx
(
input clk,
input rst_n,
input start,
input [31:0] data,
input busy_nxt,
output busy,
output SRCLK,
output SER,
output RCLK,
output finish
);
reg start_d1;
reg start_d2;
wire start_TG;
reg [6:0] cnt;
reg busy_r;
reg fin_r;
assign busy = busy_r;

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

always@(posedge clk or negedge rst_n or posedge RCLK)
begin
    if(!rst_n || RCLK)
    begin
    busy_r <=1'b0;
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
reg RCLK_d1;
wire RCLK_TG;


always@(posedge clk or negedge rst_n)
begin
    if(!rst_n )
    begin
    RCLK_d1 <=1'b0;
    end
    else
    begin
    RCLK_d1 <=RCLK;
    end
end
assign RCLK_TG = RCLK && !RCLK_d1;

always@(posedge clk or negedge rst_n or posedge busy_nxt)
begin
    if(!rst_n || busy_nxt)
    begin
    fin_r <=1'b0;
    end
    else
    begin
        if(RCLK_TG)
        begin
        fin_r <= 1'b1;
        end
        else
        begin
        fin_r <= fin_r;
        end
    end
end
assign finish = fin_r;

always@(posedge clk or negedge rst_n or negedge busy_r)
begin
    if(!rst_n || !busy_r)
    begin
    cnt <= 7'd0;
    end
    else
    begin
        if(cnt < 7'd64)
        begin
        cnt <= cnt + 7'd1;
        end
        else
        begin
        cnt <= cnt;
        end
    end
end
reg [6:0] cnt_d1;
reg [6:0] cnt2;

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
    cnt_d1 <= 7'd0;
    end
    else
    begin
    cnt_d1 <= cnt;
    end
end

always@(posedge clk or negedge rst_n or negedge busy_r)
begin
    if(!rst_n || !busy_r)
    begin
    cnt2 <= 7'd0;
    end
    else
    begin
        if((cnt %2) == 7'd0)
        begin
        cnt2 <= cnt2 + 7'd1;
        end
        else
        begin
        cnt2 <= cnt2;
        end
    end
end

reg SRCLK_wave;
always@(posedge clk or negedge rst_n or posedge start_TG or negedge busy)
begin
    if(!rst_n || start_TG || !busy)
    begin
    SRCLK_wave <= 1'b0;
    end
    else
    begin
        if((cnt %2) == 7'd0)
        begin
        SRCLK_wave <= 1'b1;
        end
        else
        begin
        SRCLK_wave <= 1'b0;
        end
    end
end
assign SRCLK = SRCLK_wave;
reg SER_r;
assign SER = SER_r;


always@(posedge clk or negedge rst_n or posedge start_TG)
begin
    if(!rst_n || start_TG)
    begin
    SER_r <= 1'b0;
    end
    else
    begin
        case(cnt2)
        7'd1:
        begin
            if(data[31])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end
        end
        7'd2:
        begin
            if(data[30])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end
        end
        7'd3:
        begin
            if(data[29])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end
        end
        7'd4:
        begin
            if(data[28])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end        
        end       
       7'd5:
        begin
            if(data[27])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd6:
        begin
            if(data[26])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd7:
        begin
            if(data[25])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end           
        end        
        7'd8:
        begin
            if(data[24])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd9:
        begin
            if(data[23])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd10:
        begin
            if(data[22])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd11:
        begin
            if(data[21])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd12:
        begin
            if(data[20])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd13:
        begin
            if(data[19])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end                
        7'd14:
        begin
            if(data[18])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end                
        7'd15:
        begin
            if(data[17])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end                
        7'd16:
        begin
            if(data[16])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd17:
        begin
            if(data[15])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end
        end
        7'd18:
        begin
            if(data[14])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end
        end
        7'd19:
        begin
            if(data[13])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end
        end
        7'd20:
        begin
            if(data[12])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end        
        end       
       7'd21:
        begin
            if(data[11])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd22:
        begin
            if(data[10])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd23:
        begin
            if(data[9])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end           
        end        
        7'd24:
        begin
            if(data[8])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd25:
        begin
            if(data[7])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd26:
        begin
            if(data[6])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end
        7'd27:
        begin
            if(data[5])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd28:
        begin
            if(data[4])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end        
        7'd29:
        begin
            if(data[3])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end                
        7'd30:
        begin
            if(data[2])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end                
        7'd31:
        begin
            if(data[1])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end                
        7'd32:
        begin
            if(data[0])
            begin
            SER_r <= 1'b1;
            end
            else
            begin
            SER_r <= 1'b0;
            end    
        end       
        
        default:
        begin
        SER_r <= SER_r;
        end
        endcase
    end
end

reg RCLK_r;
always@(posedge clk or negedge rst_n )
begin
    if(!rst_n )
    begin
    RCLK_r <= 1'b0;
    end
    else
    begin
        if(cnt_d1 == 7'd64)
        begin
        RCLK_r <= 1'b1;
        end
        else
        begin
        RCLK_r <= 1'b0;
        end
    end
end

assign RCLK = RCLK_r;
endmodule