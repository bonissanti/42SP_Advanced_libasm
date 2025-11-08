NAME				= libasm.a
NAME_BONUS			= libasm_bonus.a
BONUS_EXEC			= bonus_debug
NASM 				= nasm
CC					= cc
NASM_FLAGS 			= -f elf64 -g
CFLAGS				= -Wall -Werror -Wextra -I./mandatory
TEST_CFLAGS			= $(CFLAGS) -g3 -lcriterion

SRC_DIR_MANDATORY 		= mandatory
SRC_DIR_BONUS			= bonus
TEST_DIR_MANDATORY		= mandatory/tests
TEST_OBJ_DIR_MANDATORY	= mandatory/test_obj
TEST_DIR_BONUS			= bonus/tests
TEST_OBJ_DIR_BONUS		= bonus/test_obj
OBJ_DIR_MANDATORY		= mandatory/obj
OBJ_DIR_BONUS			= bonus/obj

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	FLAGS += -g -F dwarf
	CFLAGS += -g
endif

ASM_SRC_FILES_MANDATORY		= $(wildcard $(SRC_DIR_MANDATORY)/*.s)
ASM_OBJ_FILES_MANDATORY		= $(patsubst $(SRC_DIR_MANDATORY)/%.s, $(OBJ_DIR_MANDATORY)/%.o, $(ASM_SRC_FILES_MANDATORY))
C_SRC_FILES_MANDATORY		= $(wildcard $(SRC_DIR_MANDATORY)/*.c)
C_OBJ_FILES_MANDATORY		= $(patsubst $(SRC_DIR_MANDATORY)/%.c, $(OBJ_DIR_MANDATORY)/%.o, $(C_SRC_FILES_MANDATORY))
TEST_OBJ_FILES_MANDATORY	= $(patsubst $(TEST_DIR_MANDATORY)/*.c, $(TEST_OBJ_DIR_MANDATORY)/%.o, $(TEST_SRC_FILES_MANDATORY))
TEST_OBJ_FILES_BONUS		= $(patsubst $(TEST_DIR_BONUS)/*.c, $(TEST_OBJ_DIR_BONUS)/%.o, $(TEST_SRC_FILES_BONUS))

OBJ_FILES_MANDATORY 		= $(ASM_OBJ_FILES_MANDATORY) $(C_OBJ_FILES_MANDATORY)

ASM_SRC_FILES_BONUS			= $(wildcard $(SRC_DIR_BONUS)/*.s)
ASM_OBJ_FILES_BONUS			= $(patsubst $(SRC_DIR_BONUS)/%.s, $(OBJ_DIR_BONUS)/%.o, $(ASM_SRC_FILES_BONUS))
C_SRC_FILES_BONUS 			= $(wildcard $(SRC_DIR_BONUS)/*.c)
C_OBJ_FILES_BONUS			= $(patsubst $(SRC_DIR_BONUS)/%.c, $(OBJ_DIR_BONUS)/%.o, $(C_SRC_FILES_BONUS))

ASM_OBJ_FILES_FOR_TESTS				= $(filter-out $(OBJ_DIR_MANDATORY)/main.o, $(ASM_OBJ_FILES_MANDATORY))
ASM_OBJ_BONUS_FILES_FOR_TESTS		= $(filter-out $(OBJ_DIR_BONUS)/main.o, $(ASM_OBJ_FILES_BONUS))
OBJ_FILES_BONUS						= $(ASM_OBJ_FILES_BONUS) $(C_OBJ_FILES_BONUS)

all: $(NAME)

re: fclean all

$(NAME): $(OBJ_FILES_MANDATORY)
	@echo "Generating bin..."
	@ar rcs $@ $(OBJ_FILES_MANDATORY)

bonus: $(OBJ_FILES_BONUS)
	@echo "Generating bin for bonus..."
	@ar rcs $(NAME_BONUS) $(OBJ_FILES_BONUS)

# TODO: delete when finish
bonus_debug: bonus
	@echo "Generating debug executable for bonus..."
	@$(CC) -g3 -o $(BONUS_EXEC) $(SRC_DIR_BONUS)/main.c -L. -l:$(NAME_BONUS) -I./$(SRC_DIR_BONUS)

test: $(TEST_OBJ_FILES_MANDATORY) $(ASM_OBJ_FILES_FOR_TESTS)
	@echo "Generating bin test..."
	@$(CC) -o test_runner $(TEST_OBJ_FILES_MANDATORY) $(ASM_OBJ_FILES_FOR_TESTS) $(TEST_CFLAGS)
	@./test_runner

test_bonus: $(TEST_OBJ_FILES_BONUS) $(ASM_OBJ_BONUS_FILES_FOR_TESTS)
	@echo "Generating bin test for bonus..."
	@$(CC) -o test_bonus_runner $(TEST_OBJ_FILES_BONUS) $(ASM_OBJ_BONUS_FILES_FOR_TESTS) $(TEST_CFLAGS)
	@./test_bonus_runner

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.s
	@echo "Compiling assembly files..."
	@mkdir -p $(OBJ_DIR_MANDATORY)
	@$(NASM) $(NASM_FLAGS) $< -o $@

$(OBJ_DIR_BONUS)/%.o: $(SRC_DIR_BONUS)/%.s
	@echo "Compiling assembly bonus files..."
	@mkdir -p $(OBJ_DIR_BONUS)
	@$(NASM) $(NASM_FLAGS) $< -o $@

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.c
	@echo "Compiling C files..."
	@mkdir -p $(OBJ_DIR_MANDATORY)
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR_BONUS)/%.o: $(SRC_DIR_BONUS)/%.c
	@echo "Compiling C bonus files..."
	@mkdir -p $(OBJ_DIR_BONUS)
	@$(CC) $(CFLAGS) -c $< -o $@


$(TEST_OBJ_DIR_MANDATORY)/%.o: $(TEST_DIR_MANDATORY)/%.c
	@mkdir -p $(TEST_OBJ_DIR_MANDATORY)
	@$(CC) $(CFLAGS) -c $< -o $@

$(TEST_OBJ_DIR_BONUS)/%.o: $(TEST_DIR_BONUS)/%.c
	@mkdir -p $(TEST_OBJ_DIR_BONUS)
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@echo "Deleting files..."
	@rm -rf $(OBJ_DIR_MANDATORY) $(TEST_OBJ_DIR_MANDATORY) $(OBJ_DIR_BONUS) $(TEST_OBJ_DIR_BONUS)

fclean: clean
	@echo "Deleting bin files..."
	@rm -rf $(NAME) $(NAME_BONUS) $(BONUS_EXEC) test_runner test_bonus_runner

.PHONY: all re clean fclean test bonus bonus_debug