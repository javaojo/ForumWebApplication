require 'test_helper'

class ChannelTest < ActiveSupport::TestCase

  test 'should not save empty channel' do
    channel= Channel.new
    channel.save
    channel.valid?
  end
  # test "the truth" do
  #   assert true
  # end
end
