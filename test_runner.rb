require "singleton"
Dir["./tests/*.rb"].each {|file| require file }

class TestRunner
  include Singleton

  TEST_FOLDER = File.join(".", "tests")
  TEST_RB_FILES = File.join("**", "tests", "*.rb")

  def self.run_tests(test_files: nil, test_names: nil)
    if test_names
      run_tests_by_test_names(test_names)
    elsif test_files
      run_tests_by_file_names(test_files)
    else
      run_all_tests
    end
  end

  private 

  def self.run_all_tests
    test_classes = {}
    testrbfiles = File.join("**", "tests", "*.rb")
    Dir.glob(TEST_RB_FILES).each do |test_file|
      file_name = File.basename(test_file, ".rb")
      test_class = make_it_classy(file_name)
      test_classes[test_class] = nil
    end
    self.run_tests_by_class(test_classes)
  end

  def self.run_tests_by_file_names(test_files)
    test_classes = {}
    test_files.each do |file_name|
      file_base_name = File.basename(file_name, ".*")
      file_name = file_base_name + ".rb"
      if File.file?(File.join(TEST_FOLDER, file_name))
        test_class = make_it_classy(file_base_name)
        test_classes[test_class] = nil
      end
    end.compact
    self.run_tests_by_class(test_classes)
  end

  def self.run_tests_by_test_names(test_names)
    test_classes = {}
    test_names.each do |test_name|
      class_name, test_method = test_name.split("#")
      file_name = self.make_it_snakey(class_name) + ".rb"
      if File.file?(File.join(TEST_FOLDER, file_name))
        test_class = make_it_classy(class_name)
        if !test_classes.key?(test_class)
          test_classes[test_class] = []
        end
        test_classes[test_class] << test_method
      end
    end
    self.run_tests_by_class(test_classes)
  end

  def self.run_tests_by_class(test_classes_with_whitelist)
    test_classes_with_whitelist.each do |test_class, whitelist_tests|
      test_class.new.run_tests(whitelist_tests: whitelist_tests)
    end
  end

  def self.make_it_classy(file_name)
    test_class = file_name.split('_').collect(&:capitalize).join
    Object.const_get(test_class)
  end

  def self.make_it_snakey(str)
    str.gsub!(/(.)([A-Z])/,'\1_\2')
    str.downcase
  end


end

# TestRunner.run_tests
# TestRunner.run_tests(test_files: ["test_test"])
# TestRunner.run_tests(test_names: ["AnotherTest#test_pass", "TestTest#test_is_ok?"])

