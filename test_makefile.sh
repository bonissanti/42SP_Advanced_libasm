#!/bin/bash

LIBRARY_NAME="libasm.a"

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
eteamcity_test_started() {
     echo "##teamcity[testStarted name='$1']"
 }

 teamcity_test_finished() {
     echo "##teamcity[testFinished name='$1']"
 }

 teamcity_test_failed() {
     echo "##teamcity[testFailed name='$1' message='$2']"
 }

# Clean workspace
 echo "##teamcity[blockOpened name='Cleanup']"
 make fclean > /dev/null 2>&1
 echo "##teamcity[blockClosed name='Cleanup']"

 # Test 1: Build inicial
 teamcity_test_started "make_build"
 echo "##teamcity[blockOpened name='Initial Build']"

 make > make_output.log 2>&1
 make_exit_code=$?

 if [ $make_exit_code -ne 0 ]; then
     teamcity_test_failed "make_build" "Make command failed with exit code: $make_exit_code"
     cat make_output.log
     exit 1
 fi

 if [ ! -f "$LIBRARY_NAME" ]; then
     teamcity_test_failed "make_build" "Binary '$LIBRARY_NAME' not created"
     ls -la
     exit 1
 fi

 echo "Binary created successfully: $LIBRARY_NAME"
 echo "##teamcity[blockClosed name='Initial Build']"
 teamcity_test_finished "make_build"

 # Test 2: Clean
 teamcity_test_started "make_fclean"
 echo "##teamcity[blockOpened name='Clean Test']"

 make fclean > /dev/null 2>&1

 if [ -f "$LIBRARY_NAME" ]; then
     teamcity_test_failed "make_fclean" "Binary '$LIBRARY_NAME' not removed after fclean"
     exit 1
 fi

 if [ -d "$OBJ_DIR" ] && [ -n "$(ls -A $OBJ_DIR 2>/dev/null)" ]; then
     teamcity_test_failed "make_fclean" "Object files not removed after fclean"
     ls -la $OBJ_DIR
     exit 1
 fi

 echo "Clean successful - binary and objects removed"
 echo "##teamcity[blockClosed name='Clean Test']"
 teamcity_test_finished "make_fclean"

 # Test 3: Rebuild
 teamcity_test_started "make_re"
 echo "##teamcity[blockOpened name='Rebuild Test']"

 make re > /dev/null 2>&1

 if [ ! -f "$LIBRARY_NAME" ]; then
     teamcity_test_failed "make_re" "Binary '$LIBRARY_NAME' not created after make re"
     exit 1
 fi

 echo "Rebuild successful"
 echo "##teamcity[blockClosed name='Rebuild Test']"
 teamcity_test_finished "make_re"

 # Test 4: No unnecessary rebuild
 teamcity_test_started "make_no_rebuild"
 echo "##teamcity[blockOpened name='No Rebuild Test']"

 make_output=$(make 2>&1)
 if ! echo "$make_output" | grep -q "Nothing to be done\|up to date" && [ -n "$make_output" ]; then
     teamcity_test_failed "make_no_rebuild" "Make unnecessarily rebuilt: $make_output"
     exit 1
 fi

 echo "No unnecessary rebuild detected"
 echo "##teamcity[blockClosed name='No Rebuild Test']"
 teamcity_test_finished "make_no_rebuild"

 # Test 5: Unit tests
 if grep -q "^test:" Makefile 2>/dev/null; then
     teamcity_test_started "make_test"
     echo "##teamcity[blockOpened name='Unit Tests']"

     make test > test_output.log 2>&1
     test_exit_code=$?

     if [ $test_exit_code -ne 0 ]; then
         teamcity_test_failed "make_test" "Unit tests failed"
         cat test_output.log
         exit 1
     fi

     echo "Unit tests passed"
     echo "##teamcity[blockClosed name='Unit Tests']"
     teamcity_test_finished "make_test"
 fi

 # Cleanup
 rm -f make_output.log test_output.log

 echo "##teamcity[message text='All Makefile tests passed successfully' status='NORMAL']"
 exit 0