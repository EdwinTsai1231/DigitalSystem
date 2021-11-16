module alu_case(sel,carryIn,a,b,y);
    input[4:0] sel ;
    input carryIn ;
    input[7:0] a,b ;
    output reg [7:0] y ;

    always@(sel or a or b or carryIn)
    begin
        case({sel,carryIn})
        6'b000000 : y=a ; 
        6'b000001 : y=a+1 ; 
        6'b000010 : y=a+b ; 
        6'b000011 : y=a+b+1 ; 
        6'b000100 : y=a+!b ; 
        6'b000101 : y=a+!b+1 ; 
        6'b000110 : y=a-1 ; 
        6'b000111 : y=a ; 
        6'b001000 : y=a&b ; 
        6'b001010 : y=a|b ; 
        6'b001100 : y=a^b ; 
        6'b001110 : y=!a ; 
        6'b010000 : y=a<<1 ; 
        6'b100000 : y=a>>1 ;
        6'b110000 : y=0 ;
        default : y = 8'b x;
        endcase 
    end
endmodule
