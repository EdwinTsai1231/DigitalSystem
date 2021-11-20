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

`define TimeExpire 32'd 25000000

module FrequencyDivider(in_clk, reset ,out_clk) ;
    input in_clk , reset ;
    output reg out_clk ;
    reg[31:0] count ;

    always@(posedge in_clk)
    begin
        if(!reset)
            begin
               count <= 32'd 0 ;
               out_clk <= 1'b 0 ;
            end
        else
            begin
                if(count == `TimeExpire)
                    begin
                        count<= 32'd 0 ;
                        out_clk <= ~out_clk ;
                    end 
                else
                    count <= count + 1'd 1 ;
            end
    end
endmodule

module counter2(sel,reset,clock , out) ;
    input sel , reset , clock ;
    wire div_clk ;
    reg[3:0] temp;
    output[6:0] out;

    FrequencyDivider f1 (.in_clk(clock),.reset(reset),.out_clk(div_clk)) ;

    always@(posedge div_clk or negedge reset or sel)
    begin
    if(sel)
        begin
            if(!reset)
                temp  = 4'd 0 ;
            else
                begin
                    if(temp==4'd 15)
                        temp = 4'd 0 ;
                    else
                        temp = temp + 1'd 1 ;
                end
        end
    else
        begin
            if(!reset)
                temp  = 4'd 0 ;
            else
                begin
                    if(temp==4'd 0)
                        temp = 4'd 15 ;
                    else
                        temp = temp - 1'd 1 ;
                end
        end
    end
    
    SevenDisplay s1 (.in(temp) , .out(out) ) ;

endmodule 
