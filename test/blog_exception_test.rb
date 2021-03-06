# require 'simplecov'
# SimpleCov.start
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

    @blogger_exception = YAML.load(File.read('structured_exceptions.yml'))

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

  def test_blogger_to_s
    assert_instance_of(String, @blogger_exception.to_s)
  end

  def test_blogger_to_s_keys
    assert_match(/:file:/, @blogger_exception.to_s)
  end

  def test_blogger_file_to_s
    assert_match(/main.rb/, @blogger_exception.file)
  end 

  def test_display
    constant_display_msg = "\tClass ZeroDivisionError\n\tDescription: Attempting to divide an Integer by 0."
    assert_output(/#{constant_display_msg}/) { @blogger_exception.display }
  end

  def test_generate_description_for_zero_div_exception
    type = @blogger_exception.type.to_sym
    assert_equal( "Attempting to divide an Integer by 0.", @blogger_exception.generate_description(type))
  end

  def test_generate_description_for_other_exception
    default_msg = 'Check out https://ruby-doc.org/core-2.7.0/Exception.html for more information.'
    assert_equal(default_msg, @blogger_exception.generate_description('SomeExceptionClass'))
  end

  def test_private_getters
    assert_raises(NoMethodError) { @blogger_exception.cause }
    assert_raises(NoMethodError) { @blogger_exception.message }
    assert_raises(NoMethodError) { @blogger_exception.scope }
  end

  def teardown
    FileUtils.rm('main.rb')
    remove_generated_yml
  end 
end 