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
        puts("######## FT_STRDUP TESTS ########");

        const char *src = "Teste a ser duplicado";
        char *dest = "";

        dest = ft_strdup(src);

        printf("Src is: %s and dest is: %s", src, dest);
    }
    return 0;
}