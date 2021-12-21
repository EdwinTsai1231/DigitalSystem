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

module Obstacle (unit_clk , gap , spawn_obstacle_7 , spawn_obstacle_6 , spawn_obstacle_5 , spawn_obstacle_4 , spawn_obstacle_3
    ,spawn_obstacle_2 , spawn_obstacle_1 , spawn_obstacle_0 ) ;

    input unit_clk ;
    input [1:0] gap ;
    output reg [1:0] spawn_obstacle_7 ;
    output reg [1:0] spawn_obstacle_6 ;
    output reg [1:0] spawn_obstacle_5 ;
    output reg [1:0] spawn_obstacle_4 ;
    output reg [1:0] spawn_obstacle_3 ;
    output reg [1:0] spawn_obstacle_2 ;
    output reg [1:0] spawn_obstacle_1 ;
    output reg [1:0] spawn_obstacle_0 ;
    reg [2:0] ran ;

    always@(posedge unit_clk)
    begin
        ran <= $random % 8 ;
        case(ran)
        3'd 0 :begin
            spawn_obstacle_0 <= 2'b 00 ;
            spawn_obstacle_1 <= 2'b 00 ;
            spawn_obstacle_2 <= 2'b 00 ;
            spawn_obstacle_3 <= 2'b 00 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 11 ;
            spawn_obstacle_6 <= 2'b 11 ;
            spawn_obstacle_7 <= 2'b 11 ; 
        end
        3'd 1 :begin
            spawn_obstacle_0 <= 2'b 11 ;
            spawn_obstacle_1 <= 2'b 11 ;
            spawn_obstacle_2 <= 2'b 11 ;
            spawn_obstacle_3 <= 2'b 11 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 00 ;
            spawn_obstacle_6 <= 2'b 00 ;
            spawn_obstacle_7 <= 2'b 00 ;  
        end
        3'd 2 :begin
            spawn_obstacle_0 <= 2'b 11 ;
            spawn_obstacle_1 <= 2'b 11 ;
            spawn_obstacle_2 <= 2'b 00 ;
            spawn_obstacle_3 <= 2'b 00 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 00 ;
            spawn_obstacle_6 <= 2'b 11 ;
            spawn_obstacle_7 <= 2'b 11 ; 
        end
        3'd 3 :begin
            spawn_obstacle_0 <= 2'b 00 ;
            spawn_obstacle_1 <= 2'b 00 ;
            spawn_obstacle_2 <= 2'b 00 ;
            spawn_obstacle_3 <= 2'b 00 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 11 ;
            spawn_obstacle_6 <= 2'b 11 ;
            spawn_obstacle_7 <= 2'b 11 ; 
        end
        3'd 4 :begin
            spawn_obstacle_0 <= 2'b 11 ;
            spawn_obstacle_1 <= 2'b 00 ;
            spawn_obstacle_2 <= 2'b 00 ;
            spawn_obstacle_3 <= 2'b 11 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 00 ;
            spawn_obstacle_6 <= 2'b 00 ;
            spawn_obstacle_7 <= 2'b 11 ; 
        end
        3'd 5 :begin
            spawn_obstacle_0 <= 2'b 11 ;
            spawn_obstacle_1 <= 2'b 11 ;
            spawn_obstacle_2 <= 2'b 11 ;
            spawn_obstacle_3 <= 2'b 00 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 00 ;
            spawn_obstacle_6 <= 2'b 00 ;
            spawn_obstacle_7 <= 2'b 11 ; 
        end
        3'd 6 :begin
            spawn_obstacle_0 <= 2'b 11 ;
            spawn_obstacle_1 <= 2'b 11 ;
            spawn_obstacle_2 <= 2'b 00 ;
            spawn_obstacle_3 <= 2'b 00 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 11 ;
            spawn_obstacle_6 <= 2'b 00 ;
            spawn_obstacle_7 <= 2'b 11 ;  
        end
        3'd 7 :begin
            spawn_obstacle_0 <= 2'b 01 ;
            spawn_obstacle_1 <= 2'b 01 ;
            spawn_obstacle_2 <= 2'b 11 ;
            spawn_obstacle_3 <= 2'b 00 ;
            spawn_obstacle_4 <= 2'b 00 ;
            spawn_obstacle_5 <= 2'b 11 ;
            spawn_obstacle_6 <= 2'b 01 ;
            spawn_obstacle_7 <= 2'b 01 ;  
        end
        endcase
    end
endmodule

