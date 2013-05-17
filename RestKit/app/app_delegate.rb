class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    nav_controller = UINavigationController.alloc.initWithRootViewController(CoffeeShopSelectController.new)
    @window.rootViewController = nav_controller
    @window.makeKeyAndVisible
    true
  end
end
