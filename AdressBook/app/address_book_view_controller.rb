class AddressBookViewController < UIViewController
  def viewDidLoad
    super

    if AddressBook.authorized?
      puts "This app is authorized"
    else
      puts "This app is not authorized"
    end

    # ask the user to authorize us
    if AddressBook.request_authorization
      puts  'do something now that the user has said "yes"'
    else
      puts 'do something now that the user has said "no"'
    end

    people = AddressBook::Person.all
    text = ''
    people.each_with_index do |person, i|
      text += "\n" if i != 0
      text += "#{person.first_name} #{person.last_name}"
    end

    view.backgroundColor = UIColor.whiteColor
    @label = UILabel.new
    @label.frame = [[10, 10], [320, 20]]
    @label.font  = UIFont.boldSystemFontOfSize(16)
    @label.text  = text
    @label.numberOfLines = 0  # enable '\n'
    @label.sizeToFit  # resize based on content

    view.addSubview(@label)
  end
end