module Hit ( unit_clk,record_obstacle_7 , record_obstacle_6 ,record_obstacle_5  , record_obstacle_4  , record_obstacle_3  , record_obstacle_2  ,
            record_obstacle_1 , record_obstacle_0 ,map_ld_7, map_ld_6 , map_ld_5 , map_ld_4 , map_ld_3 , map_ld_2 , map_ld_1 , map_ld_0 ,
             hit) ;
    input unit_clk ;
    input[15:0] record_obstacle_7 ;
    input[15:0] record_obstacle_6 ;
    input[15:0] record_obstacle_5 ;
    input[15:0] record_obstacle_4 ;
    input[15:0] record_obstacle_3 ;
    input[15:0] record_obstacle_2 ;
    input[15:0] record_obstacle_1 ;
    input[15:0] record_obstacle_0 ;
    input[3:0] map_ld_7 ; 
    input[3:0] map_ld_6 ; 
    input[3:0] map_ld_5 ; 
    input[3:0] map_ld_4 ; 
    input[3:0] map_ld_3 ; 
    input[3:0] map_ld_2 ; 
    input[3:0] map_ld_1 ; 
    input[3:0] map_ld_0 ; 
    output reg hit ;

    always@(posedge unit_clk)
        begin

        hit <=( (record_obstacle_7[3] & map_ld_7[3])  || (record_obstacle_7[2] & map_ld_7[2]) || (record_obstacle_7[1] & map_ld_7[1]) ||(record_obstacle_7[0] & map_ld_7[0]) ||
            (record_obstacle_6[3] & map_ld_6[3])  || (record_obstacle_6[2] & map_ld_6[2]) || (record_obstacle_6[1] & map_ld_6[1]) ||(record_obstacle_6[0] & map_ld_6[0]) ||
            (record_obstacle_5[3] & map_ld_5[3])  || (record_obstacle_5[2] & map_ld_5[2]) || (record_obstacle_5[1] & map_ld_5[1]) ||(record_obstacle_5[0] & map_ld_5[0]) ||
            (record_obstacle_4[3] & map_ld_4[3])  || (record_obstacle_4[2] & map_ld_4[2]) || (record_obstacle_4[1] & map_ld_4[1]) ||(record_obstacle_4[0] & map_ld_4[0]) ||
            (record_obstacle_3[3] & map_ld_3[3])  || (record_obstacle_3[2] & map_ld_3[2]) || (record_obstacle_3[1] & map_ld_3[1]) ||(record_obstacle_3[0] & map_ld_3[0]) ||
            (record_obstacle_2[3] & map_ld_2[3])  || (record_obstacle_2[2] & map_ld_2[2]) || (record_obstacle_2[1] & map_ld_2[1]) ||(record_obstacle_2[0] & map_ld_2[0]) ||
            (record_obstacle_1[3] & map_ld_1[3])  || (record_obstacle_1[2] & map_ld_1[2]) || (record_obstacle_1[1] & map_ld_1[1]) ||(record_obstacle_1[0] & map_ld_1[0]) ||
            (record_obstacle_0[3] & map_ld_0[3])  || (record_obstacle_0[2] & map_ld_0[2]) || (record_obstacle_0[1] & map_ld_0[1]) ||(record_obstacle_0[0] & map_ld_0[0]) 
            ) ? 1:0 ;

        end

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

