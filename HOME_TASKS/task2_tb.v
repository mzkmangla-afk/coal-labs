module tb_mul8s_seq;

    reg clk, rst;
    reg signed [7:0] a, b;
    wire signed [15:0] y;
    wire ready;

    mul8s_seq DUT (clk, rst, a, b, y, ready);

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #10 rst = 0;

        a = -5;  b = 7;
        #100;

        a = -10; b = -10;
        #100;

        a = 127; b = -1;
        #100;

        $finish;
    end
endmodule