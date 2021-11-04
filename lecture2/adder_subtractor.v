module testbench;



    reg [1:0] a, b;

    reg select;



    wire [1:0] out;

    wire overflow;



    adder_subtractor u1(.a(a),.b(b),.select(select),.out(out),.overflow(overflow));



    initial begin



        a = 2'b00;



        b = 2'b00;



        select = 1'b1;



        #5

        

        if(overflow)

            $display ("a = %d, b = %d, select = %d; a + b = %d, overflow", a, b, select, out);

        else

            $display ("a = %d, b = %d, select = %d; a + b = %d, no overflow", a, b, select, out);



        #20 



        a = 2'b01;



        b = 2'b01;



        select = 1'b1;



        #5

        

        if(overflow)

            $display ("a = %d, b = %d, select = %d; a + b = %d, overflow", a, b, select, out);

        else

            $display ("a = %d, b = %d, select = %d; a + b = %d, no overflow", a, b, select, out);



        #20

        

        a = 2'b11;



        b = 2'b01;



        select = 1'b1;



        #5

        

        if(overflow)

            $display ("a = %d, b = %d, select = %d; a + b = %d, overflow", a, b, select, out);

        else

            $display ("a = %d, b = %d, select = %d; a + b = %d, no overflow", a, b, select, out);



        #20

        

        a = 2'b00;



        b = 2'b01;



        select = 1'b0;



        #5

        

        if(overflow)

            $display ("a = %d, b = %d, select = %d; a - b = %d, overflow", a, b, select, out);

        else

            $display ("a = %d, b = %d, select = %d; a - b = %d, no overflow", a, b, select, out);



        #20

        

        a = 2'b10;



        b = 2'b10;



        select = 1'b0;



        #5

        

        if(overflow)

            $display ("a = %d, b = %d, select = %d; a - b = %d, overflow", a, b, select, out);

        else

            $display ("a = %d, b = %d, select = %d; a - b = %d, no overflow", a, b, select, out);



        #20

        

        a = 2'b01;



        b = 2'b11;



        select = 1'b0;



        #5

        

        if(overflow)

            $display ("a = %d, b = %d, select = %d; a - b = %d, overflow", a, b, select, out);

        else

            $display ("a = %d, b = %d, select = %d; a - b = %d, no overflow", a, b, select, out);





        $finish;



    end



endmodule





module adder_subtractor(a, b, select, out, overflow);

input [1:0] a;
input [1:0] b;
input select ;
output reg [1:0] out;
output reg overflow;

always@(*)
begin
    if(select==1)
    {overflow,out}=a+b;
    else
    {overflow,out}=a-b;
end

endmodule
