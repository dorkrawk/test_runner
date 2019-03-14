require_relative "../test_base"

class AnotherTest < TestBase

  def test_pass
    on_success("looks good!")
  end

  def test_fail
    on_failure("FAILURE")
  end

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