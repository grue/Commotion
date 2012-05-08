module Persistable
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  def save
    self.class.save
  end
  
  def destroy
    self.class.destroy(self)
  end
    
  module ClassMethods
    def context
      CoreDataStack.shared.context
    end
  
    def create
      entity = NSEntityDescription.insertNewObjectForEntityForName(self.to_s, inManagedObjectContext:self.context)
      yield entity
      entity.createdAt = Time.now if entity.respond_to?(:createdAt)
      save
    end
  
    def save
      error_ptr = Pointer.new(:object)
      unless self.context.save(error_ptr)
        raise "Error when saving the model: #{error_ptr[0].description}"
      end
    end
    
    def destroy(entity)
      self.context.deleteObject(entity)
      save
    end
    
    def find(attribute, value)
      # TODO: Only works for strings!
      all("#{attribute} LIKE[c] '#{value}'").first
    end
  
    def all(query=nil, options={})
      request = NSFetchRequest.alloc.init
      request.entity = NSEntityDescription.entityForName(self.to_s, inManagedObjectContext:self.context)
      request.sortDescriptors = [NSSortDescriptor.alloc.initWithKey(options[:order] || 'createdAt', ascending:false)]
      if query
        request.predicate = NSPredicate.predicateWithFormat(query)
      end
      
      error_ptr = Pointer.new(:object)
      results = self.context.executeFetchRequest(request, error:error_ptr)
      if results == nil
        raise "Error when fetching results: #{error_ptr[0].description}"
      end
      results
    end
    
    def method_missing(method_name, *args, &block) 
      # TODO: This probably isn't a good idea as method_missing will
      # be slow, and define_method isn't available in RubyMotion
      string_name = method_name.to_s
      return super unless string_name =~ /^find_by_\w+/
      last_word = string_name.split('_').last
      args.unshift(last_word)
      send(:find, *args)
    end
  end
  
end
