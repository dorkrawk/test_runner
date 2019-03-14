require 'set'

class TestBase

  def initialize
    @tests_run = Set[]
    @verbose = true
  end

  def run_tests(whitelist_tests: nil)
    puts "Running tests for #{self.class.name}"
    test_methods.each do |test_method|
      if whitelist_tests.nil? || whitelist_tests.include?(test_method.to_s)
        puts "  #{test_method}"
        self.send(test_method)
        @tests_run.add(test_method)
      end
    end
  end 

  def dependencies(*dep_methods)
    dep_methods.each do |dep_method|
      if test_methods.include?(dep_method) && !@tests_run.include?(dep_method)
        self.send(dep_method)
      end
    end
  end

  def on_success(message = "")
    puts "     ✅ #{message}"
  end

  def on_failure(message = "")
    puts "     ❌ #{message}"
  end

  def test_methods
    @test_methods ||= self.class.instance_methods.select { |m| m.to_s.start_with?("test_") }
  end

end