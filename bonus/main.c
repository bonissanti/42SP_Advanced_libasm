#include <stdio.h>

extern int ft_atoi_base(const char *str, int base);

int main(void)
{
   int value = ft_atoi_base("-48934", 10);

   printf("%d\n", value);
   return 0;
}