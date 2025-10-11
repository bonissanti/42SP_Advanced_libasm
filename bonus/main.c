#include <stdio.h>
#include "libasm_bonus.h"

extern void    ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);

int main(void)
{
    int size = 0;
    t_list *list = NULL;

    ft_list_push_front(&list, "Hello, World!");
    size = ft_list_size(list);
    printf("Size now is: %d\n", size);

    ft_list_push_front(&list, "Hello, World, from next!");
    size = ft_list_size(list);
    printf("Size now is: %d\n", size);
}