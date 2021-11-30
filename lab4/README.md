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
## encoder
``` Verilog
module encoder(in, valid, out);

    input [3:0] in; 
    output reg valid;
    output reg [1:0] out;

    always@(in)
    begin
        case(in)
        4'b0001: begin valid=1 ; out[1]=0 ; out[0]=0 ; end
        4'b0010: begin valid=1 ; out[1]=0 ; out[0]=1 ; end
        4'b0100: begin valid=1 ; out[1]=1 ; out[0]=0 ; end
        4'b1000: begin valid=1 ; out[1]=1 ; out[0]=1 ; end
        default: begin valid=0 ; out[1]=0 ; out[0]=0 ; end
        endcase
    end

endmodule
// 將 4 bits 的 data 轉換成 2 bits 。
```
 **Functiona table :**

| in[3] | in[2] | in[1] | in[0] | valid | out[1] | out[0] |
| ----  | ----  | ----  | ----  | ----  | ----   | -----  |
|  0    |   0   |  0    |   1   |   1   |   0    |   0    |
|  0    |   0   |  1    |   0   |   1   |   0    |   1    |
|  0    |   1   |  0    |   0   |   1   |   1    |   0    |
|  1    |   0   |  0    |   0   |   1   |   1    |   1    |
|default|default|default|default|   0   |   0    |   0    | 
