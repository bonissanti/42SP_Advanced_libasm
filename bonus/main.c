#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "libasm_bonus.h"

extern void     ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *)); // in older versions, change to int(*cmp)()
extern void     ft_list_push_front(t_list **begin_list, void *data);
extern int      ft_strcmp(const char *s1, const char *s2);


void ft_list_print(t_list *begin_list)
{
    t_list *current = begin_list;

    while (current != NULL)
    {
        printf("node->data: %s\n", (char*)current->data);
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

    ft_list_remove_if(&head, "Sucker", (int (*)(void *, void *))ft_strcmp, (void (*)(void *))safe_free);
    ft_list_print(head);
}
