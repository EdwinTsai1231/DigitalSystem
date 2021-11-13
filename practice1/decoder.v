module testbench;
    reg     [2:0]   in;
    reg             enable;
    wire    [7:0]   out;

    decoder u1(.in(in),.enable(enable),.out(out));
    initial begin
        // enable = 0
        enable = 1'b0;
        in = 3'b000;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b001;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b010;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b011;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b100;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b101;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b110;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b111;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        // enable = 1
        enable = 1'b1;

        in = 3'b000;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        
        in = 3'b001;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b010;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b011;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b100;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b101;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b110;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20

        in = 3'b111;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);

        $finish;
    end
endmodule


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


