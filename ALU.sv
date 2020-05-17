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
   
    parameter S0 = 2'b00;   //ALU Control bitleri
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
   
    logic [3:0] mux_out;
    logic [3:0] adder_result;
   
    
    //Ifin içine taþýma iþlemi baþarýsýz, Always Statementýnýn içine Module yazýlamýyormuþ.
    
    MUX2 mux(B,~B,ALUControl[0],mux_out);  
    NbitFulladder adder(A,mux_out,ALUControl[0],adder_result,cout); 
    
   
   always_comb
    begin
    
    if(ALUControl==S2)  //AND OPERATOR
    begin 
    Result = A&B;
    if(Result == 4'b0000)   //ZERO KONTROL
       begin
       ALUFlags[0]=1; 
       end
    end
    else if(ALUControl==S3) //OR OPERATOR
    begin
    Result =A|B;
    if(Result == 4'b0000)   //ZERO KONTROL
       begin
       ALUFlags[0]=1; 
       end
    end
            //BURADAN SONRA ARITMETIK KISIM, FLAG KISMI DEVREYE GIRIYOR 
   
    else if(ALUControl==S0)
    begin
    Result= adder_result;
    ALUFlags=4'b0000;
    ALUFlags[2]= cout & (~ALUControl[1]); //Carry CONTROL
    ALUFlags[3]= ((~(ALUControl[0] ^ A[0] ^ B[0])) & (Result[0] ^ A[0]) & (~ALUControl[1]));
    if(Result == 4'b0000 & ~ALUFlags[3])   //ZERO KONTROL
       begin
       ALUFlags[0]=1; 
       end
    if(Result[3]==1)       //NEGATIVE KONTROL
        begin
        ALUFlags[1]=1;
        end
    end
    
    //ACIKLAMA: 
        //Zero flagi için NAND kullanilmadi.
        //Carry out problem yaþatýyor.
        //Negatif Result[3] her durumda negatif anlamýna mu geliyor? Negatif de son örnekte çalýþýyor.
        
        //Ufak düzeltmelerden sonra lab bitti.
    
    
    else if(ALUControl==S1)
    begin
    ALUFlags=4'b0000;
    Result= adder_result;
    ALUFlags[2]= cout & (~ALUControl[1]); //Carry CONTROL
    ALUFlags[3]= ((~(ALUControl[0] ^ A[0] ^ B[0])) & (Result[0] ^ A[0]) & (~ALUControl[1]));
    if(Result == 4'b0000 & ~ALUFlags[3])   //ZERO KONTROL
       begin
       ALUFlags[0]=1; 
       end
    if(Result[3]==1)       //NEGATIVE KONTROL
        begin
        ALUFlags[1]=1;
        end
    end  
   
   
   end
endmodule
