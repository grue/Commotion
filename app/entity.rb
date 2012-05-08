class Entity < NSManagedObject  
  include Persistable
  
  def self.inherited(subclass)
    subclass.instance_variable_set(:@attributes, [])
  end

  def self.entity
    @entity ||= begin
      entity = NSEntityDescription.alloc.init
      entity.name = self.name
      entity.managedObjectClassName = entity.name
      entity.properties = @attributes
      entity
    end
  end

  def self.field(name, options={})
    property = NSAttributeDescription.alloc.init
    property.name = name.to_s
    property.optional = false
          
    types = {
      String => NSStringAttributeType,
      Time   => NSDateAttributeType,
      Float  => NSFloatAttributeType
    }

    attributeType = types[options[:type]]
    if attributeType
      property.attributeType = attributeType
    else
      raise "Unknown field type: #{options[:type]}"
    end

    @attributes << property
  end
  
end
