echo -e "\e[93mRunning tests...\e[0m"

cd ..

make clean > /dev/null 2>&1 || { echo -e "\e[91mError: Unable to clean the project.\e[0m"; exit 1; }
make tests > /dev/null 2>&1 || { echo -e "\e[91mError: Unable to build and run tests.\e[0m"; exit 1; }
echo -e "\e[92mCompilation successful.\e[0m"
cd tests
all_tests=$(ls -d */ | cut -f1 -d'/')

# Initialize counters
succeeded_tests=0
failed_tests=0

for test_folder in $all_tests; do
  if [ -d "$test_folder" ]; then
    test_name=$(basename "$test_folder")
    output_file="$test_folder/out"
    expected_output_file="$test_folder/out_expected"

    (../bin/cmat_test_version < "$test_folder/in") > "$output_file" 2>&1 || { 
      echo -e "\e[91mError: Unable to run test $test_name.\e[0m"; 
      exit 1; 
    }

    # Compare output with expected
    if diff "$output_file" "$expected_output_file" > /dev/null 2>&1; then
      echo -e "\e[92mTest $test_name passed successfully.\e[0m"
      ((succeeded_tests++))
    else
      echo -e "\e[91mError: Test $test_name failed. Output differs from expected.\e[0m"
      ((failed_tests++))
    fi
  fi
done

# Print test results
echo -e "\n\e[93mTest Results:\e[0m"
echo -e "\e[92mSucceeded Tests: $succeeded_tests\e[0m"
echo -e "\e[91mFailed Tests: $failed_tests\e[0m"

# Exit with appropriate status
if [ "$failed_tests" -eq 0 ]; then
  exit 0
else
  exit 1
fi
