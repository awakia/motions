class HttpRequestViewController < UIViewController
  def viewDidLoad
    super

    navigationItem.title = "Request to google.com"
    view.backgroundColor = UIColor.whiteColor
    @label = UILabel.new
    @label.frame = [[10, 10], [320, 20]]
    @label.font  = UIFont.boldSystemFontOfSize(16)
    @label.text  = title

    BubbleWrap::HTTP.get("http://google.com") do |response|
      p response
      @label.text = response.url.absoluteString
    end

    view.addSubview(@label)
  end
end
