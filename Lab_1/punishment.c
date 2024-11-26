#include <stdio.h>
int main(){
    int x, y;
        printf("Enter the repetition count for the punishment phrase: ");
        scanf("%d", &x);
        while(x < 1){
            printf("You entered an invalid value for the repetition count! Please re-enter: ");
            scanf("%d", &x);
            }
        printf("\nEnter the line where you want to insert the typo: ");
        scanf("%d", &y);
        while(y <1){
            printf("You entered an invalid value for the typo placement! Please re-enter: ");
            scanf("%d", &y);
        }

    printf("\n");
    
    for(int i =1; i <= x; i++){
        if(i ==y){
            printf("Cading wiht is C avesone!\n");
        }
        else{
            printf("Coding with C is awesome!\n");
        }
    }
        
    


    return 0;
}