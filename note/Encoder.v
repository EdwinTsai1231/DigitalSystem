module encoder(A,Y); // encoder 4 to 2
    parameter size=4 ;
    input[size-1:0] A ;
    output[1:0] Y ;
    reg [1:0] Y ;

    always@(*)
    begin
        case(A)
            4'b 0001: Y=0;
            4'b 0010: Y=1;
            4'b 0100: Y=2;
            4'b 1000: Y=3;
            default: Y=2'b 00;
        endcase
    end
endmodule

module encoder2(a,valid,y) //priority encoder (4 to 2)
    input [3:0] a;
    output reg valid ;
    output reg [1:0] y;

    always@(a)
    begin
        valid = 1 ;
        casex(A)
            4'b 1xxx:y=3; // x represents "Don't care"
            4'b 01xx:y=2;
            4'b 001x:y=1;
            4'b 0001:y=0;
            default :
            begin valid =0 ; y=2'b 00 ; end
        endcase
    end
endmodule 

