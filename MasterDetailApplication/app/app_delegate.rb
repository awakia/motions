class AppDelegate
  attr_accessor :window
  attr_reader :managedObjectContext, :managedObjectModel, :persistentStoreCoordinator

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      splitViewController = self.window.rootViewController
      navigationController = splitViewController.viewControllers.lastObject
      splitViewController.delegate = navigationController.topViewController
      masterNavigationController = splitViewController.viewControllers.first
      controller = masterNavigationController.topViewController
      controller.managedObjectContext = self.managedObjectContext
    else
      navigationController = self.window.rootViewController
      controller = navigationController.topViewController
      controller.managedObjectContext = self.managedObjectContext
    end
    true
  end

  def applicationWillTerminate(application)
    self.saveContext
  end

  def saveContext
    error = Pointer.new(:object)
    managedObjectContext = self.managedObjectContext
    if managedObjectContext != nil
      if managedObjectContext.hasChanges && !managedObjectContext.save(error)
        # Replace this implementation with code to handle the error appropriately.
        # abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog("Unresolved error %@, %@", error, error.userInfo)
        abort
      end
    end
  end

  ## Core Data stack

  # Returns the managed object context for the application.
  # If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
  def managedObjectContext
    if @managedObjectContext
      return @managedObjectContext
    end

    coordinator = self.persistentStoreCoordinator
    if coordinator != nil
      @managedObjectContext = NSManagedObjectContext.alloc.init
      @managedObjectContext.setPersistentStoreCoordinator(coordinator)
    end
    return @managedObjectContext
  end

  # Returns the managed object model for the application.
  # If the model doesn't already exist, it is created from the application's model.
  def managedObjectModel
    if @managedObjectModel
      return @managedObjectModel
    end
    modelURL = NSBundle.mainBundle.URLForResource("MasterDetailApplication", withExtension:"momd")
    @managedObjectModel = NSManagedObjectModel.alloc.initWithContentsOfURL(modelURL)
    return @managedObjectModel
  end

  # Returns the persistent store coordinator for the application.
  # If the coordinator doesn't already exist, it is created and the application's store added to it.
  def persistentStoreCoordinator
    if @persistentStoreCoordinator != nil
      return @persistentStoreCoordinator
    end
    storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("MasterDetailApplication.sqlite")

    error = Pointer.new(:object)
    @persistentStoreCoordinator = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(self.managedObjectModel)
    if !@persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:storeURL, options:nil, error:error)

       # Replace this implementation with code to handle the error appropriately.

       # abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

       # Typical reasons for an error here include:
       # * The persistent store is not accessible
       # * The schema for the persistent store is incompatible with current managed object model.
       # Check the error message to determine what the actual problem was.


       # If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

       # If you encounter schema incompatibility errors during development, you can reduce their frequency by:
       # * Simply deleting the existing store:
       # [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]

       # * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
       # @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}

       # Lightweight migration will only work for a limited set of schema changes consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

      NSLog("Unresolved error %@, %@", error, error.userInfo)
      abort
    end
    return @persistentStoreCoordinator
  end

  ## Application's Documents directory

  # Returns the URL to the application's Documents directory.
  def applicationDocumentsDirectory
    return NSFileManager.defaultManager.URLsForDirectory(NSDocumentDirectory, inDomains:NSUserDomainMask).lastObject
  end

end
