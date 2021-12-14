`define DisplayTime 32'd 2500

module Display_fd(clk_in ,reset, clk_out) ;
    input clk_in,reset ;
    output reg clk_out ;
    reg [31:0] count ;

    always@(posedge clk_in)
    begin
        if(!reset)
            begin
                count<=32'd 0 ;
                clk_out <= 1'b 0;
            end
        else
            begin
                if(count==`DisplayTime)
                    begin
                        count <= 0;
                        clk_out <= ~clk_out;
                    end
                else
                    begin
                        count = count+1 ;
                    end
            end
    end
endmodule

`define SecondTime 32'd 25000000

module Second_fd(clk_in ,reset, clk_out) ;
    input clk_in,reset ;
    output reg clk_out ;
    reg [31:0] count ;

    always@(posedge clk_in)
    begin
        if(!reset)
            begin
                count<=32'd 0 ;
                clk_out <= 1'b 0;
            end
        else
            begin
                if(count==`SecondTime)
                    begin
                        count <= 0;
                        clk_out <= ~clk_out;
                    end
                else
                    begin
                        count = count+1 ;
                    end
            end
    end
endmodule

module ssd(in,out);
    input [3:0] in ;
    output reg  [6:0] out ;

    always@(in)
    begin
        case(in)
        4'h 0 : out = 7'b 1000000;
        4'h 1 : out = 7'b 1111001;
        4'h 2 : out = 7'b 0100100;     
        4'h 3 : out = 7'b 0110000;     
        4'h 4 : out = 7'b 0011001;     
        4'h 5 : out = 7'b 0010010;      
        4'h 6 : out = 7'b 0000010;     
        4'h 7 : out = 7'b 1111000;     
        4'h 8 : out = 7'b 0000000;      
        4'h 9 : out = 7'b 0010000;
        4'h a : out = 7'b 0001000;
        4'h b : out = 7'b 0000011;
        4'h c : out = 7'b 1000110;
        4'h d : out = 7'b 0100001;
        4'h e : out = 7'b 0000110;
        4'h f : out = 7'b 0001110;
        endcase
    end
endmodule

module TrafficLight(clock , reset , dot_row , dot_col , out) ; 
    input clock , reset ;
    wire second_clk , display_clk ;

    output reg [7:0] dot_row , dot_col ;
    reg[2:0] row_count ;

    output [6:0] out ; 
    reg[3:0] ssd_in ;

    parameter[1:0] green = 2'd 0 , yellow = 2'd 1 , red = 2'd 2 ;
    reg[1:0] curr ; 

    Second_fd f1(.clk_in(clock) , .reset(reset) , .clk_out(second_clk)) ;
    Display_fd f2(.clk_in(clock) , .reset(reset) , .clk_out(display_clk)) ;
    ssd s1(.in(ssd_in) , .out(out)) ;

    always@(posedge second_clk , negedge reset)
    begin
    if(~reset) // restart
        begin
        curr <= green ;
        ssd_in <= 4'd 15 ; 
        end
    else
        begin
        case(curr)
            green : begin
                if(ssd_in == 4'd 0)
                    begin
                        curr = yellow ;
                        ssd_in = 4'd 5 ;
                    end
                else
                    begin
                        ssd_in = ssd_in - 4'd 1 ;
                    end
            end 
            yellow : begin
                if(ssd_in == 4'd 0)
                    begin
                        curr = red ;
                        ssd_in = 4'd 10 ;
                    end
                else
                    begin
                        ssd_in = ssd_in - 4'd 1 ;
                    end
            end 
            red : begin
                if(ssd_in == 4'd 0)
                    begin
                        curr = green ;
                        ssd_in = 4'd 15 ;
                    end
                else
                    begin
                        ssd_in = ssd_in - 4'd 1 ;
                    end
            end 
        endcase
        end

    end

    always@(posedge display_clk , negedge reset)
    begin
        if(~reset)
            begin
                dot_row <= 8'b 0 ;
                dot_col <= 8'b 0 ;
                row_count <= 0 ;
            end
        else
            begin
                row_count <= row_count + 1 ;
                case(row_count)
                    3'd 0 : dot_row <= 8'b 01111111 ; 
                    3'd 1 : dot_row <= 8'b 10111111 ; 
                    3'd 2 : dot_row <= 8'b 11011111 ; 
                    3'd 3 : dot_row <= 8'b 11101111 ; 
                    3'd 4 : dot_row <= 8'b 11110111 ; 
                    3'd 5 : dot_row <= 8'b 11111011 ; 
                    3'd 6 : dot_row <= 8'b 11111101 ; 
                    3'd 7 : dot_row <= 8'b 11111110 ; 
                endcase
            end

        
        case(curr)
            green:begin 
                case(row_count) 
                    3'd 0 : dot_col <= 8'b 00001100 ; 
                    3'd 1 : dot_col <= 8'b 00001100 ; 
                    3'd 2 : dot_col <= 8'b 00011001 ; 
                    3'd 3 : dot_col <= 8'b 01111110 ; 
                    3'd 4 : dot_col <= 8'b 10011000 ; 
                    3'd 5 : dot_col <= 8'b 00011000 ; 
                    3'd 6 : dot_col <= 8'b 00101000 ; 
                    3'd 7 : dot_col <= 8'b 01001000 ; 
                endcase
            end

            yellow:begin
                case(row_count) 
                    3'd 0 : dot_col <= 8'b 00000000 ; 
                    3'd 1 : dot_col <= 8'b 00100100 ; 
                    3'd 2 : dot_col <= 8'b 00111100 ; 
                    3'd 3 : dot_col <= 8'b 10111101 ; 
                    3'd 4 : dot_col <= 8'b 11111111 ; 
                    3'd 5 : dot_col <= 8'b 00111100 ; 
                    3'd 6 : dot_col <= 8'b 00111100 ; 
                    3'd 7 : dot_col <= 8'b 00000000 ; 
                endcase
            end
        
            red:begin
                case(row_count) 
                    3'd 0 : dot_col <= 8'b 00011000 ; 
                    3'd 1 : dot_col <= 8'b 00011000 ; 
                    3'd 2 : dot_col <= 8'b 00111100 ; 
                    3'd 3 : dot_col <= 8'b 00111100 ; 
                    3'd 4 : dot_col <= 8'b 01011010 ; 
                    3'd 5 : dot_col <= 8'b 00011000 ; 
                    3'd 6 : dot_col <= 8'b 00011000 ; 
                    3'd 7 : dot_col <= 8'b 00100100 ; 
                endcase
            end
        endcase
    end
endmodule
