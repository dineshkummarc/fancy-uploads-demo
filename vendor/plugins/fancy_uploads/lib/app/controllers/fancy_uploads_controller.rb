class FancyUploadsController < ActionController::Base  
  
  # located in PLUGIN_ROOT/lib/app/views/layouts
  layout 'fancy_uploads' 

  # View location
  # PLUGIN_ROOT/lib/app/views/fancy_uploads/index.html.haml   
  #
  def index
    render :text => "Welcome to fancy uploads."
  rescue => ex
    ex_handler(ex)    
  end
  
  def show    
    @attachable = eval "#{params[:klass]}.find(#{params[:id]})"
    @upload_model_name = params[:upload_model].underscore        
    @page_number = (params[:page].nil? || params[:page] == "") ? 1 : params[:page].to_i
    @sort_field = (params[:sort].nil? || params[:sort] == "") ? "updated_at" : params[:sort]
    @per_page = params[:per_page]
    @fancy_uploads = eval("#{params[:upload_model]}.fancy_uploads(@attachable, @page_number, @sort_field, @per_page)")
  rescue => ex
    ex_handler(ex)
  end
  
  def new
    @attachable = eval "#{params[:klass]}.find(#{params[:id]})"
    upload_model_name = params[:upload_model].underscore    
    raise "Couldn't find a valid attachable object for fancy upload" if @attachable.nil?
    unless (@attachable.respond_to?(upload_model_name) or @attachable.respond_to?(upload_model_name.pluralize))
      raise "#{params[:upload_model]} is not associated with #{params[:klass]}. Please update your model associations."
    end
    if @attachable.respond_to?upload_model_name and eval("!@attachable.#{upload_model_name}.nil?")
      raise "There is restriction to attaching only one upload to this resource."
    end    
    @fancy_upload = eval "#{params[:upload_model]}.new(:attachable => @attachable)"
  rescue => ex
    ex_handler(ex)
  end
    
  def create
    # path = `echo $PATH`.chomp
    # raise path
    fancy_upload = eval "#{params[:dom][:upload_model]}.new()"
    fancy_upload_params = params[fancy_upload.class.to_s.underscore.to_sym]
    fancy_upload.update_attributes!(fancy_upload_params)
    responds_to_parent do
      render :update do |page|
        content = ActiveSupport::JSON.encode(render :partial => "fancy_uploads/fancy_upload", :locals => { :fancy_upload => fancy_upload })
        page << "$j('##{params[:dom][:dom_id]}').replaceWith(#{content})"
        page << "$j('a.fancybox_image').fancybox();"        
      end
    end
  rescue => ex
    responds_to_parent do
      render :update do |page|
        page << growl(ex.message, type = "error")
        page << "$j('##{params[:dom][:dom_id]}').find('img.spinner').hide();"
        page << "$j('##{params[:dom][:dom_id]}').find('img.spun').show();"        
      end
    end
  end

  def update
    fancy_upload = eval "#{params[:dom][:upload_model]}.find(params[:id])"
    fancy_upload.update_attributes!(params[fancy_upload.class.to_s.underscore.to_sym])    
    responds_to_parent do
      render :update do |page|
        content = ActiveSupport::JSON.encode(render :partial => "fancy_uploads/fancy_upload", :locals => { :fancy_upload => fancy_upload })
        page << "$j('##{params[:dom][:dom_id]}').replaceWith(#{content})"
        page << "$j('a.fancybox_image').fancybox();"        
      end
    end
  rescue => ex
    responds_to_parent do
      render :update do |page|
        page << growl(ex.message, type = "error")
        page << "$j('##{params[:dom][:dom_id]}').find('img.spinner').hide();"
        page << "$j('##{params[:dom][:dom_id]}').find('img.spun').show();"        
      end
    end
  end
  
  def destroy
    @fancy_upload = FancyUpload.find(params[:id])
    @attachable = @fancy_upload.attachable
    @fancy_upload.destroy
  rescue => ex
    ex_handler(ex)
  end

  private 
  
  def ex_handler(ex)
    @ex = ex
    #logger.error "**[ERROR]** #{Time.now}::#{self.class}::[#{__LINE__}]:: - #{@ex.backtrace.join("\n")}"
    logger.error "**[ERROR]** #{Time.now}::#{self.class}::[#{__LINE__}]:: - #{@ex.message}"    
    respond_to do |wants|
      wants.js { render :template => "fancy_uploads/ex_handler" }
      wants.html { render :template => "fancy_uploads/ex_handler" }          
    end
  end
    
end