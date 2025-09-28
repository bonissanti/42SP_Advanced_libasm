#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

BINARY_NAME="program"
OBJ_MANDATORY_DIR="mandatory/obj"
OBJ_MANDATORY_DIR="bonus/obj"
TEST_BINARY="test_runner"

print_status()
{
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓ $2${RESET}"
        return 0
    else
        echo -e "${RED}✗ $2${RESET}"
        return 1
    fi
}

print_test()
{
    echo -e "${YELLOW}}🧪 Testing: $1${RESET}"
}

echo -e "${YELLOW} === Cleaning Workspace ===${RESET}"
make fclean > /dev/null 2>&1

#TEST 1: make - initial build
print_test "make (initial build)"
make > make_output.log 2>&1
make_exit_code=$?

if [ $make_exit_code -ne 0 ]; then
    echo -e "${RED}Make command failed with exit code: $make_exit_code${RESET}"
    cat make_output.log
    exit 1
fi

# Verify if binary exists
if [ -f "$BINARY_NAME" ]; then
    print_status 0 "Binary '$BINARY_NAME' created successfully"
else
    print_status 1 "Binary '$BINARY_NAME' not found after make"
    echo "Files created: "
    ls -la
    exit 1
fi

# TEST2: make fclean
print_test "make fclean"
make fclean > /dev/null 2>&1

# Verify if binary was removed
if [ ! -f "$BINARY_NAME" ]; then
    print_status 0 "Binary '$BINARY_NAME' removed"
else
    print_status 1 "Binary '$BINARY_NAME' still exists after fclean"
    exit 1
fi
