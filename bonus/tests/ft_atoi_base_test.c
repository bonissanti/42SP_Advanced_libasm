#include "../libasm_bonus.h"
#include <criterion/criterion.h>
#include "C-Implementations/ft_atoi_base_expected.c"

Test(ft_atoi_base, basic_base10)
{
    char str[] = "12345";
    int expected = ft_atoi_base_expected(str, "10");;
    int result = ft_atoi_base(str, "10");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, basic_base16)
{
    char str[] = "0x12345abc";
    int expected = ft_atoi_base_expected(str, "16");
    int result = ft_atoi_base(str, "16");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, negative_base10_should_works)
{
    char str[] = "-0123456789";
    int expected = ft_atoi_base_expected(str, "10");
    int result = ft_atoi_base(str, "10");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, negative_base16_should_return_0)
{
    char str[] = "-0X123456789";
    int expected = 0;
    int result = ft_atoi_base(str, "16");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, invalid_hexadecimal_should_return_0)
{
    char str[] = "1Xabc1234";
    int expected = 0;
    int result = ft_atoi_base(str, "16");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, invalid_chars_should_return_0)
{
    char str[] = "abcdef";
    int expected = 0;
    int result = ft_atoi_base(str, "10");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, half_valid_numbers_should_works_partially)
{
    char str[] = "12345abc67890";
    int expected = ft_atoi_base_expected(str, "10");
    int result = ft_atoi_base(str, "10");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, str_is_null_should_return_0)
{
    char *str = NULL;
    int expected = 0;
    int result = ft_atoi_base(str, "10");

    cr_assert_eq(result, expected);
}

Test(ft_atoi_base, base_is_null_should_return_0)
{
    char str[] = "12345abc67890";

    int expected = 0;
    int result = ft_atoi_base(str, NULL);

    cr_assert_eq(result, expected);
}
