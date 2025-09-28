#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

LIBRARY_NAME="program"
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
    echo -e "${YELLOW}🧪 Testing: $1${RESET}"
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
if [ -f "$LIBRARY_NAME" ]; then
    print_status 0 "Binary '$LIBRARY_NAME' created successfully"
else
    print_status 1 "Binary '$LIBRARY_NAME' not found after make"
    echo "Files created: "
    ls -la
    exit 1
fi

# TEST 2: make fclean
print_test "make fclean"
make fclean > /dev/null 2>&1

# Verify if binary was removed
if [ ! -f "$LIBRARY_NAME" ]; then
    print_status 0 "Binary '$LIBRARY_NAME' removed"
else
    print_status 1 "Binary '$LIBRARY_NAME' still exists after fclean"
    exit 1
fi

# TEST 3: make re - Rebuild
print_test "make re"
make re > /dev/null 2>&1

if [ -f "$LIBRARY_NAME" ]; then
    print_status 0  "Binary '$LIBRARY_NAME' rebuilt successfully"
else
    print_status 1 "Binary '$LIBRARY_NAME' not found after make re"
    exit 1
fi

# TEST 4: make - Nothing to be done
print_test "make (nothing to be done)"
make_output=$(make 2>&1) # TODO: redirect to file?
make_exit_code=$?

# Verify if relinked
if echo "$make_output" | grep -q "Nothing to be done for 'all'\|up to date"; then
    print_status 0  "Make correctly detected no changes needed"
else
    print_status 1 "Make unnecessarily rebuilt files"
    echo "Make output: $make_output"
    exit 1
fi

# TEST 5: make test - criterion tester
if grep -q "test:" Makefile 2>/dev/null; then
    print_test "make test"
    make test > test_output.log 2>&1
    test_exit_code=$?

    if [ $test_exit_code -eq 0 ]; then
        print_status 0 "Tests passed"
    else
        print_status 1 "Tests failed"
        echo "Test output:"
        cat test_output.log
        exit 1
    fi
else
    echo -e "${YELLOW}⚠ No 'test' target found in Makefile${RESET}"
fi

# TODO: TEST 6: library exists

echo -e "${GREEN} === All tests passed! ===${RESET}"

make fclean
rm -f make_output.log test_output.log

exit 0

