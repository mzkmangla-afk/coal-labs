module tb_mul8u_fast;

    reg  [7:0] a, b;
    wire [15:0] y;

    mul8u_fast DUT (.a(a), .b(b), .y(y));

    initial begin
        $dumpfile("task3_tb.vcd");
        $dumpvars(0, tb_mul8u_fast);
        // Corner cases
        a = 0;   b = 0;   #10;
        a = 0;   b = 255; #10;
        a = 255; b = 0;   #10;
        a = 255; b = 255; #10;

        // Typical values
        a = 1;   b = 1;   #10;
        a = 7;   b = 9;   #10;
        a = 15;  b = 15;  #10;

        // Random tests
        a = 23;  b = 19;  #10;
        a = 128; b = 2;   #10;
        a = 200; b = 100; #10;

        $finish;
    end

endmodule