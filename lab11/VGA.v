module vga (clk , clk_25 , button1 , button2 , button3 ,reset , red , blue , green , vga_hsync , vga_vsync) ;
    input clk , reset  , button1 , button2 , button3 ;
    output reg[3:0] red , blue , green ; 
    reg[3:0] tempRed , tempBlue , tempGreen ;
    output reg vga_hsync , vga_vsync ;
    
    reg[9:0] hs = 0 ;
    reg[9:0] vs = 0 ;
    output reg clk_25 ;

    always@(button1 , button2 , button3)
    begin
        if(button1 == 0)
            tempRed = tempRed+1 ;
        else if(button2 == 0 )
            tempBlue = tempBlue+1 ;
        else
            tempGreen = tempGreen+1 ;
    end

    always@(posedge clk or negedge reset )
    begin
    if(reset)
        clk_25 <= 1'b 0 ;
    else
        clk_25 <= ~clk_25;
    end

    always@(posedge clk_25 or negedge reset )
    begin
        if(reset)
            begin
                hs <= 0 ;
                vs <= 0 ;
                red <= 0 ;
                green <= 0 ;
                blue <= 0 ;
            end
        else 
            begin
                if(hs==799)
                    begin
                        hs <= 0 ;
                        if(vs == 524)
                            vs <= 0 ;
                        else
                            vs <= vs+1 ;
                    end
                else
                    hs <= hs+1;

                if((hs>=656)&&(hs<752))
                    vga_hsync <= 0 ;
                else
                    vga_hsync <= 1 ;

                if((vs>=490)&&(vs>492))
                    vga_vsync <= 0 ;
                else
                    vga_vsync <= 1 ;

                if((hs>=0) && (hs<640) && (vs>=0) &&(vs<480))
                    begin
                        red <= tempRed ;
                        green <= tempGreen ;
                        blue <= tempBlue ;
                    end
            end
    end
endmodule
