require 'minitest/autorun'
require 'minitest/reporters'
require 'fileutils'
require 'yaml'
MiniTest::Reporters.use!

require_relative './../lib/BloggerException.rb'

class BlogTest < MiniTest::Test

  DIVISION_ERROR_FILE_CONTENT = "require_relative './../lib/ruby_blogger.rb'\n8/0"

  def setup
    @file_w_error = project_file(DIVISION_ERROR_FILE_CONTENT)
    @out, @err = capture_subprocess_io do
      run_project_file
    end

  end 

  #helper methods
  def project_file(code)
    File.open('main.rb', 'w') do |file| 
      file.write(code)
    end
  end 

  def run_project_file
    system('ruby main.rb')
  end 

  def remove_generated_yml
      FileUtils.rm('structured_exceptions.yml')
  end

  #test methods
  def test_descriptions_exist
    assert(BloggerException::DESCRIPTIONS)
  end

  def test_log_confirmation_displays
    assert_match(/Bug Logged Successfully:/, @out)

    assert_match(/ZeroDivisionError/, @err)
  end 

  def test_blogger_instance
    blogger_yaml = YAML.load(File.read('structured_exceptions.yml'))
    assert_instance_of(BloggerException, blogger_yaml)
  end

  def teardown
    FileUtils.rm('main.rb')
    remove_generated_yml
  end 
end 