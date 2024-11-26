#include <stdio.h>
int main(){
    int x;
    int totalCount = 1;
    int evenTotal= 0;
    int oddTotal= 0;
    int oddSum = 0;
    int evenSum= 0;
    float oddAverage = 0;
    float evenAverage =0;
    int sum = 0;

    printf("Enter the %d", totalCount);
    printf("st value: ");
    scanf("%d", &x);
    while(x != 0){
        totalCount++;
        sum = 0;
        int copy = x;
        while(copy != 0){
            int n = copy % 10;
            sum += n;
            copy = copy / 10;
        }
        if(sum % 2 == 0){
            evenSum += x;
            evenTotal++;
        }
        else{
            oddSum += x;
            oddTotal++;
        }
        if(totalCount == 2 || totalCount == 3){
            if(totalCount == 2){
                printf("Enter the %d", totalCount);
                printf("nd value: ");
                // totalCount++;
            }
            else if(totalCount == 3){
                printf("Enter the %d", totalCount);
                printf("rd value: ");
                // totalCount++;
            }
        }
        else if(totalCount > 20){
            if(totalCount % 10 == 1){
                printf("Enter the %d", totalCount);
                printf("st value: ");
                // totalCount++;
            }
            else if(totalCount % 10 == 2){
                printf("Enter the %d", totalCount);
                printf("nd value: ");
                // totalCount++;
            }
            else if(totalCount % 10 == 3){
                printf("Enter the %d", totalCount);
                printf("rd value: ");
                // totalCount++;
            }
              else{
            printf("Enter the %d", totalCount);
            printf("th value: ");
            // totalCount++;
        }
        }
          else{
            printf("Enter the %d", totalCount);
            printf("th value: ");
            // totalCount++;
        }
      
        scanf("%d", &x);
    }
    oddAverage = (float)oddSum/ oddTotal;
    evenAverage = (float)evenSum /evenTotal;


    
    if(evenTotal > 0){
        printf("\nAverage of input values whose digits sum up to an even number: ");
        printf("%.02f", evenAverage);
    }
    if(oddTotal > 0){
        printf("\nAverage of input values whose digits sum up to an odd number: ");
        printf("%.02f", oddAverage);
    }
    if(evenTotal ==0 && oddTotal == 0){
        printf("\nThere is no average to compute.");
    }
   
    return 0;
}