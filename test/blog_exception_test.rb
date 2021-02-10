require 'minitest/autorun'
require 'minitest/reporters'
require 'fileutils'
MiniTest::Reporters.use!

require_relative './../lib/BloggerException.rb'

class BlogTest < MiniTest::Test
  def setup; end 

  def create_project_file(code)
    File.open('main.rb', 'w') do |file| 
      file.write(code)
    end
  end 

  def test_descriptions_exist
    assert(BloggerException::DESCRIPTIONS)
  end

  def test_file_with_error
    puts create_project_file('8/0')
    
  end 

  def teardown; end 
end 