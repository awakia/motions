class CoffeeShopSelectController < UITableViewController
  def viewDidLoad
    view.dataSource = view.delegate = self
    @json = {}
    server = Server.instance
    server.get("/coffee_shops.json", method(:request).to_proc)
  end

  def tableView(tableView, numberOfRowsInSection:section)
    p @json.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier("test") || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:"test")
    cell.textLabel.text = @json[indexPath.row]['name']
    cell.detailTextLabel.text = @json[indexPath.row].to_s
    cell
  end

  def request(request, result)
    @json = result.dictionary.values.first
    tableView.reloadData
  end
end
