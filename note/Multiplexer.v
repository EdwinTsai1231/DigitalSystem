module mux2to1a(a,b,Select,Out); //Method 1
    input a,b,Select ; //default 1 bit
    output Out ; // default 1 bit
    reg Out ;

    always@(a or b or Select)
    begin 
    if(Select)
        Out=a;
    else
        Out=b;
    end
endmodule

module mux2to1b(a,b,Select,Out) ; //Method 2
    assign Out = Select?a:b ;
endmodule

module mux4to1(a,b,c,d,s1,s0,out) ;
    input a,b,c,d,s1,s0; //default 1 bit
    output out ; //default 1 bit
    reg out ;

    always@(*)
    begin 
    case({s1,s0})
        2'b 00: out=a;
        2'b 01: out=b;
        2'b 10: out=c;
        default : out=d;
    endcase
    end
endmodule

module multibit(a,b,select,out) ;
    input[3:0] a,b;
    input select ;
    output[3:0] out;
    wire out;

    assign out = select ? a:b ;

endmodule

module multibit2(a,b,select,out) ;
    parameter width = 8;
    input [width-1:0] a,b;
    input select ;
    output [width-1:0] out ;
    wire[width-1:0] out ;

    assign out = select? a:b;
endmodule
