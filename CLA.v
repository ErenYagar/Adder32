`timescale 1ns / 1ps
module CLA
(
input [31:0] A,
input [31:0] B,
output [31:0] S,
output Cout
);
wire [31:0] Cin;

FA g0 ( .A(A[0]), .B(B[0]), .Cin(1'b0), .S(S[0]), .Cout(Cin[0]) );
FA g1 ( .A(A[1]), .B(B[1]), .Cin(Cin[0]), .S(S[1]), .Cout(Cin[1]) );
FA g2 ( .A(A[2]), .B(B[2]), .Cin(Cin[1]), .S(S[2]), .Cout(Cin[2]) );
FA g3 ( .A(A[3]), .B(B[3]), .Cin(Cin[2]), .S(S[3]), .Cout(Cin[3]) );
FA g4 ( .A(A[4]), .B(B[4]), .Cin(Cin[3]), .S(S[4]), .Cout(Cin[4]) );
FA g5 ( .A(A[5]), .B(B[5]), .Cin(Cin[4]), .S(S[5]), .Cout(Cin[5]) );
FA g6 ( .A(A[6]), .B(B[6]), .Cin(Cin[5]), .S(S[6]), .Cout(Cin[6]) );
FA g7 ( .A(A[7]), .B(B[7]), .Cin(Cin[6]), .S(S[7]), .Cout(Cin[7]) );
FA g8 ( .A(A[8]), .B(B[8]), .Cin(Cin[7]), .S(S[8]), .Cout(Cin[8]) );
FA g9 ( .A(A[9]), .B(B[9]), .Cin(Cin[8]), .S(S[9]), .Cout(Cin[9]) );
FA g10 ( .A(A[10]), .B(B[10]), .Cin(Cin[9]), .S(S[10]), .Cout(Cin[10]) );
FA g11 ( .A(A[11]), .B(B[11]), .Cin(Cin[10]), .S(S[11]), .Cout(Cin[11]) );
FA g12 ( .A(A[12]), .B(B[12]), .Cin(Cin[11]), .S(S[12]), .Cout(Cin[12]) );
FA g13 ( .A(A[13]), .B(B[13]), .Cin(Cin[12]), .S(S[13]), .Cout(Cin[13]) );
FA g14 ( .A(A[14]), .B(B[14]), .Cin(Cin[13]), .S(S[14]), .Cout(Cin[14]) );
FA g15 ( .A(A[15]), .B(B[15]), .Cin(Cin[14]), .S(S[15]), .Cout(Cin[15]) );
FA g16 ( .A(A[16]), .B(B[16]), .Cin(Cin[15]), .S(S[16]), .Cout(Cin[16]) );
FA g17 ( .A(A[17]), .B(B[17]), .Cin(Cin[16]), .S(S[17]), .Cout(Cin[17]) );
FA g18 ( .A(A[18]), .B(B[18]), .Cin(Cin[17]), .S(S[18]), .Cout(Cin[18]) );
FA g19 ( .A(A[19]), .B(B[19]), .Cin(Cin[18]), .S(S[19]), .Cout(Cin[19]) );
FA g20 ( .A(A[20]), .B(B[20]), .Cin(Cin[19]), .S(S[20]), .Cout(Cin[20]) );
FA g21 ( .A(A[21]), .B(B[21]), .Cin(Cin[20]), .S(S[21]), .Cout(Cin[21]) );
FA g22 ( .A(A[22]), .B(B[22]), .Cin(Cin[21]), .S(S[22]), .Cout(Cin[22]) );
FA g23 ( .A(A[23]), .B(B[23]), .Cin(Cin[22]), .S(S[23]), .Cout(Cin[23]) );
FA g24 ( .A(A[24]), .B(B[24]), .Cin(Cin[23]), .S(S[24]), .Cout(Cin[24]) );
FA g25 ( .A(A[25]), .B(B[25]), .Cin(Cin[24]), .S(S[25]), .Cout(Cin[25]) );
FA g26 ( .A(A[26]), .B(B[26]), .Cin(Cin[25]), .S(S[26]), .Cout(Cin[26]) );
FA g27 ( .A(A[27]), .B(B[27]), .Cin(Cin[26]), .S(S[27]), .Cout(Cin[27]) );
FA g28 ( .A(A[28]), .B(B[28]), .Cin(Cin[27]), .S(S[28]), .Cout(Cin[28]) );
FA g29 ( .A(A[29]), .B(B[29]), .Cin(Cin[28]), .S(S[29]), .Cout(Cin[29]) );
FA g30 ( .A(A[30]), .B(B[30]), .Cin(Cin[29]), .S(S[30]), .Cout(Cin[30]) );
FA g31 ( .A(A[31]), .B(B[31]), .Cin(Cin[30]), .S(S[31]), .Cout(Cin[31]) );

assign Cout = Cin[31];

endmodule