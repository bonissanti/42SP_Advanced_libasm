#include <criterion/criterion.h>

extern int ft_strcmp(const char *s1, const char *s2);

Test(ft_strcmp, basic_wrong_cmp_1)
{
    const char *msg1 = "Bruuh";
    const char *msg2 = "Bruuuuuuh";

    cr_expect_eq(strcmp(msg1, msg2) == ft_strcmp(msg1, msg2), true);
}

Test(ft_strcmp, basic_cmp)
{
    const char *msg1 = "Test";
    const char *msg2 = "Test";

    cr_expect_eq(strcmp(msg1, msg2) == ft_strcmp(msg1, msg2), true);
}

Test(ft_strcmp, basic_wrong_cmp_2)
{
    const char *msg = "ABCDE";
    const char *msg2 = "ABCD";

    cr_expect_eq(strcmp(msg, msg2) == ft_strcmp(msg, msg2), true);
}