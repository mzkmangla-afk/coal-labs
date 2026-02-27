`timescale 1ns/1ps

module divider_8bit (
    input wire clk,
    input wire rst,                 // synchronous reset
    input wire start,               // start signal
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    output reg [7:0] quotient,
    output reg [7:0] remainder,
    output reg ready
);

    reg [15:0] rem_reg;             // 16-bit remainder register
    reg [7:0] div_reg;              // divisor register
    reg [3:0] count;                // 0 to 8 (needs 4 bits)
    reg busy;

    always @(posedge clk) begin
        if (rst) begin
            quotient  <= 0;
            remainder <= 0;
            rem_reg   <= 0;
            div_reg   <= 0;
            count     <= 0;
            ready     <= 0;
            busy      <= 0;
        end

        else begin

            // START CONDITION
            if (start && !busy) begin
                ready    <= 0;
                busy     <= 1;
                count    <= 0;
                quotient <= dividend;
                div_reg  <= divisor;
                rem_reg  <= 0;

                // divide by zero protection
                if (divisor == 0) begin
                    quotient  <= 8'hFF;
                    remainder <= dividend;
                    ready     <= 1;
                    busy      <= 0;
                end
            end

            // DIVISION PROCESS (8 iterations)
            else if (busy) begin
                if (count < 8) begin

                    // Left shift {remainder, quotient}
                    rem_reg = {rem_reg[14:0], quotient[7]};
                    quotient = {quotient[6:0], 1'b0};

                    // Subtract divisor
                    rem_reg = rem_reg - {8'b0, div_reg};

                    if (rem_reg[15] == 1) begin
                        // Negative -> restore
                        rem_reg = rem_reg + {8'b0, div_reg};
                        quotient[0] = 0;
                    end
                    else begin
                        quotient[0] = 1;
                    end

                    count <= count + 1;
                end
                else begin
                    // DONE (after 8 cycles)
                    remainder <= rem_reg[7:0];
                    ready <= 1;
                    busy  <= 0;
                end
            end
        end
    end

endmodule