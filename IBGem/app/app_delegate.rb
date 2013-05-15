class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @storyboard = UIStoryboard.storyboardWithName('Hello', bundle:nil)
    @window.rootViewController = @storyboard.instantiateViewControllerWithIdentifier('first')
    @window.makeKeyAndVisible
    true
  end
end
