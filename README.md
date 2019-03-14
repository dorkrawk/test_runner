# TestRunner

A general test running framework

## Test Requirements

- Test files are Ruby files saved in the `/tests` directory
- Test files inherit from `TestBase`
- Tests written in test files are methods that start with the `test_` prefix

## Usage

```ruby
# run all tests
TestRunner.run_tests

# run specific test file(s)
# just run the TestTest tests from the /tests/test_test.rb file
TestRunner.run_tests(test_files: ["test_test"])

# run specific tests(s)
# just run `AnotherTest#test_pass` and `TestTest#test_is_ok?`
TestRunner.run_tests(test_names: ["AnotherTest#test_pass", "TestTest#test_is_ok?"])

# run a specific test with a dependency
TestRunner.run_tests(test_names: ["AnotherTest#test_do_task_requiring_setup"])
```

```ruby
# handle test dependenices
class AnotherTest < TestBase
  def test_setup
    on_success("things set up")
  end

  def test_more_setup
    on_success("things set up even more")
  end

  def test_do_task_requiring_setup
    dependencies :test_setup, :test_more_setup

    on_success("task done")
  end
end
```

To see an example run:
```
ruby example.rb
```