# lab4
## adder_substractor

``` Verilog
module adder_subtractor(a, b, select, out, overflow); 

    input [1:0] a; // 2 bits data a 
    input [1:0] b; // 2 bits data b
    input select ; // select adding or substracting
    output reg [1:0] out; // two bits data out
    output reg overflow; // overflow

    always@(*)
    begin
        if(select==1)
        {overflow,out}=a+b; // use {} concatenation 如果 overflow 出現會記錄在 overflow 
        else
        {overflow,out}=a-b;
    end

endmodule
``` 
