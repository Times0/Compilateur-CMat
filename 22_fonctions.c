int f(int x) {
  print(x);
  return x;
}

float g(float y) {
  print(y);
  return y;
}

int main() {
  int a = g(42);
  print(a);
  float b = f(42.42);
  print(b);
  return 0;
}
