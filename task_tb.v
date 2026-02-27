`timescale 1ns/1ps

module tb_divider;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] dividend;
    reg [7:0] divisor;

    wire [7:0] quotient;
    wire [7:0] remainder;
    wire ready;

    // Instantiate Divider
    divider_8bit uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder),
        .ready(ready)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("divider.vcd");
        $dumpvars(0, tb_divider);

        clk = 0;
        rst = 1;
        start = 0;
        dividend = 0;
        divisor = 0;

        #20;
        rst = 0;

        // Test Case 1: 100 / 7
        #10;
        dividend = 8'd100;
        divisor  = 8'd7;
        start = 1;
        #10;
        start = 0;

        wait(ready);
        #10;

        // Test Case 2: 55 / 5
        dividend = 8'd55;
        divisor  = 8'd5;
        start = 1;
        #10;
        start = 0;

        wait(ready);
        #10;

        // Test Case 3: Divide by zero
        dividend = 8'd25;
        divisor  = 8'd0;
        start = 1;
        #10;
        start = 0;

        wait(ready);
        #20;

        $finish;
    end

endmodule