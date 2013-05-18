class MasterViewController < UITableViewController
  attr_accessor :detailViewController, :fetchedResultsController, :managedObjectContext

  def awakeFromNib
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      self.clearsSelectionOnViewWillAppear = false
      self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0)
    end
    super
  end

  def viewDidLoad
    super
    # Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem

    addButton = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:"insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton

    # This if condition is not in original objective-c code, but it's necessary for ruby-motion.
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      self.detailViewController = self.splitViewController.viewControllers.lastObject.topViewController
    end
  end

  def didReceiveMemoryWarning
    super
    # Dispose of any resources that can be recreated.
  end

  def insertNewObject(sender)
    context = self.fetchedResultsController.managedObjectContext
    entity = self.fetchedResultsController.fetchRequest.entity
    newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(
      entity.name, inManagedObjectContext:context)

    # If appropriate, configure the new managed object.
    # Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    newManagedObject.setValue(NSDate.date, forKey:"timeStamp")

    # Save the context.
    error = Pointer.new(:object)

    p context.methods.grep /save/i

    if !context.save(error)
      # Replace this implementation with code to handle the error appropriately.
      # abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error %@, %@", error, error.userInfo)
      abort
    end

    p 'ok'
  end

## Table View

  def numberOfSectionsInTableView(tableView)
    return self.fetchedResultsController.sections.count
  end

  def tableView(tableView, numberOfRowsInSection:section)
    sectionInfo = self.fetchedResultsController.sections[section]
    return sectionInfo.numberOfObjects
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:indexPath)
    self.configureCell(cell, atIndexPath:indexPath)
    return cell
  end

  def tableView(tableView, canEditRowAtIndexPath:indexPath)
    # Return NO if you do not want the specified item to be editable.
    return true
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete
      context = self.fetchedResultsController.managedObjectContext
      context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath))

      error = Pointer.new(:object)
      if !context.save(error)
        # Replace this implementation with code to handle the error appropriately.
        # abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog("Unresolved error %@, %@", error, error.userInfo)
        abort
      end
    end
  end

  def tableView(tableView, canMoveRowAtIndexPath:indexPath)
    # The table view should not be re-orderable.
    return false
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    if UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
      object = self.fetchedResultsController.objectAtIndexPath(indexPath)
      self.detailViewController.detailItem = object
    end
  end

  def prepareForSegue(segue, sender:sender)
    if segue.identifier.isEqualToString("showDetail")
      indexPath = self.tableView.indexPathForSelectedRow
      object = self.fetchedResultsController.objectAtIndexPath(indexPath)
      segue.destinationViewController.setDetailItem(object)
    end
  end

## Fetched results controller

  def fetchedResultsController
    if @fetchedResultsController != nil
      return @fetchedResultsController
    end

    fetchRequest = NSFetchRequest.alloc.init
    # Edit the entity name as appropriate.
    entity = NSEntityDescription.entityForName("Event", inManagedObjectContext:self.managedObjectContext)
    fetchRequest.setEntity(entity)

    # Set the batch size to a suitable number.
    fetchRequest.setFetchBatchSize(20)

    # Edit the sort key as appropriate.
    sortDescriptor = NSSortDescriptor.alloc.initWithKey("timeStamp", ascending:false)
    sortDescriptors = [sortDescriptor]

    fetchRequest.setSortDescriptors(sortDescriptors)

    # Edit the section name key path and cache name if appropriate.
    # nil for section name key path means "no sections".
    aFetchedResultsController = NSFetchedResultsController.alloc.initWithFetchRequest(fetchRequest, managedObjectContext:self.managedObjectContext, sectionNameKeyPath:nil, cacheName:"Master")
    aFetchedResultsController.delegate = self
    @fetchedResultsController = aFetchedResultsController

    error = Pointer.new(:object)
    if !self.fetchedResultsController.performFetch(error)
      # Replace this implementation with code to handle the error appropriately.
      # abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error %@, %@", error, error.userInfo)
      abort
    end

    return @fetchedResultsController
  end

  def controllerWillChangeContent(controller)
    self.tableView.beginUpdates
  end

  def controller(controller, didChangeSection:sectionInfo,
      atIndex:sectionIndex, forChangeType:type)
    case type
    when NSFetchedResultsChangeInsert
      self.tableView.insertSections(NSIndexSet.indexSetWithIndex(sectionIndex), withRowAnimation(UITableViewRowAnimationFade))
    when NSFetchedResultsChangeDelete
      self.tableView.deleteSections(NSIndexSet.indexSetWithIndex(sectionIndex), withRowAnimation(UITableViewRowAnimationFade))
    end
  end

  def controller(controller, didChangeObject:anObject,
      atIndexPath:indexPath, forChangeType:type,
      newIndexPath:newIndexPath)
    tableView = self.tableView
    case type
    when NSFetchedResultsChangeInsert
      tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation:UITableViewRowAnimationFade)
    when NSFetchedResultsChangeDelete
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
    when NSFetchedResultsChangeUpdate
      self.configureCell(tableView, cellForRowAtIndexPath:indexPath, atIndexPath:indexPath)
    when NSFetchedResultsChangeMove
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
      tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation:UITableViewRowAnimationFade)
    end
  end

  def controllerDidChangeContent(controller)
    self.tableView.endUpdates
  end

  # # Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.

  # def controllerDidChangeContent:(NSFetchedResultsController *)controller
  #   # In the simplest, most efficient, case, reload the table view.
  #   self.tableView.reloadData
  # end

  def configureCell(cell, atIndexPath:indexPath)
    object = self.fetchedResultsController.objectAtIndexPath(indexPath)
    cell.textLabel.text = object.valueForKey("timeStamp").description
  end
end
