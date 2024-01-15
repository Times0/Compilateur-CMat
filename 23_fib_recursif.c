int Fibonacci(int n)
{
	if (n < 2) {
		return n;
	}
	return Fibonacci(n - 2) + Fibonacci(n - 1);
}

int main() {

	int valeur = 10;
	
	printf(Fibonacci(valeur)); // = 55
	
	return 0;

}
