#include <criterion/criterion.h>
#include <string.h>

extern size_t ft_strlen(const char *str);

Test(ft_strlen, basic_string)
{
    cr_expect_eq(strlen("Hello, World!") == ft_strlen("Hello, World!"), true);
}

Test(ft_strlen, empty_string)
{
    cr_expect_eq(strlen("") == ft_strlen(""), true);
}

Test(ft_strlen, single_char)
{
    cr_expect_eq(strlen("A") == ft_strlen("A"), true);
}

Test(ft_strlen, null_string)
{
    cr_expect(ft_strlen(NULL) == 0);
}