
module test;
  
//  wire [48:1] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10, key11, key12, key13, key14, key15, key16;
  reg [64:1] key;
  
  reg [64:1] message;
  wire [64:1] ciphertext;
//  ProcessKey pk(key1, key2, key3, key4, key5, key6, key7, key8, key9, key10, key11, key12, key13, key14, key15, key16, key);
  Encrypt e(ciphertext, message, key);
  
  initial
  begin
    key = 64'b00010011_00110100_01010111_01111001_10011011_10111100_11011111_11110001;
    message =  64'b0000_0001_0010_0011_0100_0101_0110_0111_1000_1001_1010_1011_1100_1101_1110_1111;
  end
  
  initial $monitor("ciphertext=%b", ciphertext);
  
endmodule