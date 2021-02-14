require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

require_relative './../lib/Blog.rb'



class BlogTest < MiniTest::Test
  def setup; end 

  def test_blog_constants_exist
    assert(Blog::FILE)
    assert(Blog::NO_EXCEPTIONS)
  end

  def teardown; end 
end 