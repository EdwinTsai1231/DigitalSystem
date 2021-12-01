module testbench;
    reg     [2:0]   a,b;
    wire    [6:0]   out;

    threeBitsAdder u1(.a(a),.b(b),.out(out));
    initial begin
        a = 3'd 2;
        b = 3'd 4;
        #5
        $display ("a = %d, b = %h; out = %b", a, b, out);
        #20

        a = 3'd 4;
        b = 3'd 4;
        #5
        $display ("a = %d, b = %d; out = %b", a, b, out);
        #20
        
        a = 3'd 7;
        b = 3'd 7;
        #5
        $display ("a = %d, b = %d; out = %b", a, b, out);
        #20

        a = 3'd 7;
        b = 3'd 1;
        #5
        $display ("a = %d, b = %d; out = %b", a, b, out);
        #20

        a = 3'd 0;
        b = 3'd 0;
        #5
        $display ("a = %d, b = %d; out = %b", a, b, out);
        #20

        $finish ;
    end
endmodule

module SevenSegment(in,out);
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

module threeBitsAdder(a,b,out);
    input[2:0] a, b;
    wire [3:0] sum ;
    output [6:0] out ;

    assign sum = a+b ;

    SevenSegment display (sum , out);

endmodule
