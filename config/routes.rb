ActionController::Routing::Routes.draw do |map|
  map.resources :people, :only => ["index","show"]
  map.fancy_upload_routes
  map.root    :controller => "people", :action => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
