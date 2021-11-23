# VerilogNote_003
---
## Basic Declaration
```
//範例
module counter(clock,reset,out) ; //top module
    input clock , reset ;
    output[6:0] out ;
    reg[3:0] temp ;
    wire div_clk;
    FrequencyDivider f1 (.clk(clock),.reset(reset),.div_clk(div_clk)) ;

    always@(posedge div_clk or negedge reset)
    begin
        if(!reset)
            temp = 0 ;
        else
            begin

            if(temp==4'd 15)
                temp = 4'b 0 ;
            else
                temp = temp + 1'b 1 ;

            end
    end
    SevenDisplay u1 (.in(temp),.out(out)) ;

endmodule
```
### module
Verilog起始宣告的關鍵字。後面的括弧裡面放input,output的腳位，
記得module那一行最後要加分號" ; "，

同時記得最後一定要在結尾處加個**endmodule**。

### input , output
負責輸入輸出腳位，可以跟module的wire合併。
+ input : input 必須要為 wire，input 本身預設就為 wire，因此不必特別去改。
+ output : output 可以為 wire 或 reg ，預設為 wire ，若想宣告為 reg ，
可輸入 output reg < 變數名稱 > ;

### assign 
```
assign temp = a&b ;
```
把運算的結果 assign 給一個 wire 變數。!!! 一定要是 wire !!!

---


## 3 Methods to Describe the Circuit 

### Structural Description
```
module HA(a, b, sum, carry);
    input a, b;
    output sum, carry;
    reg sum, carry;

    always@(a or b)
    begin
        sum = a^b;
        carry = a&b;
    end
endmodule

module FA(x,y,c_in,sum,c_out);
    input x,y,c_in;
    output sum,c_out;
    wire w1 , w2, w3 ;

    HA half_adder1 (.a(x) , .b(y) , .sum(w1) , .carry(w2) ) ;
    HA half_adder2 (.a(c_in) , .b(w1) , .sum(sum) , .carry(w3) );
    or(c_out , w2 , w3) ;
endmodule
```
利用不同的module，來完成電路，通常用在high-level。

### Data Flow Descriptioni

```
module FA(x,y,c_in,sum,c_out);
    input x,y,c_in;
    output sum,c_out;

    assign{c_out , sum } = x+y+c_in ;

endmodule
```

data flow 是利用 wire 來串接在一起的表示方式。

### Behavior Description 
```
module FA(x,y,c_in,sum,c_out);
    input x,y,c_in;
    output sum,c_out;
    reg sum , c_out ;
    wire a , b, c ;

    always@(x or y or c_in)
    begin
        {c_out , sum } = x+y+c_in ; //{cout , sum} 當作兩個 bits
    end
endmodule
```
Behavior 是用 reg ( Register ) 來表示電路，因此常跟 always 搭配使用。
```
個人想法：
Structural Behavior 適用在 high-level。
Data Flow & Behavior 適用在 low-level。
```
