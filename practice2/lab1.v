module testbench;
    reg     [3:0]   data_in;
    wire    [6:0]   data_out;
    special_multiplier special_multiplier_u(.num(data_in), .result(data_out));
    initial begin

        #10
        data_in = 4'd0;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd1;
        #5
        if(data_out == 7'b1111001)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 1", data_in, data_out);
        
        data_in = 4'd2;
        #5
        if(data_out == 7'b0100100)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 2", data_in, data_out);

        data_in = 4'd3;
        #5
        if(data_out == 7'b0000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 8", data_in, data_out);

        data_in = 4'd4;
        #5
        if(data_out == 7'b0001000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 10", data_in, data_out);

        data_in = 4'd5;
        #5
        if(data_out == 7'b1000110)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 12", data_in, data_out);

        data_in = 4'd6;
        #5
        if(data_out == 7'b0001000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 10", data_in, data_out);

        data_in = 4'd7;
        #5
        if(data_out == 7'b1000110)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 12", data_in, data_out);

        data_in = 4'd8;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd9;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd10;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd11;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd12;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd13;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd14;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        data_in = 4'd15;
        #5
        if(data_out == 7'b1000000)
            $display ("correct !!!");
        else
            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        $finish;
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

module special_multiplier (num,result);
    input [3:0] num ;
    output [6:0] result ; 
    reg [3:0] sum ;

    always @(num)
    begin
        if(num<=4'd 2)
            begin
            sum = num ;  
            end

        else if(num<=4'd 5)
            begin
            sum = (num+1) << 1 ; 
            end

        else if(num<=7)
            begin 
            sum = (num-1) << 1 ;
            end

        else
            begin
            sum = 0 ;
            end
    end

    SevenSegment display(sum , result) ;

endmodule 
