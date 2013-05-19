class DetailViewController < UIViewController
  extend IB

  attr_accessor :detailItem
  outlet :detailDescriptionLabel, UILabel

  ## Managing the detail item

  def setDetailItem(newDetailItem)
    if self.detailItem != newDetailItem
      self.detailItem = newDetailItem
      # Update the view.
      configureView
    end
    if @masterPopoverController != nil
      @masterPopoverController.dismissPopoverAnimated(true)
    end
  end

  def configureView
    # Update the user interface for the detail item.
    if self.detailItem
      self.view  # I don't know why, but without this detailDescriptionLabel becme nil
      self.detailDescriptionLabel.text = self.detailItem.valueForKey("timeStamp").description
    end
  end

  def viewDidLoad
    super
    # Do any additional setup after loading the view, typically from a nib.
    configureView
  end

  def didReceiveMemoryWarning
    super
    # Dispose of any resources that can be recreated.
  end

  ## Split view

  # Tells the delegate that the specified view controller is about to be hidden.
  def splitViewController(splitController,
      willHideViewController:viewController,
      withBarButtonItem:barButtonItem,
      forPopoverController:popoverController)
    barButtonItem.title = "Master" # NSLocalizedString("Master", "Master")
    self.navigationItem.setLeftBarButtonItem(barButtonItem, animated:true)
    @masterPopoverController = popoverController
  end

  # Tells the delegate that the specified view controller is about to be shown again.
  def splitViewController(splitController,
      willShowViewController:viewController,
      invalidatingBarButtonItem:barButtonItem)
    # Called when the view is shown again in the split view, invalidating the button and popover controller.
    self.navigationItem.setLeftBarButtonItem(nil, animated:true)
    @masterPopoverController = nil
  end
end
