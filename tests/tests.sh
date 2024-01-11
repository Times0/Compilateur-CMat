echo -e "\e[93mRunning tests...\e[0m"

cd ..
make clean >/dev/null 2>&1 || {
  echo -e "\e[91mError: Unable to clean the project.\e[0m"
  exit 1
}
make >/dev/null 2>&1 || {
  echo -e "\e[91mError: Unable to build and run tests.\e[0m"
  exit 1
}
echo -e "\e[92mCompilation successful.\e[0m"
cd tests

succeeded_tests=0
failed_tests=0

function run_c_tests {
  echo -e "\e[93mRunning C tests...\e[0m"
  tempdir="programmes/temp"
  mkdir -p "$tempdir"
  # -v enables natural sorting and not lexicographical sorting
  for cmat_file in $(ls -v programmes/*.cmat); do
    name=$(basename "$cmat_file")

    # Create sibling C program using cmat2c.py
    c_file="$tempdir/$name.c"
    python3 cmat2c.py "$cmat_file" "$c_file"

    # Compile the C program
    gcc $c_file -o "$tempdir/$name"

    # Compile the cmat program and check for errors and put them in the tempdir
    ../bin/cmat "$cmat_file" >/dev/null 2>"$tempdir/$name.err"
    if [ $? -ne 0 ]; then
      echo -e "\e[91mTest $cmat_file compilation failed. See error message in $tempdir/$name.err.\e[0m"
      ((failed_tests++))
      continue
    else
      rm "$tempdir/$name.err" >/dev/null 2>&1
    fi

    # get the expected output by running the C program (should not raise any errors)
    expected_output=$("$tempdir/$name")

    # get the actual output by running the cmat program with spim
    actual_output=$(spim -file "mips.s" | tail -n +6)
    if [ $? -ne 0 ]; then
      echo -e "\e[91mTest $cmat_file failed. See error message in $tempdir/$name.err.\e[0m"
      ((failed_tests++))
      continue
    else
      rm "$tempdir/$name.err" >/dev/null 2>&1
    fi

    # put the expected and actual output in a file named after the cmat file
    echo "$expected_output" >"$tempdir/$name.out"
    echo "$actual_output" >"$tempdir/$name.act"

    # compare the expected and actual output and put the diffs in a file named after the cmat file
    diff "$tempdir/$name.out" "$tempdir/$name.act" >"$tempdir/$name.diff"

    if [ $? -eq 0 ]; then
      echo -e "\e[92mTest $cmat_file succeeded.\e[0m"
      ((succeeded_tests++))
      # clean up when test succeeds
      rm "$tempdir/$name.out" "$tempdir/$name.act" "$tempdir/$name.err" "$c_file" "$tempdir/$name.diff" "$tempdir/$name" >/dev/null 2>&1
    else
      echo -e "\e[91mTest $cmat_file failed. Differences between expected and actual output are in $tempdir/$name.diff.\e[0m"
      ((failed_tests++))
    fi

  done

  # Clean up
  rm mips.s >/dev/null 2>&1
}

function run_cmat_tests {
  echo -e "\e[93mRunning cmat tests...\e[0m"
  tempdir="programmes_matrices/temp"
  mkdir -p "$tempdir"

  # list all the dirs in programmes_matrices
  for dir in $(ls -v programmes_matrices); do
    # exclude the temp dir
    if [ "$dir" == "temp" ]; then
      continue
    fi
    filename=$(basename "$dir")
    in_file="programmes_matrices/$dir/in"
    expected_out_file="programmes_matrices/$dir/out"

    # Compile the cmat program and check for errors and put them in the tempdir
    ../bin/cmat "$in_file" >/dev/null 2>"$tempdir/$dir.err"
    if [ $? -ne 0 ]; then
      echo -e "\e[91mTest $filename failed. See $tempdir/$dir.err.\e[0m"
      ((failed_tests++))
      continue
    else
      rm "$tempdir/$dir.err" >/dev/null 2>&1
    fi

    # get the actual output by running the cmat program with spim
    actual_output=$(spim -file "mips.s" | tail -n +6)
    if [ $? -ne 0 ]; then
      echo -e "\e[91mTest $filename failed. See error message in $tempdir/$dir.err.\e[0m"
      ((failed_tests++))
      continue
    else
      rm "$tempdir/$dir.err" >/dev/null 2>&1
    fi

    # put the actual output in a file named after the cmat file
    echo "$actual_output" >"$tempdir/$dir.act"

    # compare the expected and actual output and put the diffs in a file named after the cmat file
    diff -w "$expected_out_file" "$tempdir/$dir.act" >"$tempdir/$dir.diff"
    if [ $? -eq 0 ]; then
      echo -e "\e[92mTest $filename succeeded.\e[0m"
      ((succeeded_tests++))
      # clean up when test succeeds
      rm "$tempdir/$dir.act" "$tempdir/$dir.err" "$tempdir/$dir.diff" >/dev/null 2>&1
    else
      echo -e "\e[91mTest $filename failed. Differences between expected and actual output are in $tempdir/$dir.diff.\e[0m"
      ((failed_tests++))
    fi

  done
}

# 1 for C tests, 2 for cmat tests, None for both
if [ $# -eq 0 ]; then
  run_c_tests
  run_cmat_tests
elif [ $# -eq 1 ]; then
  if [ "$1" == 1 ]; then
    run_c_tests
  elif [ "$1" == 2 ]; then
    run_cmat_tests
  else
    echo -e "\e[91mError: Invalid argument. Valid arguments are 1 and 2.\e[0m"
    exit 1
  fi
else
  echo -e "\e[91mError: Invalid number of arguments. Valid arguments are 1 and 2.\e[0m"
  exit 1
fi

echo -e "\e[93mTests complete. $succeeded_tests succeeded, $failed_tests failed.\e[0m"
# Exit with appropriate status
if [ "$failed_tests" -eq 0 ]; then
  exit 0
else
  exit 1
fi
