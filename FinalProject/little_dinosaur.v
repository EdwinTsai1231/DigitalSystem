`define UnitTime 32'd 25000
module Unit_fd(clk_in ,reset, clk_out) ; // Time Frequency Divider
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
                if(count==`UnitTime)
                    begin
                        count <= 0;
                        clk_out <= ~clk_out;
                    end
                else
                    begin
                        count = count+1 ;//Is the notation between count and count+1 '=' or '<='?
                    end
            end
    end
endmodule

module ssd(in,out); // Seven Segments Display
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

module LD_state(spd_ldi , up , down , map_ld , state) ; // output a state
    input spd_ldi ;
    input up , down ;
    output [3:0] map_ld ; 
    output [3:0] state ;

endmodule

module Obstacle(output_obstacle) ; // create a new obstacle
    output [1:0] output_obstacle ;

endmodule

module Hit(hit) ;
    output hit ;
endmodule

module Score(unit_clk,restart,score_out1,score_out2,score_out3,score_out4);//The score is depands on game speed , so we just need to change the game speed
    input unit_clk,restart;
    output reg [3:0] score_out1,score_out2,score_out3,score_out4;
    reg[3:0] score;
    
    always@(posedge unit_clk , negedge restart)
		begin
		if(!restart)//initialize
			begin
			  score<=4'b 0;
			end
		else
		   begin
				if(score == 4'b 1111)
					begin
						score <=0;
						if(score_out1 != 4'h f)
							begin
							    score_out1 <= score_out1 +1;
							end
						else if(score_out2 != 4'h f)
							begin
								score_out2 <= score_out2 +1;
							end
						else if(score_out3 != 4'h f)
							begin
								score_out3 <= score_out3 +1;							
							end
						else
							begin
								score_out4 <= score_out4 +1;							
							end
					end
				else
					begin
						score <= score + 1;
					end
			end
		end
endmodule

<<<<<<< Updated upstream
<<<<<<< Updated upstream
module little_dinosaur(clock , restart , stop , up , down ,ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 , dot_row1 , dot_col1 , dot_row2, dot_col2 , life ) ; // top module
    input clock ; 
    input restart , stop , up , down ; // button
    output [6:0] ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 ; // Seven Segments Display
    output reg [7:0] dot_row1 , dot_col1 , dot_row2 , dot_col2 ; // show the picture in the dot matrix
    reg[2:0] row_count ; // refresh the dot matrix 
    wire [7:0]  col1 ,  col2  ; 
    output reg [2:0] life ; // the life of the dinosaur 
    wire[3:0] state ; // the state of the little dinosaur 
    reg[7:0] map[1:0] ; // the map of the little dinosaur 
    wire[1:0] spawn_obstacle ; 
    reg[1:0] obstacle;
    reg[1:0] gap ; // used to control the obstacle not too close to other obstacles
    reg[15:0] record_obstacle ; // position of obstacle 
	 wire hit ;
    wire [3:0] dinosaur ;
    wire [7:0] temp ;
    wire unit_clk ; // unit_clk represents the time to refresh the dot matrix   
    wire [3:0] score_out1,score_out2,score_out3,score_out4;
    Unit_fd f2 (.clk_in(clock) , .reset(restart) , .clk_out(unit_clk)) ; // frequency divider 

    LD_state m1 (.state(state)) ;
    Obstacle m2 (.output_obstacle(spawn_obstacle)) ;
    Hit m3 (.hit(hit)) ;
    Score m4 (.unit_clk(unit_clk),.restart(restart),.score_out1(score_out1),.score_out2(score_out2),.score_out3(score_out3),.score_out4(score_out4));
    ssd s1(.in(score_out1),.out(ssd_out1));
    ssd s2(.in(score_out2),.out(ssd_out2));
    ssd s3(.in(score_out3),.out(ssd_out3));
    ssd s4(.in(score_out4),.out(ssd_out4));
    assign temp = map[0] ;
    assign col1 = {(temp[7:4] & dinosaur) , temp[3:0]}  ; 
    assign col2 = map[1] ;

    always@(posedge unit_clk , negedge restart) // refresh the dot matrix 
=======
=======
>>>>>>> Stashed changes
module Refresh(unit_clk , col1 , col2 , restart , stop , start , dot_row1 , dot_row2) ;
    input unit_clk , restart , stop , start ;
    input [7:0] col1 , col2 ;
    output reg [7:0] dot_row1 , dot_row2 , dot_col1 , dot_col2 ;
    reg[2:0] row_count ; // stop the dot matrix

    always@(posedge unit_clk , negedge restart,  negedge stop , negedge start)
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
    begin
        if(!restart)
            begin
                //initialization
            end
            else if (!stop)
                begin
                    // stop the game
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

                case(row_count)
                    3'd 0 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    3'd 1 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    3'd 2 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    3'd 3 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    3'd 4 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end 
                    3'd 5 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    3'd 6 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    3'd 7 :
                    begin
                        dot_col1 <= col1 ; 
                        dot_col2 <= col2 ; 
                    end
                    endcase
                end
    end
endmodule 

module little_dinosaur(clock , restart , stop , up , down , ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 , dot_row1 , dot_col1 , dot_row2, dot_col2 , life ) ; // top module
    input clock ; 
    input restart , start , stop , up , down ; // button
    output[6:0] ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 ; // Seven Segments Display
    output[7:0] dot_row1 , dot_col1 , dot_row2 , dot_col2 ; // show the picture in the dot matrix
    wire [7:0]  col1 ,  col2  ; 
    output reg [2:0] life ; // the life of the dinosaur 
    wire[3:0] state ; // the state number of the little dinosaur 
    reg[7:0] map[1:0] ; // the map 
    wire[1:0] spawn_obstacle ; 
    reg[1:0] obstacle;
    reg[1:0] gap ; // used to control the obstacle not too close to other obstacles
    reg[15:0] record_obstacle ; // position of obstacle 
    wire hit ;
    wire [3:0] map_ld ; // the map of the little dinosaur
    wire [7:0] temp ;
    wire spd_map ;
    wire score ;

    wire unit_clk ; // unit_clk represents the time to refresh the dot matrix   
    Unit_fd f2 (.clk_in(clock) , .reset(restart) , .clk_out(unit_clk)) ; // frequency divider 
    // LD_state m1 (.state(state)) ;
    Obstacle m2 (.output_obstacle(spawn_obstacle)) ;
    Hit m3 (.hit(hit)) ;
    Score m4 () ;
    Refresh m5 (unit_clk , col1 , col2 , restart , stop , start , dot_row1 , dot_row2) ;

    assign temp = map[0] ;
    assign col1 = {(temp[7:4] | map_ld) , temp[3:0]}  ; 
    assign col2 = map[1] ;

    always@(posedge unit_clk)
    begin
            gap = gap + 1 ;
            if(gap == 3)
                obstacle = spawn_obstacle ;
            else
                obstacle = obstacle ;

            {map[0],map[1],obstacle} = {map[0],map[1],obstacle} << 1 ;
    end

endmodule