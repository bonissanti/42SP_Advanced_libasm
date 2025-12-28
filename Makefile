BIN						:=	test
CC						:=	gcc
CFLAGS					:= 	-Wall -Werror -Wextra
SRC_DIR_MANDATORY		:=	mandatory
OBJ_DIR_MANDATORY		:=	mandatory/obj
BONUS_DIR_MANDATORY		:=
INC_DIR					:=	include

DEBUG	?=	0
ifeq	($(DEBUG), 1)
	CFLAGS += -g3
endif

SRCS_FILES_MANDATORY	:=	$(wildcard $(SRC_DIR_MANDATORY)/*.c) # $(filter-out $(SRC_DIR_MANDATORY)/main.c, $(wildcard $(SRC_DIR_MANDATORY)/*.c))
OBJS_FILES_MANDATORY	:=	$(patsubst $(SRC_DIR_MANDATORY)/%.c, $(OBJ_DIR_MANDATORY)/%.o, $(SRCS_FILES_MANDATORY))

all:	program

program: $(OBJS_FILES_MANDATORY)
	$(CC) $(CFLAGS) -o $(BIN) $(OBJS_FILES_MANDATORY)

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.c
	mkdir -p $(OBJ_DIR_MANDATORY)
	$(CC) -I$(INC_DIR) -c $< -o $@

re: clean all

clean:
	rm -rf $(OBJ_DIR_MANDATORY)

fclean: clean
	rm -rf $(BIN)

.PHONY: all program re clean fclean