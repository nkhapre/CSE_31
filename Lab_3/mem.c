#include <stdio.h>
#include <stdlib.h>


 int main() {
	int num;
	int *ptr;
	int **handle;

	num = 14;
	ptr = (int *) malloc(2 * sizeof(int));
	*ptr = num;
	handle = (int **) malloc(1 * sizeof(int *));
	*handle = ptr;

	// Insert code here

	printf("Address of num: %p", &num);
	printf("\nAddress of ptr: %p", &ptr);
	printf("\nAddress of handle: %p", &handle);
	return 0;
} 

