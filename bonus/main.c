#include <stdio.h>
#include <string.h>

#include "libasm_bonus.h"

extern void     ft_list_push_front(t_list **begin_list, void *data);
extern void     ft_list_sort(t_list **begin_list, int (*cmp)());
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

int main(void)
{
    t_list *head = NULL;
    ft_list_push_front(&head, "Aucker");
    ft_list_push_front(&head, "Sucker");
    ft_list_push_front(&head, "Dicker");
    ft_list_push_front(&head, "Fucker");

    printf("ANTES do sort:\n");
    ft_list_print(head);

    ft_list_sort(&head, ft_strcmp);

    printf("\nDEPOIS do sort:\n");
    ft_list_print(head);
}
