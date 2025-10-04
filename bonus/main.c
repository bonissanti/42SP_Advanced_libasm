#include <stdio.h>

extern int ft_atoi_base(const char *str, int base);

int main(void)
{
   int value = ft_atoi_base("0x12345a", 16);

   printf("%d\n", value);
   return 0;
}