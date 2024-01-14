void main() {
    float data[10] = {8.754, 7.956, 2.220, 6.345, -4.154, 1.25, -0.001, 9.854, 3.333, -5.12};
    float tmp;
    int len = 10;
    int i, j;

    for(i = len - 1; i >= 0; i--) {
        for(j = 0; j < i; j++) {
            if (data[j + 1] < data[j]) {
                tmp = data[j + 1];
                data[j + 1] = data[j];
                data[j] = tmp;
            }
        }
    }

    // Print
    for(i = 0; i < len; i++) {
        print(i);
        printf(": ");
        print(data[i]);
        printf("\n");
    }
}