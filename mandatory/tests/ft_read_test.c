#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdio.h>
#include <unistd.h>
#include <criterion/criterion.h>

extern ssize_t ft_read(int fd, const void *buffer, size_t count);

Test(ft_read, basic_read)
{
    char buffer[200] = "";

    int fd = open("Makefile", O_RDONLY, 0644);
    if (fd < 0)
    {
        puts("Error: file not found");
        return ;
    }

    ssize_t bytes_read = ft_read(fd, buffer, sizeof(buffer));
    ssize_t bytes_expected = read(fd, buffer, sizeof(buffer));

    cr_assert_eq(bytes_read, bytes_expected);
}

Test(ft_read, invalid_fd)
{
    char buffer[200] = "";
    ssize_t bytes_expected = read(-1, buffer, sizeof(buffer));
    int errno_expected = errno;
    ssize_t bytes_read = ft_read(-1, buffer, sizeof(buffer));

    cr_expect_eq(bytes_read, bytes_expected);
    cr_expect_eq(errno, errno_expected); // EBADF bad file descriptor
}

Test(ft_read, null_buffer)
{
    char *buffer = NULL;
    ssize_t bytes_expected = read(0, buffer, 0);
    int errno_expected = errno;
    ssize_t bytes_read = ft_read(0, buffer, 0);

    cr_expect_eq(bytes_read, bytes_expected);
    cr_expect_eq(errno, errno_expected); // EBADMSG 11 - bad message
}