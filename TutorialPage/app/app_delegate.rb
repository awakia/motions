class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @storyboard = UIStoryboard.storyboardWithName('TutorialStoryboard', bundle:nil)
    nav_controller = UINavigationController.alloc.initWithRootViewController(@storyboard.instantiateInitialViewController)
    @window.rootViewController = nav_controller
    @window.makeKeyAndVisible
    true
  end
end
