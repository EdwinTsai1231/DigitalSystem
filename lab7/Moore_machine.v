`define TimeExpire 32'd 25000000

module clk_div(clk_in ,reset, clk_out) ;
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

module ssd(in,out);
    input [2:0] in ;
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
        endcase
    end
endmodule

module MooreMachine (clock , reset , In, out) ;
    input clock , reset , In ;
    output [6:0] out ;
    wire div_clk ;
    parameter [2:0] ST0 = 3'd 0 ,
                    ST1 = 3'd 1 ,
                    ST2 = 3'd 2 ,
                    ST3 = 3'd 3 ,
                    ST4 = 3'd 4 ,
                    ST5 = 3'd 5 ,
                    ST6 = 3'd 6 ,
                    ST7 = 3'd 7 ;
    reg [2:0] CurrentState , NextState , temp  ;
    
    clk_div c1 (.clk_in(clock),.reset(reset),.clk_out(div_clk)) ;

    always@(posedge div_clk , negedge reset) // Sequential
    begin
        if(!reset)
            CurrentState <= ST0 ;
        else
            CurrentState<=NextState ;
    end 

    always@(CurrentState or NextState or In) //Combinational Change State
    begin
        case(CurrentState)
            ST0:begin
                if(!In)
                    NextState = ST1 ;
                else
                    NextState = ST3 ; 
            end
            ST1:begin
                if(!In)
                    NextState = ST2 ;
                else
                    NextState = ST5 ; 
            end
            ST2:begin
                if(!In)
                    NextState = ST3 ;
                else
                    NextState = ST0 ; 
            end
            ST3:begin
                if(!In)
                    NextState = ST4 ;
                else
                    NextState = ST1 ; 
            end
            ST4:begin
                if(!In)
                    NextState = ST5 ;
                else
                    NextState = ST2 ; 
            end
            ST5:begin
                if(!In)
                    NextState = ST6 ;
                else
                    NextState = ST4 ; 
            end
        endcase
    end

    always@(CurrentState) //Combinational Output
    begin
        case(CurrentState)
            ST0: temp = ST0 ; 
            ST1: temp = ST1 ; 
            ST2: temp = ST2 ; 
            ST3: temp = ST3 ; 
            ST4: temp = ST4 ; 
            ST5: temp = ST5 ; 
        endcase
    end 

    ssd s1 (.in(temp),.out(out)) ;

endmodule

