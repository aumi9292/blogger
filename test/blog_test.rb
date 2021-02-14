# require 'simplecov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'

MiniTest::Reporters.use!

require_relative './../lib/Blog.rb'



class BlogTest < MiniTest::Test

  BLOG_OUTPUT = <<~MLS 
  Total Exceptions: 1 in main.rb

  Exception Class: ZeroDivisionError
  Total: 1
  ---------------
  MLS

  FILE_HEADER_OUT = <<~MLS

  File: main.rb
  ---------------
  MLS

  FILE = 'main.rb'

  FOLDER_EXC_OUTPUT = <<~MLS

  Exception Class: ZeroDivisionError
  Total: 1
  ---------------
  MLS

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

  def test_blog_constants_exist
    assert(Blog::FILE)
    assert(Blog::NO_EXCEPTIONS)
  end

  def test_blog_exceptions
    assert_equal(true, Blog.exceptions?)
  end

  def test_generate_and_display_blog
    assert_output(BLOG_OUTPUT) { Blog.generate_and_display_blog }
  end

  def test_display_blog
    assert_output(BLOG_OUTPUT) { Blog.new().display_blog }
  end

  def test_file_does_not_exist
    msg = "Sorry, somefile.rb is not a file in this folder.\n"
    assert_output(msg) { Blog.new.display_file_does_not_exist('somefile.rb')}
  end

  def test_display_file_header
    assert_output(FILE_HEADER_OUT) { Blog.new.display_file_header('main.rb') }
  end

  def test_count
    assert_equal(1, Blog.new.count('ZeroDivisionError'))
    refute_equal(1, Blog.new.count('NoMethodError'))
  end

  def test_folder_exceptions
    assert_output(FOLDER_EXC_OUTPUT) { Blog.new.folder_exceptions }
  end

  def test_read_exceptions_for_file
    assert_instance_of(Array, Blog.new.read_exceptions_for_file(FILE))
  end

  def test_legit_file
    assert_equal(true, Blog.new.legit_file?(FILE))
    
    assert_equal(false, Blog.new.legit_file?('somefile.rb'))
  end

  def test_illegit_file   
    assert_equal(true, Blog.new.illegit_file?('somefile.rb'))
  end

  def teardown
    FileUtils.rm('main.rb')
    remove_generated_yml
  end 
end 