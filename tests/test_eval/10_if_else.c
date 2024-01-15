int main() {
  int a;
  int b;
  int c;
  a = -15;
  b = 5;
  c = -2 * a;
  if ((a == b) || (a > b)) {
    b = b - 5;
    c = b - a;
    c = c - 2;
  } else {
    b = b + 5;
    c = b + a;
    c = c + 2; 
  }
  print(c);
}
/* -3 */

