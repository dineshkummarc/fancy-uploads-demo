module FancyUploads #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions      
      def fancy_upload_routes
        self.fancy_uploads "/fancy_uploads", 
          { :controller => "fancy_uploads", :action => "index", :conditions => { :method => :get } }

        self.new_fancy_upload '/fancy_uploads/new/:klass/:id/:upload_model', 
          { :controller => 'fancy_uploads', :action => 'new', :conditions => { :method => :get } }

        self.show_fancy_uploads "/fancy_uploads/:klass/:id/:upload_model/:sort/:per_page", 
          { :controller => "fancy_uploads", :action => "show", :conditions => { :method => :get } }

        self.create_fancy_upload '/fancy_uploads/create', 
          { :controller => 'fancy_uploads', :action => 'create', :conditions => { :method => :post } }

        self.update_fancy_upload '/fancy_uploads/update/:id', 
          { :controller => 'fancy_uploads', :action => 'update', :conditions => { :method => :put } }

        self.destroy_fancy_upload '/fancy_uploads/destroy/:id', 
          { :controller => 'fancy_uploads', :action => 'destroy', :conditions => { :method => :delete } }          
      end
    end
  end
end