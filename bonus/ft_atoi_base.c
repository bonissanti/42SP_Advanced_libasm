#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

bool ft_is_digit(char c)
{
    return c >= '0' && c <= '9';
}

bool ft_is_hexdigit(char c)
{
    return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}

static int handle_hex(char c)
{
    if (c >= '0' && c <= '9')
        return c - '0';
    else if (c >= 'a' && c <= 'f')
        return c - 'a' + 10;
    else if (c >= 'A' && c <= 'F')
        return c - 'A' + 10;
    return 0;
}

int ft_atoi_base(const char *str, char *base)
{
    int i;
    int result;
    int signal;

    i = 0;
    result = 0;
    signal = 1;

    if (!base || strlen(base) <= 1)
        return 0;

    if (strcmp(base, "16") == 0)
    {
        if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
        {
            str += 2;
            while (str[i] && ft_is_hexdigit(str[i]))
                result = result * 16 + handle_hex(str[i++]);
        }
    }
    else if (strcmp(base, "10") == 0)
    {
        if (str[0] == '-')
        {
            signal = -1;
            str++;
        }
        while (str[i] && ft_is_digit(str[i]))
            result = result * 10 + str[i++] - '0';
    }
    else
        return 0;

    return signal * result;
}

int main(void)
{
    int expected = atoi("12345a");
    int result = ft_atoi_base("12345a", "16");
    printf("Result: %d\n", result);
    printf("Expected: %d\n", expected);
}