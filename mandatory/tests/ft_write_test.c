#include <unistd.h>
#include <criterion/criterion.h>

extern ssize_t ft_write(int fd, const void *buffer, size_t count);

Test(ft_write, basic_write)
{
    int pipefd[2];
    pipe(pipefd);

    const char *msg = "Hello, World!";
    ssize_t result = ft_write(pipefd[1], msg, strlen(msg));

    cr_expect((size_t)result == strlen(msg));

    close(pipefd[0]);
    close(pipefd[1]);
}

Test(ft_write, invalid_fd)
{
    const char *msg = "Hello, World!";
    ssize_t result = ft_write(-1, msg, strlen(msg));

    cr_expect(result == -1);
}

//TODO: fix this behavior
Test(ft_write, null_string)
{
    const char *msg = NULL;
    ssize_t result = ft_write(1, msg, strlen(msg));

    cr_expect(result == 0);
}