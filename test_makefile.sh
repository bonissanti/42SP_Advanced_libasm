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
echo "##teamcity"


