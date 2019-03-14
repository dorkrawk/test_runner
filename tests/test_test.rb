require_relative "../test_base"

class TestTest < TestBase

  def test_is_ok?
    on_success
  end

  def test_should_fail
    on_failure("something went wrong")
  end
end