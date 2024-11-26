#include <stdio.h>
#include <stdlib.h>

struct Node {
    int iValue;
    float fValue;
    struct Node *next;
};

int main() {

    struct Node *head = (struct Node*) malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;
	

	// Insert code here
	printf("The value of head is: %d", head);
	printf("\nThe address of head is: %p", &head);
    printf("\n The address of iValue: %p", &head->iValue);
    printf("\n The address of fValue: %p", &head->fValue);
    printf("\n The address of next: %p", &head->next);

	return 0;
}