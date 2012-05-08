class CoreDataStack
  def self.shared
    @stack ||= CoreDataStack.new
  end
  
  def context
    return @context if @context

    @context = NSManagedObjectContext.alloc.init
    @context.persistentStoreCoordinator = persistent_store_coordinator
    @context
  end

  def managed_object_model  
    return @model if @model
    
    @model = NSManagedObjectModel.alloc.init

    # TODO: Needs to be dynamic
    @model.entities = [Movie.entity, Song.entity]

    @model
  end

  def persistent_store_coordinator  
    return @store if @store
    
    @store = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(managed_object_model)

    error_ptr = Pointer.new(:object)
    unless @store.addPersistentStoreWithType(NSSQLiteStoreType, configuration:nil, URL:storeURL, options:nil, error:error_ptr)
      raise "Can't add persistent SQLite store: #{error_ptr[0].description}"
    end
  
    @store
  end

  def storeURL
    NSURL.fileURLWithPath(File.join(NSHomeDirectory(), 'Documents', 'Data.sqlite'))
  end
  
end