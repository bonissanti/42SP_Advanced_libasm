#include <stdio.h>
#include <criterion/criterion.h>

extern char *ft_strcpy(const char *dest, const char *src);

Test(ft_strcpy, basic_strcpy)
{
    char dest[100]= "";
    char src[100] = "Hello, World!";

    ft_strcpy(dest, src);

    cr_expect_str_eq(dest, src);
}

Test(ft_strcpy, null_dest)
{
    char *dest = NULL;
    char src[100] = "Hello, World!";

    ft_strcpy(dest, src);

    cr_expect_null(dest);
}

Test(ft_strcpy, small_buffer)
{
    char dest[10] = "";
    char src[100] = "Hello, World!";
    char *result1 = ft_strcpy(dest, src);

    char dest2[10] = "";
    char src2[100] = "Hello, World!";
    char *result = strcpy(dest2, src2);

    cr_expect_str_eq(result1, result);
    printf("dest: %s\n", result1);
    printf("dest2: %s\n", result);
}

Test(ft_strcpy, null_src)
{
    char dest[100] = "initial";
    char *src = NULL;

    ft_strcpy(dest, src);

    cr_expect_null(src);
    cr_expect_str_eq(dest, "initial");
}