#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

#include "libasm_bonus.h"

int ft_list_size(t_list *begin_list)
{
    int count;

    count = 0;
    t_list *current = begin_list;
    while (current != NULL)
    {
        count++;
        current = current->next;
    }
    return count;
}

void    ft_list_push_front(t_list **begin_list, void *data)
{
    if (*begin_list == NULL)
    {
        t_list *new_node = malloc(sizeof(t_list));
        new_node->data = data;
        new_node->next = NULL;
        *begin_list = new_node;
    }
    else
    {
        t_list *new_node = malloc(sizeof(t_list));
        new_node->data = data;
        new_node->next = *begin_list;
        *begin_list = new_node;
    }
};

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