#include <stdio.h>
#include <string.h>

extern size_t ft_strlen(const char *str);
extern int ft_strcmp(const char *s1, const char *s2);
extern char *ft_strcpy(const char *dest, const char *src);

int main(void)
{
    {
        const char *msg = "Teste";
        size_t len = ft_strlen(msg);
        size_t expectedLen = strlen(msg);

        printf("Length of '%s': %zu\n", msg, len);
        printf("Length of real strlen '%s': %zu\n\n", msg, expectedLen);
    }
    {
        const char *msg1 = "Bruuh";
        const char *msg2 = "Bruh";

        int diff = ft_strcmp(msg1, msg2);
        int diffExpected = strcmp(msg1, msg2);

        printf("Result from ft_strcmp: %d\n", diff);
        printf("Result from original strcmp: %d\n\n", diffExpected);
    }

    {
        const char *src = "Alo";
        const char *dest = NULL;

        // strcpy(dest, src);
        ft_strcpy(dest, src);
        // printf("Result from strcpy - Dest: %s, Src: %s\n", dest, src);
        printf("Result from ft_strcpy - Dest: %s, Src: %s\n", dest, src);
    }
    return 0;
}