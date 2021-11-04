module testbench;
    reg [3:0] in;
    wire [1:0] out;
    wire valid;

    encoder u1(.in(in),.valid(valid),.out(out));
    initial begin
        in = 4'b0001;
        #5
        if(valid)
            $display ("in = %b; Output is valid, out = %b", in, out);
        else
            $display ("in = %b; Output is not valid, out = %b", in, out);
        #20

        in = 4'b0010;
        #5
        if(valid)
            $display ("in = %b; Output is valid, out = %b", in, out);
        else
            $display ("in = %b; Output is not valid, out = %b", in, out);
        #20

        in = 4'b0100;
        #5
        if(valid)
            $display ("in = %b; Output is valid, out = %b", in, out);
        else
            $display ("in = %b; Output is not valid, out = %b", in, out);
        #20

        in = 4'b1000;
        #5
        if(valid)
            $display ("in = %b; Output is valid, out = %b", in, out);
        else
            $display ("in = %b; Output is not valid, out = %b", in, out);
        #20

        in = 4'b0000;
        #5
        if(valid)
            $display ("in = %b; Output is valid, out = %b", in, out);
        else
            $display ("in = %b; Output is not valid, out = %b", in, out);
        #20

        in = 4'b1111;
        #5
        if(valid)
            $display ("in = %b; Output is valid, out = %b", in, out);
        else
            $display ("in = %b; Output is not valid, out = %b", in, out);

        $finish;
    end
endmodule



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
