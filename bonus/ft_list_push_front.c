#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

void    ft_list_push_front(t_list **begin_list, void *data);
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

// int main(void)
// {
//     t_list *list = NULL;
//
//     ft_list_push_front(&list, "Hello, World!");
//     ft_list_push_front(&list, "Hello, World, from next!");
//
//     printf("%s\n", (char*)list->data);
//     printf("%s\n", (char*)list->next->data);
// }
