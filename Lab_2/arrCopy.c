#include<stdio.h>
#include<string.h>
#include<stdlib.h>

int size; // Variable to record size of original array arr
int evenCount = 0, oddCount = 0; // Variables to record sizes of new arrays arr_even and arr_odd
int *arr; // Dynamically allocated original array with #elements = size
int *arr_even;  // Dynamically allocated array with #elements = #even elements in arr (evenCount)
int *arr_odd;   // Dynamically allocated array with #elements = #odd elements in arr (oddCount)
char *str1 = "Original array's contents: ";
char *str2 = "Contents of new array containing even elements from original: ";
char *str3 = "Contents of new array containing odd elements from original: ";

/*
 * DO NOT change the definition of the printArr function when it comes to 
 * adding/removing/modifying the function parameters, or changing its return 
 * type. 
 */
void printArr(int *a, int size, char *prompt){
	// Your code here
    printf("%s", prompt);
    if(size ==0){
        printf("empty");
    }
    else{
    for(int i =0; i < size; i++){
        if(i ==size){
            printf("%d", *(a+i));
            printf("\n");
        }
        else{
            printf("%d ", *(a+i) );
        }
    }
    }
    printf("\n");
}

/* 
 * DO NOT change the definition of the arrCopy function when it comes to 
 * adding/removing/modifying the function parameters, or changing its return 
 * type. 
 */
void arrCopy(){
	// Your code here
    
    int* p = arr_even;
    int* p1 = arr_odd;
    int* p2= arr;

    
    for(int i = 0; i < size; i++){
        if(*p2 % 2 == 0){
            *p = *p2;
            p++;
        }
        else{
            *p1 = *p2;
            p1++;
        }
        p2++;
    }
}

int main(){
    int i;
    printf("Enter the size of array you wish to create: ");
    scanf("%d", &size);

    // Dynamically allocate memory for arr (of appropriate size)
    // Your code here
    arr = (int*) malloc(size * sizeof(int));

    int *p = arr;
    // Ask user to input content of arr and compute evenCount and oddCount
	// Your code here
    for(int i = 1; i < size+1; i++){
        int input = 0;
        
        printf("Enter array element #%d: ", i);
        scanf("%d", &input);
        *p = input;

        if(input % 2 == 0){
            evenCount++;
        }
        else{
            oddCount++;
        }
        p++;
    }
    printf("\n");


    // Dynamically allocate memory for arr_even and arr_odd (of appropriate size)
    // Your code here 
    arr_even = (int*) malloc(evenCount * sizeof(int));
    arr_odd = (int*) malloc(oddCount * sizeof(int));   
    
/*************** YOU MUST NOT MAKE CHANGES BEYOND THIS LINE! ***********/
	
	// Print original array
    printArr(arr, size, str1);

	/// Copy even elements of arr into arr_even and odd elements into arr_odd
    arrCopy();

    // Print new array containing even elements from arr
    printArr(arr_even, evenCount, str2);

    // Print new array containing odd elements from arr
    printArr(arr_odd, oddCount, str3);

    printf("\n");

    return 0;
}