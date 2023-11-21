cd ..

make clean > /dev/null 2>&1 || { echo "Error: Unable to clean the project."; exit 1; }
make tests > /dev/null 2>&1 || { echo "Error: Unable to build and run tests."; exit 1; }

cd tests

test_name="1_basic_main"
output_file="$test_name/out"
expected_output_file="$test_name/out_expected"

(../bin/cmat_test_version < "$test_name/in") > "$output_file" 2>&1 || { echo "Error: Unable to run test $test_name."; exit 1; }

# Compare output with expected
if diff "$output_file" "$expected_output_file" > /dev/null 2>&1; then
  echo "Test $test_name passed successfully."
else
  echo "Error: Test $test_name failed. Output differs from expected."
  exit 1
fi
