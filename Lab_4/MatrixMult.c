
#include <stdio.h>
#include <stdlib.h>

int** matMult(int **a, int **b, int size) {
	// (4) Implement your matrix multiplication here. 
	// You will need to create a new matrix to store the product.
	int **matC = (int**)malloc(size * sizeof(int*));
	for(int i = 0; i <size; i++){
		*(matC+i) = (int*)malloc(size * sizeof(int));
	}
	for(int i = 0; i < size; i++){
		for(int j =0; j < size; j++){
			*(*(matC + i) + j) = 0;
			for (int k = 0; k < size; k++) {
				*(*(matC + i) + j) += (*(*(a + i) + k)) * (*(*(b + k) + j));
			}
		}
	}
	return matC;


}

void printArray(int **arr, int n) {
	// (2) Implement your printArray function here
	for(int i = 0; i < n; i++){
		printf("{");
		for(int j =0; j < n; j++){
			
			printf("%d",*(*(arr+i)+j));
			printf(",");
		}
		printf("},\n");
	}
	printf("\n");
}

int main() {
	int n = 3;
	int **matA, **matB, **matC;
	matA = (int**)malloc(n * sizeof(int*));
	matB = (int**)malloc(n * sizeof(int*));
	matC = (int**)malloc(n * sizeof(int*));

	// (1) Define 2 (n x n) arrays (matrices). 
	for(int i = 0; i < n; i++){
		*(matA+i) = (int*)malloc(n * sizeof(int*));
		*(matB+i) = (int*)malloc(n * sizeof(int*));
		*(matC+i) = (int*)malloc(n * sizeof(int*));
	}

	//start of count
	int count = 1;
	for(int i =0; i < n; i++){
		for(int j = 0; j <n; j++){
			*(*(matA+i) +j) = count;
			count++;
		}
	}

	count = 1;
	for(int i =0; i < n; i++){
		for(int j = 0; j <n; j++){
			*(*(matB+i)+j) = count;
			count++;
			}
		}

	

	

	// (3) Call printArray to print out the 2 arrays here.
	printArray(matA, n);
	printArray(matB, n);

	
	// (5) Call matMult to multiply the 2 arrays here.
	matC = matMult(matA, matB, n);
	
	// (6) Call printArray to print out resulting array here.
	printArray(matC, n);

    return 0;
}