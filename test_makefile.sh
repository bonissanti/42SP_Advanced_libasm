#!/bin/bash

BINARY_NAME="program"
OBJ_MANDATORY_DIR="mandatory/obj"
OBJ_MANDATORY_DIR="bonus/obj"

teamcity_test_started()
{
    echo "##teamcity[testStarted name='$1']"
}

teamcity_test_finished()
{
    echo "##teamcity[testFinished name='$1']"
}

teamcity_test_failed()
{
    echo "##teamcity[testFailed name='$1']"
}

# Clean workspace
echo "##teamcity[blockOpened name='Cleanup'"
make fclean > /dev/null 2>&1
echo "##teamcity[blockClosed name='Cleanup'"

# Test 1: Initial build
teamcity_started "make_build"
echo "##teamcity[blockOpened name='Initial Build']"
make > make_output.log 2>&1
make_exit_code=$?

if [ $make_exit_code -ne 0 ]; then
    teamcity_test_failed "make_build" "Make command failed with exit code: $make_exit_code"
    cat make_output.log
    exit 1
fi

# Verify if binary exists
if [ ! -f "$BINARY_NAME" ]; then
    teamcity_test_failed "make_build" "Binary '$BINARY_NAME' not created"
    ls -la
    exit 1
fi

echo "Binary created successfully: $BINARY_NAME"
echo "##teamcity[blockClosed name='Initial Build']"
teamcity_test_finished "make_build"

# Test 2: make clean
teamcity_started "make_build"
echo "##teamcity[blockOpened name='Clean test']"
make fclean > /dev/null 2>&1

# Verify if binary was removed
if [ ! -f "$BINARY_NAME" ]; then
    teamcity_test_failed "make_fclean" "Binary '$BINARY_NAME' not removed after fclean"
    ls -la $OBJ_DIR
    exit 1
fi

if [ -d "$OBJ_DIR" ] && [ -n "$(ls -A $OBJ_DIR 2>/dev/null)" ]; then
    teamcity_test_failed "make_fclean" "Object files not removed after fclean"
    ls -la $OBJ_DIR
    exit 1
fi

echo "Clean successful - binary and objects removed"
echo "##teamcity[blockClosed name='Clean test']"
teamcity_test_finished "make_fclean"

# Test 3: Rebuild
teamcity_started "make_re"
echo "##teamcity[blockOpened name='Rebuild test']"
make re > /dev/null 2>&1

if [ ! -f "$BINARY_NAME" ]; then
    teamcity_test_failed "make_re" "Binary '$BINARY_NAME' not found after make re"
    exit 1
fi

echo "Rebuild successful"
echo "##teamcity[blockClosed name='Rebuild test']"
teamcity_test_finished "make_re"