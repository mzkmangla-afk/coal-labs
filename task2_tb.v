module tb_mul8u_seq;

    reg clk, rst;
    reg [7:0] a, b;
    wire [15:0] y;
    wire ready;

    mul8u_seq DUT (clk, rst, a, b, y, ready);

    always #5 clk = ~clk;

    initial begin
        $dumpfile("task2_tb.vcd");
        $dumpvars(0, tb_mul8u_seq);
        clk = 0; rst = 1;
        a = 0; b = 0;
        #10 rst = 0;

        a = 15; b = 3;
        #100;

        a = 255; b = 255;
        #100;

        $finish;
    end
endmodule