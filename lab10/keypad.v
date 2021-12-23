`define DisplayTime 32'd 2500
`define TimeExpire 32'd 25000

module fd1(clk_in ,reset, clk_out) ;
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

module top(clock , reset  , keypadCol , keypadRow, dot_row , dot_col) ;
	input clock , reset ; 
	input [3:0] keypadCol ;	
	output reg [3:0] keypadRow ;
	output reg [7:0] dot_row ; 
	output reg [7:0] dot_col ;
	
	reg [3:0] keypadBuf ; 
	reg [31:0] keypadDelay ; 
	wire clk_out ;
	wire clk_div ;
	reg [2:0] row_count ;
	
	fd1 m1 (clock , reset , clk_div ) ;

	always@(posedge clock)
	begin
		if(!reset)
		begin
			keypadRow <= 4'b 1110 ;
			keypadBuf <= 4'b 0000 ;
			keypadDelay <= 31'd 0 ;
		end
		else
		begin
			if(keypadDelay == `TimeExpire)
			begin
				keypadDelay <= 31'd 0 ;
				case({keypadRow, keypadCol})
					8'b1110_1110 : keypadBuf <= 4'h7;
					8'b1110_1101 : keypadBuf <= 4'h4;
					8'b1110_1011 : keypadBuf <= 4'h1;
					8'b1110_0111 : keypadBuf <= 4'h0;
					8'b1101_1110 : keypadBuf <= 4'h8;
					8'b1101_1101 : keypadBuf <= 4'h5;
					8'b1101_1011 : keypadBuf <= 4'h2;
					8'b1101_0111 : keypadBuf <= 4'ha;
					8'b1011_1110 : keypadBuf <= 4'h9;
					8'b1011_1101 : keypadBuf <= 4'h6;
					8'b1011_1011 : keypadBuf <= 4'h3;
					8'b1011_0111 : keypadBuf <= 4'hb;
					8'b0111_1110 : keypadBuf <= 4'hc;
					8'b0111_1101 : keypadBuf <= 4'hd;
					8'b0111_1011 : keypadBuf <= 4'he;
					8'b0111_0111 : keypadBuf <= 4'hf;
					default : keypadBuf <= keypadBuf;
				endcase
		
				case(keypadRow)	
					4'b1110 : keypadRow <= 4'b1101;
					4'b1101 : keypadRow <= 4'b1011;
					4'b1011 : keypadRow <= 4'b0111;
					4'b0111 : keypadRow <= 4'b1110;
					default : keypadRow <= 4'b1110;
				endcase				
			end
		else
			keypadDelay <= keypadDelay + 1'b 1 ;
		end
	end

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
		  
		    case(keypadBuf)
		    4'h 0:
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 11000000 ; 
                3'd 7 : dot_col <= 8'b 11000000 ;
				endcase
		    end
		  
		    4'h 1 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00110000 ; 
                3'd 7 : dot_col <= 8'b 00110000 ;
				endcase
		    end
		  
		    4'h2:
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00110000 ; 
                3'd 5 : dot_col <= 8'b 00110000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h 3 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00110000 ; 
                3'd 3 : dot_col <= 8'b 00110000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h 4 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00001100 ; 
                3'd 7 : dot_col <= 8'b 00001100 ;
				endcase
		    end
		  
		    4'h 5 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00001100 ; 
                3'd 5 : dot_col <= 8'b 00001100 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h 6 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00001100 ; 
                3'd 3 : dot_col <= 8'b 00001100 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h 7 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000011 ; 
                3'd 7 : dot_col <= 8'b 00000011 ;
				endcase
		    end
		  
		    4'h 8 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000011 ; 
                3'd 5 : dot_col <= 8'b 00000011 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h 9 :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000011 ; 
                3'd 3 : dot_col <= 8'b 00000011 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h a :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 11000000 ; 
                3'd 5 : dot_col <= 8'b 11000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h b :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000000 ; 
                3'd 1 : dot_col <= 8'b 00000000 ; 
                3'd 2 : dot_col <= 8'b 11000000 ; 
                3'd 3 : dot_col <= 8'b 11000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h c :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00000011 ; 
                3'd 1 : dot_col <= 8'b 00000011 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h d :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00001100 ; 
                3'd 1 : dot_col <= 8'b 00001100 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h e :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 00110000 ; 
                3'd 1 : dot_col <= 8'b 00110000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  
		    4'h f :
		    begin
				case(row_count) 
                3'd 0 : dot_col <= 8'b 11000000 ; 
                3'd 1 : dot_col <= 8'b 11000000 ; 
                3'd 2 : dot_col <= 8'b 00000000 ; 
                3'd 3 : dot_col <= 8'b 00000000 ; 
                3'd 4 : dot_col <= 8'b 00000000 ; 
                3'd 5 : dot_col <= 8'b 00000000 ; 
                3'd 6 : dot_col <= 8'b 00000000 ; 
                3'd 7 : dot_col <= 8'b 00000000 ;
				endcase
		    end
		  endcase
        end
    end 
endmodule

