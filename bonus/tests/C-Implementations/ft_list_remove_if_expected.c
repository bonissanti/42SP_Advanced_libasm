#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

#include "libasm_bonus_expected.h"

void ft_list_remove_if_expected(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
    t_list *current = *begin_list;
    t_list *previous = NULL;

    while (current != NULL)
    {
        if (((int (*)(void *, void *))cmp)(current->data, data_ref) == 0)
        {
            t_list *to_delete = current;
            current = current->next;

            if (previous == NULL)
                *begin_list = current;
            else
                previous->next = current;
            (*free_fct)(to_delete->data);
            (*free_fct)(to_delete);
        }
        else
        {
            previous = current;
            current = current->next;
        }
    }
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
}


void ft_list_print(t_list *begin_list)
{
    t_list *current = begin_list;

    while (current != NULL)
    {
        if (current->data != NULL)
            printf("node->data: %s\n", (char*)current->data);
        else
            printf("node->data: NULL\n");
        current = current->next;
    }
}

void    safe_free(void *data)
{
    free(data);
    data = NULL;
}