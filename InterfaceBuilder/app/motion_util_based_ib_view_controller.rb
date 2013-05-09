class MotionUtilBasedIBViewController < UIViewController

  def viewDidLoad
    super

    @label = view.viewWithTag(1)
    @button = view.viewWithTag(2)
    @button.addTarget(self, action: "buttonClicked:", forControlEvents:UIControlEventTouchUpInside)

    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Tab2", image: nil, tag: 2)
  end

  def buttonClicked(sender)
    @label.text = "You clicked!"
  end
end
