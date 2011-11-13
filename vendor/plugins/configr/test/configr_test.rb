require 'test_helper'

class ConfigrTest < ActiveSupport::TestCase
  def setup
    @config = Configr.new
  end

  # Replace this with your real tests.
  test "basics" do
    assert_nil @config.watch
    assert_nil @config.watch.out.for.that.tree
    
    @config.watch.out.for.that.tree = "George"
    assert_equal "George", @config.watch.out.for.that.tree
    
    assert_nil @config.
  end
end
