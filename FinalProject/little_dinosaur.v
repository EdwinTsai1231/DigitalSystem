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

module LD_state() ; // output a state 
endmodule

module little_dinosaur(clock , restart , stop , ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 , dot_row1 , dot_col1 , dot_row2, dot_col2 , life ) ; // top module
    input clock , restart , stop ;
    output [6:0] ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 ;
    output reg [7:0] dot_row1 , dot_col1 , dot_row2 , dot_col2  ;
    output reg [2:0] life ;
    reg[2:0] row_count;
    wire[3:0] state ; // the state of the little dinosaur 
    reg[7:0] map[1:0] ; // the map of the little dinosaur 

    wire display_clk , second_clk ;

    Display_fd f1 (.clk_in(clock) , .reset(restart) , .clk_out(display_clk)) ;
    Second_fd f2 (.clk_in(clock) , .reset(restart) , .clk_out(second_clk)) ;

    always@(posedge display_clk , negedge restart )
    begin
        if(!restart)
            begin
                // restart 
            end
        else
            begin
                row_count <= row_count+1 ;
                case(row_count)
                    3'd 0 :
                    begin
                        dot_row1 <= 8'b 01111111 ; 
                        dot_row2 <= 8'b 01111111 ; 
                    end
                    3'd 1 :
                    begin
                        dot_row1 <= 8'b 10111111 ; 
                        dot_row2 <= 8'b 10111111 ; 
                    end
                    3'd 2 :
                    begin
                        dot_row1 <= 8'b 11011111 ; 
                        dot_row2 <= 8'b 11011111 ; 
                    end
                    3'd 3 :
                    begin
                        dot_row1 <= 8'b 11101111 ; 
                        dot_row2 <= 8'b 11101111 ; 
                    end
                    3'd 4 :
                    begin
                        dot_row1 <= 8'b 11110111 ; 
                        dot_row2 <= 8'b 11110111 ; 
                    end
                    3'd 5 :
                    begin
                        dot_row1 <= 8'b 11111011 ; 
                        dot_row2 <= 8'b 11111011 ; 
                    end
                    3'd 6 :
                    begin
                        dot_row1 <= 8'b 11111101 ; 
                        dot_row2 <= 8'b 11111101 ; 
                    end
                    3'd 7 :
                    begin
                        dot_row1 <= 8'b 11111110 ; 
                        dot_row2 <= 8'b 11111110 ; 
                    end
                endcase

                //case(state)
                    //4'd 0 :
                    //begin
                      //  dot_col1 <= {/*state 4 bits*/,/*4 bits obstacle*/ }
                      //  dot_col2 <= {/*8 bits obstacle*/} ;
                    //end 
                   /* 4'd 1 :
                    4'd 2 :
                    4'd 3 :
                    4'd 4 :
                    4'd 5 :
                    4'd 6 :
                    4'd 7 :
                    4'd 8 :
                    4'd 9 :
                    4'd 10:
                endcase*/

            end
    end




endmodule
