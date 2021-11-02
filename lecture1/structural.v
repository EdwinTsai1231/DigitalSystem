
module testbench;
    reg x,y,c_in;
    wire s,c;
    FA adder(.x(x),.y(y),.c_in(c_in),.sum(s),.c_out(c));

    initial begin
        x = 0;
        y = 0;
        c_in = 0;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 1;
        y = 0;
        c_in = 0;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 0;
        y = 1;
        c_in = 0;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 1;
        y = 1;
        c_in = 0;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 0;
        y = 0;
        c_in = 1;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 1;
        y = 0;
        c_in = 1;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 0;
        y = 1;
        c_in = 1;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);
        #20 

        x = 1;
        y = 1;
        c_in = 1;
        #5
        $display ("X = %d , Y = %d , C_in = %d , C_out = %d , S = %d\n",x,y,c_in,c,s);

        $finish;
    end
endmodule



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

