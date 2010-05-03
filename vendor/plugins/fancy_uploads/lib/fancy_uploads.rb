# 3rd party plugins
#
['haml', 'paperclip', 'responds_to_parent', 'will_paginate'].each do |lib| 
  begin
    require lib
  rescue LoadError => ex
    raise "Error loading #{lib} plugin: #{ex.message}"
  end
end

# Local dependencies
#
require 'routing'

# Fancy Uploads Plugin Load
#
%w{ models controllers helpers }.each do  |dir| 
  path = File.join(File.dirname(__FILE__), 'app', dir)  
  $LOAD_PATH << path 
  ActiveSupport::Dependencies.load_paths << path 
  ActiveSupport::Dependencies.load_once_paths.delete(path)  
end 

# Adding custom routes for fancy uploads
# Just add 'map.fancy_upload_routes' to your RAILS_ROOT/config/routes.rb file
# And verify with rake routes if you so wish!
#
ActionController::Routing::RouteSet::Mapper.send :include, FancyUploads::Routing::MapperExtensions

# Add the view path for this controller
#
ActionController::Base.append_view_path File.join(File.dirname(__FILE__), 'app', 'views')  

# Hooks view helper to the ActionView.Base
#
require 'app/helpers/view_helpers'
ActionView::Base.send :include, FancyUploads::ViewHelpers
