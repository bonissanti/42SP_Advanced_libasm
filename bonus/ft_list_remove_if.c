#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "libasm_bonus.h"

void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
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

int main(void)
{
    t_list *head = NULL;

    ft_list_push_front(&head, strdup("Sucker"));
    ft_list_push_front(&head, strdup("Aucker"));
    ft_list_push_front(&head, strdup("Sucker"));
    ft_list_push_front(&head, strdup("Dicker"));
    ft_list_push_front(&head, strdup("Sucker"));
    ft_list_push_front(&head, strdup("Fucker"));

    ft_list_remove_if(&head, "Sucker", strcmp, safe_free);
    ft_list_print(head);

}