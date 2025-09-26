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

Test(ft_strcpy, buffer_test)
{
    char dest[800] = "";
    const char *src = "Contrary to popular belief, Lorem Ipsum is not simply random text. "
                      "It has roots in a piece of classical Latin literature from 45 BC, "
                      "making it over 2000 years old. Richard McClintock, a Latin professor at "
                      "Hampden-Sydney College in Virginia, looked up one of the more obscure "
                      "Latin words, consectetur, from a Lorem Ipsum passage, and going through "
                      "the cites of the word in classical literature, discovered the undoubtable source. "
                      "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" "
                      "(The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise "
                      "on the theory of ethics, very popular during the Renaissance. "
                      "The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", "
                      "comes from a line in section 1.10.32.";

    ft_strcpy(dest, src);

    char dest2[800] = "";
    const char *src2 = "Contrary to popular belief, Lorem Ipsum is not simply random text. "
                      "It has roots in a piece of classical Latin literature from 45 BC, "
                      "making it over 2000 years old. Richard McClintock, a Latin professor at "
                      "Hampden-Sydney College in Virginia, looked up one of the more obscure "
                      "Latin words, consectetur, from a Lorem Ipsum passage, and going through "
                      "the cites of the word in classical literature, discovered the undoubtable source. "
                      "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" "
                      "(The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise "
                      "on the theory of ethics, very popular during the Renaissance. "
                      "The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", "
                      "comes from a line in section 1.10.32.";

    strcpy(dest2, src2);
    cr_expect_str_eq(dest, dest2);
}

Test(ft_strcpy, null_src)
{
    char dest[100] = "initial";
    char *src = NULL;

    ft_strcpy(dest, src);

    cr_expect_null(src);
    cr_expect_str_eq(dest, "initial");
}