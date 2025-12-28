#include <stdlib.h>
#include "libasm_bonus_expected.h"

int ft_list_size_expected(t_list *begin_list)
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