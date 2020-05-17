`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2020 18:46:46
// Design Name: 
// Module Name: ALU
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

module ALU(input logic [3:0] A,B, 
                    input logic  [1:0] ALUControl,
                    output logic [3:0] Result,
                    output logic [3:0] ALUFlags
    );
  

    logic [3:0] mux_out;
    logic [3:0] adder_result;
    
    logic [3:0] d0; logic [3:0] d1; logic [3:0] d2; logic [3:0] d3;
   
    
    //Ifin içine taþýma iþlemi baþarýsýz, Always Statementýnýn içine Module yazýlamýyormuþ.
    
    MUX2 mux(B,~B,ALUControl[0],mux_out);  
    NbitFulladder adder(A,mux_out,ALUControl[0],adder_result,cout); 
    
always@*
    begin
    d0=adder_result;
    d1=adder_result;
    d2=A&B;
    d3=A|B;
    end
    
    MUX4 mux4(d0,d1,d2,d3,ALUControl,Result);
    
    always@(A,B)
    begin
    
    //NEGATIVE
    ALUFlags[0]<=Result[3];  
    
    //ZERO
    ALUFlags[1]<=(~Result[0] & ~Result[1] & ~Result[2] & ~Result[3]); 
    
    //CARRYOUT
    ALUFlags[2]<=(~ALUControl[1] & cout); 
    
    //OVERFLOW
    ALUFlags[3]<= (((ALUControl[0] ~^ A[3]) ~^ B[3]) & (adder_result[3] ^ A[3]) & (~ALUControl[1]));
   
    end
endmodule
