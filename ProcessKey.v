
module ProcessKey(output reg [48:1] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10, key11, key12, key13, key14, key15, key16, input [64:1] key);
  
  function [56:1] PC1_perm(input [64:1] key);
    integer PC1[56:1];
    integer i;
    reg [56:1] temp_perm;
    begin
			PC1[1] = 57;
			PC1[2] = 49;
			PC1[3] = 41;
			PC1[4] = 33;
			PC1[5] = 25;
			PC1[6] = 17;
			PC1[7] = 9;
			PC1[8] = 1;
			PC1[9] = 58;
			PC1[10] = 50;
			PC1[11] = 42;
			PC1[12] = 34;
			PC1[13] = 26;
			PC1[14] = 18;
			PC1[15] = 10;
			PC1[16] = 2;
			PC1[17] = 59;
			PC1[18] = 51;
			PC1[19] = 43;
			PC1[20] = 35;
			PC1[21] = 27;
			PC1[22] = 19;
			PC1[23] = 11;
			PC1[24] = 3;
			PC1[25] = 60;
			PC1[26] = 52;
			PC1[27] = 44;
			PC1[28] = 36;
			PC1[29] = 63;
			PC1[30] = 55;
			PC1[31] = 47;
			PC1[32] = 39;
			PC1[33] = 31;
			PC1[34] = 23;
			PC1[35] = 15;
			PC1[36] = 7;
			PC1[37] = 62;
			PC1[38] = 54;
			PC1[39] = 46;
			PC1[40] = 38;
			PC1[41] = 30;
			PC1[42] = 22;
			PC1[43] = 14;
			PC1[44] = 6;
			PC1[45] = 61;
			PC1[46] = 53;
			PC1[47] = 45;
			PC1[48] = 37;
			PC1[49] = 29;
			PC1[50] = 21;
			PC1[51] = 13;
			PC1[52] = 5;
			PC1[53] = 28;
			PC1[54] = 20;
			PC1[55] = 12;
			PC1[56] = 4;
			
			for(i=1; i<=56; i=i+1)
        temp_perm[56-i+1] = key[64-PC1[i]+1];
			
			PC1_perm = temp_perm;
    end
  endfunction
  
  function [48:1] PC2_perm(input [56:1] key_s);
    integer PC2[48:1];
    integer i;
    reg [48:1] temp_perm;
    begin
			PC2[1] = 14;
			PC2[2] = 17;
			PC2[3] = 11;
			PC2[4] = 24;
			PC2[5] = 1;
			PC2[6] = 5;
			PC2[7] = 3;
			PC2[8] = 28;
			PC2[9] = 15;
			PC2[10] = 6;
			PC2[11] = 21;
			PC2[12] = 10;
			PC2[13] = 23;
			PC2[14] = 19;
			PC2[15] = 12;
			PC2[16] = 4;
			PC2[17] = 26;
			PC2[18] = 8;
			PC2[19] = 16;
			PC2[20] = 7;
			PC2[21] = 27;
			PC2[22] = 20;
			PC2[23] = 13;
			PC2[24] = 2;
			PC2[25] = 41;
			PC2[26] = 52;
			PC2[27] = 31;
			PC2[28] = 37;
			PC2[29] = 47;
			PC2[30] = 55;
			PC2[31] = 30;
			PC2[32] = 40;
			PC2[33] = 51;
			PC2[34] = 45;
			PC2[35] = 33;
			PC2[36] = 48;
			PC2[37] = 44;
			PC2[38] = 49;
			PC2[39] = 39;
			PC2[40] = 56;
			PC2[41] = 34;
			PC2[42] = 53;
			PC2[43] = 46;
			PC2[44] = 42;
			PC2[45] = 50;
			PC2[46] = 36;
			PC2[47] = 29;
			PC2[48] = 32;
			
			for(i=1; i<=48; i=i+1)
        temp_perm[48-i+1] = key_s[56-PC2[i]+1];

			PC2_perm = temp_perm;
    end
  endfunction

  function [56:1] C_i_D_i(input integer i, input [28:1] C_last, D_last);
    integer shift_left[1:16];
    begin
      shift_left[1] = 1;
      shift_left[2] = 1;
      shift_left[3] = 2;
      shift_left[4] = 2;
      shift_left[5] = 2;
      shift_left[6] = 2;
      shift_left[7] = 2;
      shift_left[8] = 2;
      shift_left[9] = 1;
      shift_left[10] = 2;
      shift_left[11] = 2;
      shift_left[12] = 2;
      shift_left[13] = 2;
      shift_left[14] = 2;
      shift_left[15] = 2;
      shift_left[16] = 1;
      
      if(shift_left[i] == 'd1)
        C_i_D_i = {C_last[27:1], C_last[28], D_last[27:1], D_last[28]};
      else if(shift_left[i] == 'd2)
        C_i_D_i = {C_last[26:1], C_last[28:27], D_last[26:1], D_last[28:27]};
      
    end
  endfunction

  reg [56:1] temp_pc1;
  reg [28:1] C[16:0], D[16:0];
  reg [48:1] K[1:16];
  integer i;
  
  always @(key)
  begin
    temp_pc1 = PC1_perm(key);
    C[0] = temp_pc1[56:29];
    D[0] = temp_pc1[28:1];
    for(i=1; i<=16; i=i+1)
    begin
      {C[i], D[i]} = C_i_D_i(i, C[i-1], D[i-1]);
      K[i] = PC2_perm({C[i], D[i]});
    end
    
    key1 = K[1];
    key2 = K[2];
    key3 = K[3];
    key4 = K[4];
    key5 = K[5];
    key6 = K[6];
    key7 = K[7];
    key8 = K[8];
    key9 = K[9];
    key10 = K[10];
    key11 = K[11];
    key12 = K[12];
    key13 = K[13];
    key14 = K[14];
    key15 = K[15];
    key16 = K[16];
  end
endmodule