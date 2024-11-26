#include <stdio.h>
#include <cstdlib>

// Movement in 8 directions
int dx[8] = { -1, 1, 0, 0, 1, 1, -1, -1};
int dy[8] = {0, 0, -1, 1, 1, -1, 1, -1};

int searchPuzzle(char ** arr, int r, int c, int n, char * str, int si, int m, int *** a) {
    if (si >= m) {
        // If we have got all the characters of the str, that means we got one of the paths
        return 1;
    }
    
    // If our coordinates go out of bound or the character here doesn't match with the str character, then it is a wrong move, just return
    if (r < 0 || c < 0 || r >= n || c >= n || arr[r][c] != str[si])
        return 0;
    
    int l = 0;
    
    // Mark this one as a valid option and try to explore further
    int id = a[r][c][0];
    a[r][c][id + 1] = (si + 1);
    a[r][c][0] = id + 1;
    
    for (int i = 0; i < 8; i++) {
        l = l | searchPuzzle(arr, r + dx[i], c + dy[i], n, str, si + 1, m, a);
    }
    
    if (l == 0) {
        // If there is no solution using this path, then undo the process
        int id = a[r][c][0];
        a[r][c][id] = -1;
        a[r][c][0]--;
    }
    
    return l;
}

void searchPuzzle_utl(char ** arr, int n, char * str, int m) {
    // This will store the path in the array
    int*** a = new int**[n];
    
    for (int i = 0; i < n; i++) {
        a[i] = new int*[n];
        for (int j = 0; j < n; j++) {
            a[i][j] = new int[100];
        }
    }
    
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < 100; k++) {
                a[i][j][k] = -1;
            }
            a[i][j][0] = 0;
        }
    }
    
    int l = 0;
    
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (str[0] == arr[i][j]) {
                // Start search only when the first character matches with the first character of word
                l = l | searchPuzzle(arr, i, j, n, str, 0, m, a);
            }
        }
    }
    
    if (l) {
        printf("Word found!\n");
        // Printing the path
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 1; k < 100; k++) {
                    if (k == 1 && a[i][j][k] == -1) {
                        printf("0");
                        break;
                    }
                    if (a[i][j][k] == -1)
                        break;
                    printf("%d", a[i][j][k]);
                }
                printf(" ");
            }
            printf("\n");
        }
    } else {
        printf("Word not found!\n");
    }
}

int main() {
    int n;
    scanf("%d", &n);
    char** arr = (char**)malloc(n * sizeof(char*));
    
    for (int i = 0; i < n; i++)
        arr[i] = (char*)malloc(n * sizeof(char*));
    
    for (int i = 0; i < n; i++) {
        scanf("%s", arr[i]);
    }
    
    // Printing the block
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%c ", arr[i][j]);
            
            // Converting all the characters to lowercase
            if (arr[i][j] >= 'A' && arr[i][j] <= 'Z') {
                arr[i][j] += 32;
            }
        }
        printf("\n");
    }
    
    // Convert all the characters in the grid to lowercase
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%c ", arr[i][j]);
            
            // Converting all the characters to lowercase
            if (arr[i][j] >= 'A' && arr[i][j] <= 'Z') {
                arr[i][j] += 32;
            }
        }
        printf("\n");
    }
    
    // Input the word that has to be searched
    int m;
    scanf("%d", &m);
    char *str;
    str = (char *)malloc(m * sizeof(char));
    
    // Printing the word
    scanf("%s", str);
    
    // Converting all the characters in the word to lowercase
    for (int i = 0; i < m; i++) {
        if (str[i] >= 'A' && str[i] <= 'Z') {
            str[i] += 32;
        }
    }
    
    printf(str);
    printf("\n");
    
    // Utility function that initiates search
    searchPuzzle_utl(arr, n, str, m);
}
