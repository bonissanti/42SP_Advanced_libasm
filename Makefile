NASM 				= nasm
FLAGS 				= -f elf64

SRC_DIR_MANDATORY 	= mandatory
SRC_DIR_BONUS		= bonus
OBJ_MANDATORY		= mandatory/obj
OBJ_BONUS			= mandatory/bonus

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	FLAGS += -g
	@echo flag '-g' added
endif

SRC_FILES_MANDATORY		= $(wildcard $(SRC_DIR_MANDATORY)/*.s)
OBJ_FILES_MANDATORY		= $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(SRC_FILES_MANDATORY))

all: program

program: $(OBJ_FILES_MANDATORY)

program: $(OBJ_FILES_MANDATORY)
	$(NASM) -o program $(OBJ_FILES_MANDATORY)

$(OBJ_DIR_MANDATORY)/%.o: $(SRC_FILES_MANDATORY)/%.s
	mkdir -p $(OBJ_DIR_MANDATORY)
	$(NASM) $(FLAGS) $< -o $@

clean:
	rm -rf program $(OBJ_DIR_MANDATORY)

fclean: clean
	rm -rf program

.PHONY: all program clean fclean