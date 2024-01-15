int main() {
  matrix A[2][3] = {{11.0, 12.0, 13.0}, {21.0, 22.0, 23.0}};
  matrix TA[3][2];
  TA = ~A;
  printmat(TA);
}
