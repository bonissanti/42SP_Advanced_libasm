#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
}

void ft_list_sort(t_list **begin_list, int (*cmp)())
{
    int len = ft_list_size(*begin_list);

    while (len > 0)
    {
        t_list *current = *begin_list;
        t_list *previous = *begin_list;

        while (current->next != NULL)
        {
            t_list *temp = current->next;
            if (((int (*)(void *, void *))cmp)(current->data, temp->data) > 0)
            {
                if (current == *begin_list)
                {
                    current->next = temp->next;
                    temp->next = current;
                    previous = temp;
                    *begin_list = previous;
                }
                else
                {
                    current->next = temp->next;
                    temp->next = current;
                    previous->next = temp;
                    previous = temp;
                }
                continue;
            }
            previous = current;
            current = current->next;
        }
        len--;
    }
}

void ft_list_print(t_list *begin_list)
{
    t_list *current = begin_list;

    while (current != NULL)
    {
        printf("node->data: %s\n", (char*)current->data);
        current = current->next;
    }
}

int main(void)
{
    t_list *head = NULL;
    ft_list_push_front(&head, "Aucker");
    ft_list_push_front(&head, "Sucker");
    ft_list_push_front(&head, "Dicker");

    ft_list_sort(&head, strcmp);
    ft_list_print(head);
}
