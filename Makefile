NAME				= libasm.a
NASM 				= nasm
CC					= cc
NASM_FLAGS 			= -f elf64 -g
CFLAGS				= -Wall -Werror -Wextra -I./mandatory
TEST_CFLAGS			= $(CFLAGS) -g3 -lcriterion

SRC_DIR_MANDATORY 		= mandatory
SRC_DIR_BONUS			= bonus
TEST_DIR_MANDATORY		= mandatory/tests
TEST_OBJ_DIR_MANDATORY	= mandatory/test_obj
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
TEST_SRC_FILES_MANDATORY	= $(wildcard $(TEST_DIR_MANDATORY)/*.c)
TEST_OBJ_FILES_MANDATORY	= $(patsubst $(TEST_DIR_MANDATORY)/*.c, $(TEST_OBJ_DIR_MANDATORY)/%.o, $(TEST_SRC_FILES_MANDATORY))

ASM_OBJ_FILES_FOR_TESTS	= $(filter-out $(OBJ_DIR_MANDATORY)/main.o, $(ASM_OBJ_FILES_MANDATORY))
OBJ_FILES_MANDATORY 	= $(ASM_OBJ_FILES_MANDATORY) $(C_OBJ_FILES_MANDATORY)

all: $(NAME)

re: fclean all

$(NAME): $(OBJ_FILES_MANDATORY)
	@echo "Generating bin..."
	@ar rcs $@ $(OBJ_FILES_MANDATORY)

test: $(TEST_OBJ_FILES_MANDATORY) $(ASM_OBJ_FILES_FOR_TESTS)
	@echo "Generating bin test..."
	@$(CC) -o test_runner $(TEST_OBJ_FILES_MANDATORY) $(ASM_OBJ_FILES_FOR_TESTS) $(TEST_CFLAGS)
	@./test_runner

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.s
	@echo "Compiling assembly files..."
	@mkdir -p $(OBJ_DIR_MANDATORY)
	@$(NASM) $(NASM_FLAGS) $< -o $@

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_DIR_MANDATORY)/%.c
	@echo "Compiling C files..."
	@mkdir -p $(OBJ_DIR_MANDATORY)
	@$(CC) $(CFLAGS) -c $< -o $@

$(TEST_OBJ_DIR_MANDATORY)/%.o: $(TEST_DIR_MANDATORY)/%.c
	@mkdir -p $(TEST_OBJ_DIR_MANDATORY)
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@echo "Deleting files..."
	@rm -rf $(OBJ_DIR_MANDATORY) $(TEST_OBJ_DIR_MANDATORY)

fclean: clean
	@echo "Deleting bin files..."
	@rm -rf $(NAME) test_runner

.PHONY: all re clean fclean test