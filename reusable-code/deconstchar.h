#include <stdio.h>

char* deconstchar(const char* s) {
    int i;
    char* res;
    for (i = 0; s[i] != '\0'; i++) {
        res[i] = s[i];
    }
    res[i] = '\0';
    return res;
}