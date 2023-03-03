require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    @message = users(:example).messages.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @message.valid?, @message.errors.full_messages
  end

  test "should not be blank" do
    @message.content = " "
    assert !@message.valid?
  end

  test "mentions should contain a single valid user" do
    @message.content = "hey @example @nonexample"
    assert @message.mentions().length == 1
    assert @message.mentions()[0] == users(:example)
  end

  test "mentions should not contain an invalid user" do
    @message.content = "hey @nonexample"
    assert @message.mentions().none?
  end

  test "mentions should not contain any users without @ notation present" do
    assert @message.mentions().none?
  end

end
