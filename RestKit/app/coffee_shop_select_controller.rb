class CoffeeShopSelectController < UITableViewController
  def viewDidLoad
    view.dataSource = view.delegate = self
    server = Server.instance
    server.get("/coffee_shops.json")
  end

  def numberOfRowsInSection(section)
    return 1
  end
end
