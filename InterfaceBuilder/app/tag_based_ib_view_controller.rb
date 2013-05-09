class TagBasedIBViewController < UIViewController
  def loadView
    views = NSBundle.mainBundle.loadNibNamed("TagBasedView", owner: self, options: nil)
    self.view = views[0]
  end

  def viewDidLoad
    super

    @label = view.viewWithTag(1)
    @button = view.viewWithTag(2)
    @button.addTarget(self, action: "buttonClicked:", forControlEvents:UIControlEventTouchUpInside)

    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Tab1", image: nil, tag: 1)
  end

  def buttonClicked(sender)
    @label.text = "You clicked!"
  end
end
