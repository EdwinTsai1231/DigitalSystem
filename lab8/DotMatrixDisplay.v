`define TimeExpire 32'd 2500

module fd(clk_in ,reset, clk_out) ;
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
                if(count==`TimeExpire)
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

module DotMatrixDisplay (clock , reset , dot_row , dot_col);
    input clock , reset ;
    output reg [7:0] dot_row , dot_col ;
    wire clk_div ;
    reg[2:0] row_count ;

    fd f1( .clk_in(clock) , .reset(reset) , .clk_out(clk_div)) ;
    
    always@(posedge clk_div , negedge reset)
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

        case(row_count) 
            3'd 0 : dot_col <= 8'b 00011000 ; 
            3'd 1 : dot_col <= 8'b 00100100 ; 
            3'd 2 : dot_col <= 8'b 01000010 ; 
            3'd 3 : dot_col <= 8'b 11000011 ; 
            3'd 4 : dot_col <= 8'b 01000010 ; 
            3'd 5 : dot_col <= 8'b 01000010 ; 
            3'd 6 : dot_col <= 8'b 01000010 ; 
            3'd 7 : dot_col <= 8'b 01111110 ; 
        endcase
        end
    end
endmodule 
