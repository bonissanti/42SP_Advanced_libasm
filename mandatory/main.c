#include <stdio.h>
#include <string.h>

extern size_t ft_strlen(const char *str);

int main(void)
{
    const char *msg = NULL;
    size_t len = ft_strlen(msg);
    size_t expectedLen = strlen(msg);

    printf("Length of '%s': %zu\n", msg, len);
    printf("Length of real strlen '%s': %zu\n", msg, expectedLen);

    return 0;
}