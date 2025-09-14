#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>


extern size_t ft_strlen(const char *str);
extern int ft_strcmp(const char *s1, const char *s2);
extern char *ft_strcpy(const char *dest, const char *src);
extern ssize_t ft_write(int fd, const void *buffer, size_t count);
extern ssize_t ft_read(int fd, const void *buffer, size_t count);

int main(void)
{
    {
        puts("######## FT_STRLEN TESTS ########");

        const char *msg = "Teste";
        size_t len = ft_strlen(msg);
        size_t expectedLen = strlen(msg);

        printf("Length of '%s': %zu\n", msg, len);
        printf("Length of real strlen '%s': %zu\n\n", msg, expectedLen);
    }
    {
        puts("######## FT_STRCMP TESTS ########");

        const char *msg1 = "Bruuh";
        const char *msg2 = "Bruh";

        int diff = ft_strcmp(msg1, msg2);
        int diffExpected = strcmp(msg1, msg2);

        printf("Result from ft_strcmp: %d\n", diff);
        printf("Result from original strcmp: %d\n\n", diffExpected);
    }

    {
        puts("######## FT_STRCPY TESTS ########");

        const char *src = "Alo";
        char dest[4];

        strcpy(dest, src);
        ft_strcpy(dest, src);
        printf("Result from strcpy - Dest: %s, Src: %s\n", dest, src);
        printf("Result from ft_strcpy - Dest: %s, Src: %s\n\n", dest, src);
    }

    {
        puts("######## FT_WRITE TESTS ########");

        const char *msg = "Teste";

        printf("Original write printing: \n");
        write(1, msg, strlen(msg));
        write(1, "\n", 1);

        printf("ft_write printing: \n");
        ft_write(1, msg, ft_strlen(msg));
        ft_write(1, "\n", 1);

        const char *msg2 = NULL;

        // printf("Original write printing: \n");
        // write(1, msg, strlen(msg));
        // write(1, "\n", 1);

        printf("ft_write printing: \n");
        ssize_t value = ft_write(1, msg2, 1);
        ft_write(1, "\n", 1);

        printf("ft_write returned value: %ld\n", value);
        printf("Errno from ft_write is: %d\n\n", errno);
    }
    {
        puts("######## FT_READ TESTS ########");

        char str[200] = "";

        int fd = open("Makefile", O_RDONLY, 0644);
        if (fd == -1)
        {
            puts("Error: file not found");
            return 1;
        }

        ssize_t bytes_read = read(fd, &str, sizeof(str));
        if (bytes_read < 0)
        {
            puts("Error: failed to read file");
            return 1;
        }

        printf("Bytes read from original read() function: %ld\n", bytes_read);

        ssize_t bytes_read2 = ft_read(fd, str, sizeof(str));
        printf("Bytes read from ft_read() function: %ld\n", bytes_read2);
    }
    return 0;
}