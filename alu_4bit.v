```verilog
/*
 * Project 1: RTL-to-GDSII Physical Design Flow
 * Target Module: 4-Bit Arithmetic Logic Unit (ALU)
 * Technology Node: SkyWater 130nm PDK (sky130A)
 * Author: Vila Ram Varshit
 */
module alu_4bit (
    input wire clk,
    input wire rst_n,
    input wire [3:0] a,
    input wire [3:0] b,
    input wire [2:0] opcode,
    output reg [4:0] result,
    output reg zero_flag,
    output reg overflow_flag
);
    reg [4:0] alu_out;
    // Combinational ALU Logic
    always @(*) begin
        case (opcode)
            3'b000: alu_out = a + b;           // ADD
            3'b001: alu_out = a - b;           // SUB
            3'b010: alu_out = {1'b0, a & b};   // AND
            3'b011: alu_out = {1'b0, a | b};   // OR
            3'b100: alu_out = {1'b0, a ^ b};   // XOR
            3'b101: alu_out = {1'b0, ~(a | b)};// NOR
            3'b110: alu_out = {1'b0, a << 1};  // Shift Left
            3'b111: alu_out = {1'b0, a >> 1};  // Shift Right
            default: alu_out = 5'b00000;
        endcase
    end
    // Sequential Output Registering
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result        <= 5'b00000;
            zero_flag     <= 1'b0;
            overflow_flag <= 1'b0;
        end else begin
            result        <= alu_out;
            zero_flag     <= (alu_out[3:0] == 4'b0000);
            overflow_flag <= alu_out[4];
        end
    end
endmodule
