class Server
  # singleton
  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end
  private_class_method :new

  def initialize
    initialize_restkit
    register_coffee_shop_mapping
  end

  def get(path, delegate)
    restkit_object_manager.loadObjectsAtResourcePath(path, delegate: delegate)
  end

  def base_url
    @base_url ||= NSBundle.mainBundle.objectForInfoDictionaryKey('BASE_URL').nsurl
  end

  def initialize_restkit
    RKObjectManager.managerWithBaseURL(base_url)
  end

  def restkit_object_manager
    @restkit_object_manager ||= RKObjectManager.sharedManager
  end

  def register_coffee_shop_mapping
    coffee_shops_descriptor = RKRequestDescriptor.requestDescriptorWithMapping(coffee_shop_mapping, objectClass:CoffeeShop, rootKeyPath:"coffee_shops")
    restkit_object_manager.addRequestDescriptor(coffee_shops_descriptor)
    coffee_shop_descriptor = RKRequestDescriptor.requestDescriptorWithMapping(coffee_shop_mapping, objectClass:CoffeeShop, rootKeyPath:"coffee_shop")
    restkit_object_manager.addRequestDescriptor(coffee_shop_descriptor)
  end

  def coffee_shop_mapping
    @coffee_shop_mapping ||= begin
                                mapping = RKObjectMapping.requestMapping
                                mapping.addAttributeMappingsFromDictionary({
                                  "id" => "id",
                                  "latitude" => "latitude",
                                  "longitude" => "longitude",
                                  "name" => "name",
                                  "shot_count" => "shot_count",
                                })
                                mapping
                             end
  end
end
