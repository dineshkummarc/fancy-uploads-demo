module FancyUploadsHelper
  
  def title(title)
    content_for(:title) { title }
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  # A helper method for growling
  #
  def growl(msg="just growlin",type="default")
    if type == "error"
      msg = "<div style=\"color:yellow\">#{msg}</div>"
      sticky = "true"
    else
      sticky = "false"
    end    
    "try { $j.jGrowl('#{escape_javascript(msg)}', { sticky : #{sticky}}) } catch(ex) {} "
  end
  
  # Removes any growl elements from the UI
  #
  def growl_reset
    "try { $j('div.jGrowl-notification').hide(); } catch(ex) {}"
  end
    
end