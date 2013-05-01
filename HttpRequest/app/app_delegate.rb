class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |window|
      window.rootViewController = UINavigationController.alloc.initWithRootViewController(HttpRequestViewController.alloc.init)
      window.makeKeyAndVisible
    end
    true
  end
end
