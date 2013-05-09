class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    tab1 = TagBasedIBViewController.new
    tab2 = NSBundle.mainBundle.loadNibNamed('MotionUtilBasedView', owner: self, options: nil).first
    tab_controller = UITabBarController.new
    tab_controller.viewControllers = [tab1, tab2]
    @window.rootViewController = tab_controller

    @window.makeKeyAndVisible
    true
  end
end
