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

  def get(path, success = nil, failure = nil)
    restkit_object_manager.getObjectsAtPath(path, parameters: '', success: success, failure: failure)
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
    coffee_shops_descriptor = RKResponseDescriptor.responseDescriptorWithMapping(coffee_shop_mapping, pathPattern:nil, keyPath:"coffee_shops", statusCodes: NSIndexSet.indexSetWithIndex(200))
    restkit_object_manager.addResponseDescriptor(coffee_shops_descriptor)
    coffee_shop_descriptor = RKResponseDescriptor.responseDescriptorWithMapping(coffee_shop_mapping, pathPattern:nil, keyPath:"coffee_shop", statusCodes: NSIndexSet.indexSetWithIndex(200))
    restkit_object_manager.addResponseDescriptor(coffee_shop_descriptor)
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
