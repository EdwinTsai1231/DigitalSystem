# practice1 
----
## shift_right
shift_right 有分為兩種 : 
+ logical shift right
+ arithmatic shift right 

```Verilog
// logical shift right 
module logical_shifter(in,out);
    input[3:0] in ;
    output reg [3:0] out ;

    always@(*)
    begin
        out = in >>1 ;
    end 
endmodule
```
logical shift right 直接向右移一位，剩下的空缺由 0 來補齊。

``` Verilog
// arithmatic shift right
module shifter(in, out);
    input   [3:0]   in;
    output reg  [3:0]   out;

    always@(*)
    begin
        if(in[3]==0)
            out=in>>1;
        else
            out=in>>1;
            out[3]=1;
    end
endmodule

```
arithmatic shift right 會先考慮原數字的 signbit ：
+ 如果是負數( signbit = 1 )則右移後的空缺由 1 補上。  
+ 如果是正數( signbit = 0 )則右移後的空缺由 0 補上。


## decoder

```Verilog
module decoder(in, enable, out);
    input       [2:0]   in;
    input               enable;
    output reg  [7:0]   out;

    always@(*)
    begin
        if ( enable == 0 )
            begin
            out = 8'd 0;
            end
        else
            begin
            /* method 1
            case(in)
            3'd 0 : out = 8'b 00000001 ;
            3'd 1 : out = 8'b 00000010 ;
            3'd 2 : out = 8'b 00000100 ;
            3'd 3 : out = 8'b 00001000 ;
            3'd 4 : out = 8'b 00010000 ;
            3'd 5 : out = 8'b 00100000 ;
            3'd 6 : out = 8'b 01000000 ;
            3'd 7 : out = 8'b 10000000 ;
            endcase
            */

            /*method 2
            out = 8'd 1 << in ;
            */

            // method 3
            out = 8'd 0 ;
            out[in] = 1'd 1 ;
            end
    end
endmodule
```
+ method1 : 利用 behavior description 的方式一一寫出來。
+ method2 : 根據 in 變數來決定 8'd 1 所需要移動的位數。
+ method3 : 先把 out 變數初始化為 8'd 0 接下來再根據 in 數字在 out 相對應的位置設為 1 。

