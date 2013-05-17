class Server
  # singleton
  def self.instance
    Dispatch.once { @instance ||= new }
    @instance
  end
  private_class_method :new

  def initialize
    initialize_restkit
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
end
