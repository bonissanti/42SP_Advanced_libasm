#ifndef LIBASM_BONUS_H
#define LIBASM_BONUS_H

typedef struct s_list
{
    void            *data;
    struct s_list   *next;
}                   t_list;


extern int  ft_atoi_base(const char *str, char *base);
extern void ft_list_sort(t_list **begin_list, int (*cmp)());
extern int  ft_list_size(t_list *begin_list);
extern void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
extern void ft_list_push_front(t_list **begin_list, void *data);

#endif //LIBASM_BONUS_H