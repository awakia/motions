class HelloController < UIViewController
  extend IB

  # define ib outlet
  outlet :label, UILabel

  # define ib action
  def click sender
    @label.text = 'abc'
  end
end
