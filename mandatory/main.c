#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

extern char *ft_strcpy(const char *dest, const char *src);
extern size_t ft_strlen(const char *str);
extern int ft_strcmp(const char *s1, const char *s2);
extern ssize_t ft_write(int fd, const void *buffer, size_t count);
extern ssize_t ft_read(int fd, const void *buffer, size_t count);
extern char *ft_strdup(const char *src);

int main(void)
{
    {
        puts("######## FT_STRCPY TESTS ########");
        char dest2[20] = "";
        char src2[100] = "Hello, World!";
        char *result = strcpy(dest2, src2);

        char dest[20] = "";
        char src[100] = "Hello, World!";
        char *result1 = ft_strcpy(dest, src);

        printf("ft_strcpy: %s\n", result1);
        printf("strcpy: %s\n", result);
    }
    return 0;
}