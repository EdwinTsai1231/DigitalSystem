module decoder (a,y) ;
    parameter size=4;
    input [1:0]a;
    output reg [size-1:0] y;

    always@(a)
    begin 
        case(a)
            0:y=4'b 0001;
            1:y=4'b 0010;
            2:y=4'b 0100;
            default: y=4'b 1000;
        endcase
    end
endmodule

module decoder3_6(a,en,y) ;
    input en ;
    input[2:0] a;
    output reg [5:0] y;

    always@(*)
    begin
        if(!en)
            y=6'b 0 ;
        else
            case(a)
                0:y=6'b000001;
                1:y=6'b000010;
                2:y=6'b000100;
                3:y=6'b001000;
                4:y=6'b010000;
                5:y=6'b100000;
                default:y=6'b0;
            endcase
    end
endmodule
