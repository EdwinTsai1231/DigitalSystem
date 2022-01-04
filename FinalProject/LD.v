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

`define Time 32'd 25000000
module fd(clk_in ,reset, clk_out) ; // Time Frequency Divider
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
                if(count==`Time)
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
module LD_state( up , down , map_ld_0 , map_ld_1 , map_ld_2  , map_ld_3  , map_ld_4  , map_ld_5  , map_ld_6  , map_ld_7  ) ; // output a state
    input up , down ;
    output reg [3:0] map_ld_0  ,  map_ld_1  ,  map_ld_2  ,  map_ld_3  ,  map_ld_4  ,  map_ld_5  , map_ld_6  ,  map_ld_7   ;
	 reg jump_or_not = 0 , down_or_not = 0 ;					//是不是在跳 , 是不是在蹲
	 reg eight_one_clk ;					//跳處理:1/8秒改變
	 reg [3:0] count = 4'd0 ;			//count : 跳狀態為何

	 always@(posedge down or posedge up or posedge eight_one_clk)					//蹲
	 //-----------------------------------------------------給予判斷值
	 begin
	 if(up || down)
	 begin
	 if(jump_or_not == 0)					//沒有在跳
		begin
			if(up)								//按下up => 跳吧!
				begin
					jump_or_not <= 1 ;
					count <= count + 1 ;
					if(down)						//要跳 && 要蹲
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0000 ;
							map_ld_4 <= 4'b0000 ;
							map_ld_5 <= 4'b1111 ;
							map_ld_6 <= 4'b0101 ;
							map_ld_7 <= 4'b0000 ;
						end
					else							//要跳 && 不蹲
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0111 ;
							map_ld_4 <= 4'b0100 ;
							map_ld_5 <= 4'b0110 ;
							map_ld_6 <= 4'b1100 ;
							map_ld_7 <= 4'b0000 ;
						end
				end
			else 									//沒按up => 不跳!
				begin
					if(down)							//沒跳 && 蹲
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0000 ;
							map_ld_4 <= 4'b0000 ;
							map_ld_5 <= 4'b0000 ;
							map_ld_6 <= 4'b1111 ;
							map_ld_7 <= 4'b0101 ;
						end
					else
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0000 ;
							map_ld_4 <= 4'b0111 ;
							map_ld_5 <= 4'b0100 ;
							map_ld_6 <= 4'b0110 ;
							map_ld_7 <= 4'b1100 ;
						end
				end
		end
	 else 									//正在跳
		begin
			count <= count + 1 ;				//下一個狀態
			if(count == 4'd9)
				begin
					count <= 0 ;
					jump_or_not = 0 ;
				end
			if(down)							//跳 && 蹲
				begin
					case (count)
					4'd1 , 4'd8 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0000 ;
							map_ld_4 <= 4'b0000 ;
							map_ld_5 <= 4'b1111 ;
							map_ld_6 <= 4'b0101 ;
							map_ld_7 <= 4'b0000 ;
						end
					4'd2 , 4'd7 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0000 ;
							map_ld_4 <= 4'b1111 ;
							map_ld_5 <= 4'b0101 ;
							map_ld_6 <= 4'b0000 ;
							map_ld_7 <= 4'b0000 ;
						end
					4'd3 , 4'd6 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b1111 ;
							map_ld_4 <= 4'b0101 ;
							map_ld_5 <= 4'b0000 ;
							map_ld_6 <= 4'b0000 ;
							map_ld_7 <= 4'b0000 ;
						end
					4'd4 , 4'd5 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b1111 ;
							map_ld_3 <= 4'b0101 ;
							map_ld_4 <= 4'b0000 ;
							map_ld_5 <= 4'b0000 ;
							map_ld_6 <= 4'b0000 ;
							map_ld_7 <= 4'b0000 ;
						end
				endcase
			end
			else								//跳 && 不蹲
				begin
				case (count)
					4'd1 , 4'd8 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0000 ;
							map_ld_3 <= 4'b0111 ;
							map_ld_4 <= 4'b0100 ;
							map_ld_5 <= 4'b0110 ;
							map_ld_6 <= 4'b1100 ;
							map_ld_7 <= 4'b0000 ;
						end
					4'd2 , 4'd7 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0000 ;
							map_ld_2 <= 4'b0111 ;
							map_ld_3 <= 4'b0100 ;
							map_ld_4 <= 4'b0110 ;
							map_ld_5 <= 4'b1100 ;
							map_ld_6 <= 4'b0000 ;
							map_ld_7 <= 4'b0000 ;
						end
					4'd3 , 4'd6 :
						begin
							map_ld_0 <= 4'b0000 ;
							map_ld_1 <= 4'b0111 ;
							map_ld_2 <= 4'b0100 ;
							map_ld_3 <= 4'b0110 ;
							map_ld_4 <= 4'b1100 ;
							map_ld_5 <= 4'b0000 ;
							map_ld_6 <= 4'b0000 ;
							map_ld_7 <= 4'b0000 ;
						end
					4'd4 , 4'd5 :
						begin
							map_ld_0 <= 4'b0111 ;
							map_ld_1 <= 4'b0100 ;
							map_ld_2 <= 4'b0110 ;
							map_ld_3 <= 4'b1100 ;
							map_ld_4 <= 4'b0000 ;
							map_ld_5 <= 4'b0000 ;
							map_ld_6 <= 4'b0000 ;
							map_ld_7 <= 4'b0000 ;
						end
					endcase
				end
		end
	end
end
endmodule


module Obstacle (unit_clk  , reset , gap , spawn_obstacle_7 , spawn_obstacle_6 , spawn_obstacle_5 , spawn_obstacle_4 , spawn_obstacle_3
    ,spawn_obstacle_2 , spawn_obstacle_1 , spawn_obstacle_0 ) ;

    input unit_clk ;
    input reset ;
    input [1:0] gap ;
    output reg [1:0] spawn_obstacle_7 ;
    output reg [1:0] spawn_obstacle_6 ;
    output reg [1:0] spawn_obstacle_5 ;
    output reg [1:0] spawn_obstacle_4 ;
    output reg [1:0] spawn_obstacle_3 ;
    output reg [1:0] spawn_obstacle_2 ;
    output reg [1:0] spawn_obstacle_1 ;
    output reg [1:0] spawn_obstacle_0 ;
    reg[2:0] ran ;

    always@(posedge unit_clk , negedge reset)
    begin
        if(!reset)
            begin
                spawn_obstacle_0 <= 2'b 00 ;
                spawn_obstacle_1 <= 2'b 00 ;
                spawn_obstacle_2 <= 2'b 00 ;
                spawn_obstacle_3 <= 2'b 00 ;
                spawn_obstacle_4 <= 2'b 00 ;
                spawn_obstacle_5 <= 2'b 00 ;
                spawn_obstacle_6 <= 2'b 00 ;
                spawn_obstacle_7 <= 2'b 00 ;  
            end
        else
            begin
                spawn_obstacle_0 <= 2'b 01 ;
                spawn_obstacle_1 <= 2'b 01 ;
                spawn_obstacle_2 <= 2'b 11 ;
                spawn_obstacle_3 <= 2'b 00 ;
                spawn_obstacle_4 <= 2'b 00 ;
                spawn_obstacle_5 <= 2'b 11 ;
                spawn_obstacle_6 <= 2'b 01 ;
                spawn_obstacle_7 <= 2'b 01 ;  
            end
    end
endmodule

module obstacle(clock , reset , dot_row , dot_col1 , dot_col2 ) ;
    
    /*device*/
    input clock , reset ;
    output reg [7:0] dot_row , dot_col1 , dot_col2 ; // show the picture in the dot matrix
    wire unit_clk ; // unit_clk represents the time to refresh the dot matrix   
    wire clk , up  , down ;

    /*map*/
    wire[7:0] col1[7:0] ,  col2[7:0]  ; // Combine the mv_map and map_ld together , and send it to dot_col 
    reg[7:0] mv_map[7:0][1:0] ; // the map only need to record the column  
    wire [3:0] map_ld[7:0] ; // the map of the little dinosaur
    reg [15:0] record_obstacle[7:0] ; // position of obstacle 
    wire [7:0] temp[7:0] ;
   
    /*obstacle*/ 
    wire[1:0] spawn_obstacle[7:0] ; // generate obstacles
    reg[1:0] obstacle[7:0] ; // spawn_obstacle give the generated one to obstacle
    reg[1:0] gap ; // used to control the obstacle not too close to other obstacles

    /*other*/
    wire hit ; // check if the little dinosaur was hit or not 
    wire score ;
    reg [2:0] row_count ;

    Unit_fd f2 (.clk_in(clock) , .reset(reset) , .clk_out(unit_clk)) ; // frequency divider 

    fd f3 (.clk_in(clock) , .reset(reset) , .clk_out(clk)) ; // frequency divider 

    LD_state m1 ( up , down , map_ld[0], map_ld[1], map_ld[2],  map_ld[3],  map_ld[4],  map_ld[5],  map_ld[6],  map_ld[7] ) ;

    // create a new obstacle
    Obstacle m2 (unit_clk , reset , gap , spawn_obstacle[7] , spawn_obstacle[6] , spawn_obstacle[5] , spawn_obstacle[4] , spawn_obstacle[3]
    ,spawn_obstacle[2] , spawn_obstacle[1] , spawn_obstacle[0] ) ;

    /* Merge the map */
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
    /* Merge the map */

    /* Refresh the map */
    always@(posedge unit_clk , negedge reset )
    begin
        if(!reset)
            begin

            end
        else
                begin
                    row_count <= row_count+1 ;
                    case(row_count)
                    3'd 0 :
                        dot_row <= 8'b 01111111 ;
                    3'd 1 :
                        dot_row <= 8'b 10111111 ;
                    3'd 2 :
                        dot_row <= 8'b 11011111 ;
                    3'd 3 :
                        dot_row <= 8'b 11101111 ;
                    3'd 4 :
                        dot_row <= 8'b 11110111 ;
                    3'd 5 :
                        dot_row <= 8'b 11111011 ;
                    3'd 6 :
                        dot_row <= 8'b 11111101 ;
                    3'd 7 :
                        dot_row <= 8'b 11111110 ;
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
    /* Refresh the map */
   
   /* Moving the map */ 
    always@(posedge clk )
    begin
        if(gap == 2'd 3) // prodice the obstacle
            begin
                gap <= 2'd 0 ;
 
                obstacle[0] <= spawn_obstacle[0] ;
                record_obstacle[0][1:0] <= spawn_obstacle[0] ; // the obstacle map 

                obstacle[1] <= spawn_obstacle[1] ;
                record_obstacle[1][1:0] <= spawn_obstacle[1] ; // the obstacle map 

                obstacle[2] <= spawn_obstacle[2] ;
                record_obstacle[2][1:0] <= spawn_obstacle[2] ; // the obstacle map 

                obstacle[3] <= spawn_obstacle[3] ;
                record_obstacle[3][1:0] <= spawn_obstacle[3] ; // the obstacle map 

                obstacle[4] <= spawn_obstacle[4] ;
                record_obstacle[4][1:0] <= spawn_obstacle[4] ; // the obstacle map 

                obstacle[5] <= spawn_obstacle[5] ;
                record_obstacle[5][1:0] <= spawn_obstacle[5] ; // the obstacle map 

                obstacle[6] <= spawn_obstacle[6] ;
                record_obstacle[6][1:0] <= spawn_obstacle[6] ; // the obstacle map 
                
                obstacle[7] <= spawn_obstacle[7] ;
                record_obstacle[7][1:0] <= spawn_obstacle[7] ; // the obstacle map 

            end
        else
            begin
                record_obstacle[0] <= record_obstacle[0] << 1 ; // the obstacle map 
                record_obstacle[1] <= record_obstacle[1] << 1 ; // the obstacle map 
                record_obstacle[2] <= record_obstacle[2] << 1 ; // the obstacle map 
                record_obstacle[3] <= record_obstacle[3] << 1 ; // the obstacle map 
                record_obstacle[4] <= record_obstacle[4] << 1 ; // the obstacle map 
                record_obstacle[5] <= record_obstacle[5] << 1 ; // the obstacle map 
                record_obstacle[6] <= record_obstacle[6] << 1 ; // the obstacle map 
                record_obstacle[7] <= record_obstacle[7] << 1 ; // the obstacle map 

                gap <= gap+1 ;

                {mv_map[0][0],mv_map[0][1],obstacle[0]} <= {mv_map[0][0],mv_map[0][1],obstacle[0]} << 1 ;
                {mv_map[1][0],mv_map[1][1],obstacle[1]} <= {mv_map[1][0],mv_map[1][1],obstacle[1]} << 1 ;
                {mv_map[2][0],mv_map[2][1],obstacle[2]} <= {mv_map[2][0],mv_map[2][1],obstacle[2]} << 1 ;
                {mv_map[3][0],mv_map[3][1],obstacle[3]} <= {mv_map[3][0],mv_map[3][1],obstacle[3]} << 1 ;
                {mv_map[4][0],mv_map[4][1],obstacle[4]} <= {mv_map[4][0],mv_map[4][1],obstacle[4]} << 1 ;
                {mv_map[5][0],mv_map[5][1],obstacle[5]} <= {mv_map[5][0],mv_map[5][1],obstacle[5]} << 1 ;
                {mv_map[6][0],mv_map[6][1],obstacle[6]} <= {mv_map[6][0],mv_map[6][1],obstacle[6]} << 1 ;
                {mv_map[7][0],mv_map[7][1],obstacle[7]} <= {mv_map[7][0],mv_map[7][1],obstacle[7]} << 1 ;
            end

    end
    /* Moving the map */

endmodule

