require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal 'Подтверждение заказа в Pragmatic Store', mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
  end



end
