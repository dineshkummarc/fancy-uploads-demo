module FancyUploads
  module ViewHelpers
    FANCY_UPLOADS_IMAGE_PATH = "/fancy_uploads/images"     
    FANCY_UPLOADS_ICON_PATH = "#{FANCY_UPLOADS_IMAGE_PATH}/icons/32x32" 

    # takes an object and determines 
    # if it's a boolean class
    #
    def fu_boolean_class?(object)
      !object.nil? and ((object.is_a? TrueClass) or (object.is_a? FalseClass))
    end    

    def fu_add_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Add.png", options
    end
    
    def fu_edit_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Stationery.png", options
    end
    
    def fu_delete_html(options = {})
      options[:mouseover] = "#{FANCY_UPLOADS_ICON_PATH}/Bin_Full.png"
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Bin_Empty.png", options
    end

    def fu_close_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Close.png", options
    end
        
    def fu_search_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Search.png", options
    end            
    
    def fu_save_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Floppy.png", options
    end

    def fu_info_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/Info.png", options
    end

    def fu_spinner_html(options = {})
      image_tag "#{FANCY_UPLOADS_ICON_PATH}/spinner.gif", options
    end

    def fu_file_html(options = {})      
      image_tag "#{FANCY_UPLOADS_IMAGE_PATH}/file.png", options      
    end
    
    def fu_audio_html(options = {})
      image_tag "#{FANCY_UPLOADS_IMAGE_PATH}/audio.png", options            
    end
    
    def fu_pic_html(options = {})
      image_tag "#{FANCY_UPLOADS_IMAGE_PATH}/picture.png", options      
    end
    
    def fu_video_html(options = {})
      image_tag "#{FANCY_UPLOADS_IMAGE_PATH}/video.png", options      
    end    
            
    def fancy_uploads(attachable_object = nil, options = {})
     # Set up the options
     options[:include_jquery] = true if !options.has_key?:include_jquery
     options[:new_upload_label] = "New Upload" if !options.has_key?:new_upload_label
     options[:upload_model] = "FancyUpload" if !options.has_key?:upload_model
     options[:upload_model_us] = options[:upload_model].underscore
     options[:per_page] = FancyUpload.per_page if !options.has_key?:per_page
 
     if attachable_object.nil? || 
       ((!attachable_object.respond_to?options[:upload_model_us].pluralize) && (!attachable_object.respond_to?options[:upload_model_us]))
       return %(
        <div style="color:maroon">
          Unable to render fancy_uploads view helper! For one of the following reasons:
          <ul>
            <li>The Attachable Object wasn't provided as the argument</li>
            <li>The Attachable Object's Model doesn't have any relations declared with FancyUpload Model</li>
          </ul>
        </div>
       )
     end
     render :partial => "fancy_uploads/fancy_uploads", :locals => { :attachable_object => attachable_object, :options => options }
    end

  end  
end