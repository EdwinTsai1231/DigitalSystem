`define TimeExpire 32'd 25000000 

module FrequencyDivider(clk,reset,div_clk) ;
    input clk , reset ;
    output reg  div_clk ;
    reg[31:0] count ;

    always@(posedge clk)
    begin
        if(!reset) //reset = 0
            begin
            count <= 32'd 0 ; //initialize
            div_clk <= 1'b 0 ;
            end
        else //reset = 1
            begin
            if(count == `TimeExpire)//divide
                begin 
                count <= 32'd 0 ;
                // ~ represents two bits operator not 0->1 ; 1->0 
                div_clk <= ~div_clk ; 
                end
            else
                begin
                count <= count+32'd 1 ;
                end
            end
    end
endmodule


module SevenDisplay(in,out);
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

module counter(clock,reset,out) ; //top module
    input clock , reset ;
    output[6:0] out ;
    reg[3:0] temp ;
    wire div_clk;
    FrequencyDivider f1 (.clk(clock),.reset(reset),.div_clk(div_clk)) ;

    always@(posedge div_clk or negedge reset)
    begin
        if(!reset)
            temp = 0 ;
        else 
            begin

            if(temp==4'd 15)
                temp = 4'b 0 ;
            else
                temp = temp + 1'b 1 ;

            end
    end 
    SevenDisplay u1 (.in(temp),.out(out)) ;

endmodule
