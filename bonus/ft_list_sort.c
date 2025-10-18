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

void swapList(t_list *a, t_list *b)
{
    void *temp = a->data;
    a->data = b->data;
    b->data = temp;
}

void ft_list_sort(t_list **begin_list, int (*cmp)())
{
    int swapped;
    const t_list *lastSorted = NULL;

    if (*begin_list == NULL)
        return;

    do
    {
        swapped = 0;
        t_list* current = *begin_list;

        while (current->next != lastSorted)
        {
            if (((int (*)(void *, void *))cmp)(current->data, current->next->data) > 0)
            {
                swapList(current, current->next);
                swapped = 1;
            }
            current = current->next;
        }
        lastSorted = current;
    }
    while (swapped);
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
