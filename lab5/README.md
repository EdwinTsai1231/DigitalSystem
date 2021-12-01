# lab5 
---
## Seven_Segment
```Verilog
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
```
根據七段顯示器的燈號設置

## 3-bit_Adder
```Verilog
module threeBitsAdder(a,b,out);
    input[2:0] a, b;
    wire [3:0] sum ;
    output reg [6:0] out ;

    assign sum = a+b ;

    always@(sum)
    begin
        case(sum)
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
```
把 a , b 相加的結果 assign 給 temp 。 再把 temp 的結果利用七段顯示器顯示出來 。

