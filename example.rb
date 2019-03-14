require "./test_runner"
# run all tests
TestRunner.run_tests

puts "-" * 20

# run specific test file(s)
# just run the TestTest tests from the /tests/test_test.rb file
TestRunner.run_tests(test_files: ["test_test"])

puts "-" * 20

# run specific tests(s)
# just run `AnotherTest#test_pass` and `TestTest#test_is_ok?`
TestRunner.run_tests(test_names: ["AnotherTest#test_pass", "TestTest#test_is_ok?"])

puts "-" * 20

# run a specific test with a dependency
TestRunner.run_tests(test_names: ["AnotherTest#test_do_task_requiring_setup"])