/* top module */
module little_dinosaur(clock , restart , stop , up , down , ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 , dot_row1 , dot_col1 , dot_row2, dot_col2 , life ) ;
    
    /*device*/
    input clock ; 
    input restart , start , stop , up , down ; // button
    output[6:0] ssd_out1 , ssd_out2 , ssd_out3 , ssd_out4 ; // Seven Segments Display
    output reg [7:0] dot_row1 , dot_col1 , dot_row2 , dot_col2 ; // show the picture in the dot matrix
    wire [3:0] score_out1,score_out2,score_out3,score_out4; // connect to the ssd 
    wire unit_clk ; // unit_clk represents the time to refresh the dot matrix   
    
    /*map*/
    wire[7:0] col1[7:0] ,  col2[7:0]  ; // Combine the mv_map and map_ld together , and send it to dot_col 
    reg[7:0] mv_map[7:0][1:0] ; // the map only need to record the column  
    wire [3:0] map_ld[7:0] ; // the map of the little dinosaur
    reg [15:0] record_obstacle[7:0] ; // position of obstacle 
    wire spd_map ;
    wire [7:0] temp[7:0] ;
   
    /*obstacle*/ 
    wire[1:0] spawn_obstacle[7:0] ; // generate obstacles
    reg[1:0] obstacle[7:0] ; // spawn_obstacle give the generated one to obstacle
    reg[1:0] gap ; // used to control the obstacle not too close to other obstacles

    /*other*/
    output reg [2:0] life ; // the life of the dinosaur 
    wire[3:0] state ; // the state number of the little dinosaur 
    wire hit ; // check if the little dinosaur was hit or not 
    wire score ;
    reg [2:0] row_count ;

    ssd s1(.in(score_out1),.out(ssd_out1));
    ssd s2(.in(score_out2),.out(ssd_out2));
    ssd s3(.in(score_out3),.out(ssd_out3));
    ssd s4(.in(score_out4),.out(ssd_out4));


    Unit_fd f2 (.clk_in(clock) , .reset(restart) , .clk_out(unit_clk)) ; // frequency divider 
    // LD_state m1 (.state(state)) ;

    // create a new obstacle
    Obstacle m2_0 (unit_clk , gap , spawn_obstacle[7] , spawn_obstacle[6] , spawn_obstacle[5] , spawn_obstacle[4] , spawn_obstacle[3]
    ,spawn_obstacle[2] , spawn_obstacle[1] , spawn_obstacle[0] ) ;

    // check whether it was hit or not 
    Hit m3 (unit_clk, record_obstacle[7] , record_obstacle[6],record_obstacle[5] , record_obstacle[4] , record_obstacle[3] , record_obstacle[2] ,
            record_obstacle[1] , record_obstacle[0] , map_ld[7] , map_ld[6] ,map_ld[5] , map_ld[4] ,map_ld[3] , map_ld[2] ,  map_ld[1],
            map_ld[0] ,hit) ;

    // the score is depends on game speed 
    Score m4 (unit_clk,restart,score_out1,score_out2,score_out3,score_out4);
    
    // Combine the map 
    assign temp[0] = mv_map[0][0] ;
    assign col1[0] = {(temp[0][7:4] | map_ld[0]) , temp[0][3:0]}  ; 
    assign col2[0] = mv_map[0][1] ;

    assign temp[1] = mv_map[1][0] ;
    assign col1[1] = {(temp[1][7:4] | map_ld[1]) , temp[1][3:0]}  ; 
    assign col2[1] = mv_map[1][1] ;

    assign temp[2] = mv_map[2][0] ;
    assign col1[2] = {(temp[2][7:4] | map_ld[2]) , temp[2][3:0]}  ; 
    assign col2[2] = mv_map[2][1] ;

    assign temp[3] = mv_map[3][0] ;
    assign col1[3] = {(temp[3][7:4] | map_ld[3]) , temp[3][3:0]}  ; 
    assign col2[3] = mv_map[3][1] ;

    assign temp[4] = mv_map[4][0] ;
    assign col1[4] = {(temp[4][7:4] | map_ld[4]) , temp[4][3:0]}  ; 
    assign col2[4] = mv_map[4][1] ;

    assign temp[5] = mv_map[5][0] ;
    assign col1[5] = {(temp[5][7:4] | map_ld[5]) , temp[5][3:0]}  ; 
    assign col2[5] = mv_map[5][1] ;

    assign temp[6] = mv_map[6][0] ;
    assign col1[6] = {(temp[6][7:4] | map_ld[6]) , temp[6][3:0]}  ; 
    assign col2[6] = mv_map[6][1] ;

    assign temp[7] = mv_map[7][0] ;
    assign col1[7] = {(temp[7][7:4] | map_ld[7]) , temp[7][3:0]}  ; 
    assign col2[7] = mv_map[7][1] ;

    // refresh the map
    always@(posedge unit_clk , negedge restart )
    begin
        if(!restart)
            begin
                //initialization
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
                        dot_col1 <= col1[0] ;
                        dot_col2 <= col2[0] ;
                    end
                    3'd 1 :
                    begin
                        dot_col1 <= col1[1] ;
                        dot_col2 <= col2[1] ;
                    end
                    3'd 2 :
                    begin
                        dot_col1 <= col1[2] ;
                        dot_col2 <= col2[2] ;
                    end
                    3'd 3 :
                    begin
                        dot_col1 <= col1[3] ;
                        dot_col2 <= col2[3] ;
                    end
                    3'd 4 :
                    begin
                        dot_col1 <= col1[4] ;
                        dot_col2 <= col2[4] ;
                    end
                    3'd 5 :
                    begin
                        dot_col1 <= col1[5] ;
                        dot_col2 <= col2[5] ;
                    end
                    3'd 6 :
                    begin
                        dot_col1 <= col1[6] ;
                        dot_col2 <= col2[6] ;
                    end
                    3'd 7 :
                    begin
                        dot_col1 <= col1[7] ;
                        dot_col2 <= col2[7] ;
                    end
                    endcase
                end
        end
    
    integer i ;
    // control the moving map 
    always@(posedge unit_clk , negedge stop)
    begin
        if(stop)
            begin
                if(gap == 2'd 3)
                    begin
                    gap <= 2'd 0 ;
                    for(i=0 ; i< 8  ; i++)
                        begin
                            obstacle[i] <= spawn_obstacle[i] ;
                            record_obstacle[i][1:0] <= spawn_obstacle[i] ; // the obstacle map 
                        end
                    end
                else
                    begin
                    for(i = 0 ; i < 8 ; i++)
                        begin
                            obstacle[i] <= obstacle[i] ;
                            record_obstacle[i] <= record_obstacle[i] << 1 ; // the obstacle map 
                            gap <= gap+1 ;
                        end
                    end



                for(i = 0 ; i < 8 ; i++)
                    begin
                        {mv_map[i][0],mv_map[i][1],obstacle[i]} <= {mv_map[i][0],mv_map[i][1],obstacle[i]} << 1 ;
                    end
            end

        else // stop the game 
            for(i = 0 ; i < 8 ; i++)
                begin
                    {mv_map[i][0],mv_map[i][1],obstacle[i]} <= {mv_map[i][0],mv_map[i][1],obstacle[i]} ;
                end
    end
endmodule
