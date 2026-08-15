/*
 * Verilog Testbench for 4-Bit ALU
 * Verification Tool: Icarus Verilog (iverilog) + GTKWave
 * Author: Vila Ram Varshit
 */

`timescale 1ns / 1ps

module tb_alu_4bit;

    reg clk;
    reg rst_n;
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] opcode;
    wire [4:0] result;
    wire zero_flag;
    wire overflow_flag;

    // Instantiate UUT
    alu_4bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero_flag(zero_flag),
        .overflow_flag(overflow_flag)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("alu_4bit_sim.vcd");
        $dumpvars(0, tb_alu_4bit);

        clk = 0;
        rst_n = 0;
        a = 0;
        b = 0;
        opcode = 0;

        #15 rst_n = 1;

        #10 a = 4'b0100; b = 4'b0011; opcode = 3'b000; // ADD
        #10 a = 4'b1001; b = 4'b0100; opcode = 3'b001; // SUB
        #10 a = 4'b1100; b = 4'b1010; opcode = 3'b010; // AND
        #10 a = 4'b1100; b = 4'b1010; opcode = 3'b011; // OR

        #20;
        $finish;
    end

endmodule
