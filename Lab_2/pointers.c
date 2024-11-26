#include <stdio.h>
int main() {
    int x = 0;
    int y=0;
    int *px, *py;

    px = &x;
    py = &y;


    int arr[10];


    printf("variable x is %d, y is %d, arr[0] is %d", x, y, arr[0] );

    printf("\nmemory location of x is %p, memory location of y is %p", &x, &y);

    printf("\nmemory location of px is %p, memory location of py is %p", px, py);


    for(int i = 0; i < 10; i++){
        printf("\nvalue is %d", *(arr+i));

    }

    printf("\nadress of arr[0] is %p", arr);
    printf("\nadress of arr[0] is %p", &arr[0]);

    printf("\naddress of arr: %p", &arr);
    return 0;


}