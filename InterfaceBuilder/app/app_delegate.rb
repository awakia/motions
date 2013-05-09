class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    tab1 = TagBasedIBViewController.new
    # c2 = MotionUtilBasedIBViewController.new
    tab_controller = UITabBarController.new
    tab_controller.viewControllers = [tab1]
    @window.rootViewController = tab_controller

    @window.makeKeyAndVisible
    true
  end
end
