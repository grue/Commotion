$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Commotion'
  app.frameworks += ['CoreData']
  app.files_dependencies 'app/entity.rb' => 'app/persistable.rb'
end
