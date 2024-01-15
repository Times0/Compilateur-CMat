int main() {
  matrix A[3][4] = {{1.0,  2.0,  3.0,  4.0},
                    {5.0,  6.0,  7.0,  8.0},
                    {9.0, 10.0, 11.0, 12.0}};
  matrix AX1[2][4];
  matrix AX2[2][2];
  matrix AX3[2][3];
  matrix AX4[2][3];
  matrix AX5[1][8];

  AX1 = A[0..1][*];
  AX2 = A[0..1][2..3];
  AX3 = A[0;2][0..1;3];
  AX4 = A[0;0][0..1;1];
  AX5 = A[0][*;*];
  
  printmat(AX1);
  printmat(AX2);
  printmat(AX3);
  printmat(AX4);
  printmat(AX5);
}
/*
AX1 = 1 2 3 4
      5 6 7 8
      
AX2 = 3 4
      7 8
      
AX3 = 1  2  4
      9 10 12
      
AX4 = 1 2 2
      1 2 2
      
AX5 = 1 2 3 4 1 2 3 4                  
*/
