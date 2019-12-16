require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  def contact_email
    ContactMailer.contact_email("matthew@me.com",
                                "Matthew Casey", "1234567890", @message = "Hello")
  end

  test "should return contact email" do
    mail = ContactMailer.contact_email("matthew@me.com",
                                       "Matthew Casey", "1234567890", @message = "Hello")
    assert_equal ['from@example.com'], mail.to
    assert_equal ['from@example.com'], mail.from
  end


  # test "the truth" do
  # end
end
