#include <criterion/criterion.h>

extern char *ft_strdup(const char *src);

Test(ft_strdup, strdup_test)
{
    char *dest = "";
    const char *src = "Hello, World!";

    dest = ft_strdup(src);

    cr_expect_str_eq(dest, src);
    free(dest);
}