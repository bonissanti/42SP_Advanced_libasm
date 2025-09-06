NASM 				= nasm
CC					= cc
NASM_FLAGS 			= -f elf64
CFLAGS				= -Wall -Werror -Wextra

SRC_DIR_MANDATORY 	= mandatory
SRC_DIR_BONUS		= bonus
OBJ_DIR_MANDATORY	= mandatory/obj
OBJ_DIR_BONUS		= mandatory/bonus

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	FLAGS += -g -F dwarf
	CFLAGS += -g
endif

ASM_SRC_FILES_MANDATORY		= $(wildcard $(SRC_DIR_MANDATORY)/*.s)
ASM_OBJ_FILES_MANDATORY		= $(patsubst $(SRC_DIR_MANDATORY)/%.s, $(OBJ_DIR_MANDATORY)/%.o, $(ASM_SRC_FILES_MANDATORY))
C_SRC_FILES_MANDATORY	= $(wildcard $(SRC_DIR_MANDATORY)/*.c)
C_OBJ_FILES_MANDATORY	= $(patsubst $(SRC_DIR_MANDATORY)/%.c, $(OBJ_DIR_MANDATORY)/%.o, $(C_SRC_FILES_MANDATORY))
OBJ_FILES_MANDATORY 	= $(ASM_OBJ_FILES_MANDATORY) $(C_OBJ_FILES_MANDATORY)

all: program

re: fclean all

program: $(OBJ_FILES_MANDATORY)
	$(CC) -o program $(OBJ_FILES_MANDATORY)

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.s
	mkdir -p $(OBJ_DIR_MANDATORY)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.c
	mkdir -p $(OBJ_DIR_MANDATORY)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJ_DIR_MANDATORY)

fclean: clean
	rm -rf program

.PHONY: all re clean fclean