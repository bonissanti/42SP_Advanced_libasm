#ifndef LIBASM_H
#define LIBASM_H

#include <stdio.h>
#include <string.h>

extern char *ft_strcpy(const char *dest, const char *src);
extern size_t ft_strlen(const char *str);
extern int ft_strcmp(const char *s1, const char *s2);
extern ssize_t ft_write(int fd, const void *buffer, size_t count);
extern ssize_t ft_read(int fd, const void *buffer, size_t count);
extern char *ft_strdup(const char *src);

#endif //LIBASM_H