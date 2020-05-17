`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2020 18:51:19
// Design Name: 
// Module Name: TestbenchALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TestbenchALU();

    reg [3:0] A,B;
    reg [1:0] ALUControl;
    reg [3:0] Result;
    reg [3:0] ALUFlags;
    
    ALU alu(.A(A),.B(B),.ALUControl(ALUControl),.Result(Result),.ALUFlags(ALUFlags));
    initial begin
    
        A=4'b0101; B=4'b0010; ALUControl=2'b11; #10
        
        A=4'b0010; B=4'b0101; ALUControl=2'b10; #10
        
        A=4'b0111; B=4'b1000; ALUControl=2'b00; #10
        
        A=4'b0010; B=4'b0101; ALUControl=2'b01; #10
        
        
    
    $finish;
    end
    endmodule

