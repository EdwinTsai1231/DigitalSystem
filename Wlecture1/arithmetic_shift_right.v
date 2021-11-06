module testbench;
    reg     [3:0]   in;
    wire    [3:0]   out;

    //shifter u1(.in(in),.out(out));
    logical_shifter u1(.in(in), .out(out));
    initial begin

        in = 4'b1010;
        #5
        if(out == 4'b1101)
            $display ("in = %b; The result of arithmetically shift right = %b", in, out);
        else if(out == 4'b0101)
            $display ("in = %b; The result of logically shift right = %b", in, out);
        else
            $display ("The input does not shift correctly!");
        #20
        $finish;

    end
endmodule

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


module logical_shifter(in,out);
    input[3:0] in ;
    output reg [3:0] out ;

    always@(*)
    begin
        out = in >>1 ;
    end 
endmodule
