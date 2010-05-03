if (typeof fancy_uploads_loaded == "undefined") {

  // No Conflict JQuery
  var $j = jQuery.noConflict();

  // fancy upload stylesheet
  var link = $j("<link/>").attr({
    href : "/fancy_uploads/stylesheets/fancy_uploads.css",
    rel : "stylesheet",
    type : "text/css",
    media : "screen",
    'class' : 'dynamic_css'
  }).appendTo("head");

  // jGrowl
  if (typeof $j.jGrowl == "undefined") {
    $j("<script>").attr({type : "text/javascript", src : "/fancy_uploads/javascripts/jquery.jgrowl_compressed.js"}).appendTo("head");
    $j("<link>").attr({
      href : "/fancy_uploads/stylesheets/jquery.jgrowl.css",
      rel : "stylesheet",
      type : "text/css",
      media : "screen",
      'class' : 'dynamic_css'
    }).appendTo("head");  
  }

  // fancybox
  if (typeof $j.fancybox == "undefined") {
    $j("<script>").attr({type : "text/javascript", src : "/fancy_uploads/javascripts/jquery.fancybox-1.3.1.pack.js"}).appendTo("head");
    $j("<link>").attr({
      href : "/fancy_uploads/stylesheets/jquery.fancybox-1.3.1.css",
      rel : "stylesheet",
      type : "text/css",
      media : "screen",
      'class' : 'dynamic_css'
    }).appendTo("head");
  }

  // IE does not recognize css files load via jquery 1.4.2, thus:
  if ($j.browser.msie) {
    $j('.dynamic_css').clone().appendTo("head");
  }

  // click interaction for new upload link
  $j("a.new_fancy_upload_link").live("click",function(){
    var $link = $j(this);
    $j.ajax({
      cache : true,
      async: true,
      timeout: 60 * 1000,
      dataType: "script",        
      url: $link.attr("href"), 
      beforeSend: function() {
        $link.parent().find("img.new_upload_spinner").show();
      },
      success: function() { 
        $link.parent().find("img.new_upload_spinner").hide();
      },  
      error: function(xhr, status, error_thrown) {
        // hide spinner
        $link.parent().find("img.new_upload_spinner").hide();
        $j.jGrowl("There was an error:<br/>" + xhr.status + ": " + xhr.statusText +  ".<br/>Please try reloading the page.");
      }   
    });
    return false;
  });    

  // live tracker for pagination links
  $j("div.pagination a").live("click", function(){
    var $link = $j(this);
    var $closest_container = $link.closest("div.fancy_uploads_container");  
    $j.ajax({
      type: "GET",
      cache : false,
      async: true,
      timeout: 60 * 1000,
      dataType: "script",        
      url: $link.attr("href"), 
      beforeSend: function() {
        $closest_container.find("div.add_new img.new_upload_spinner").show();
      },
      success: function() {
        $closest_container.find("div.add_new img.new_upload_spinner").hide();      
      },
      error: function(xhr, status, error_thrown) {
        // hide spinner
        $closest_container.find("div.add_new img.new_upload_spinner").hide();      
        $j.jGrowl("There was an error:<br/>" + xhr.status + ": " + xhr.statusText +  ".<br/>Please try reloading the page.");
      }   
    });
    return false;
  })


  // live tracker for sorting links
  $j("div.sorting_container a").live("click", function(){
    var $link = $j(this);
    var $closest_container = $link.closest("div.fancy_uploads_container");
    $j.ajax({
      type: "GET",
      cache : false,
      async: true,
      timeout: 60 * 1000,
      dataType: "script",        
      url: $link.attr("href"), 
      beforeSend: function() {
        $closest_container.find("div.add_new img.new_upload_spinner").show();
      },
      success: function() {
        $closest_container.find("div.add_new img.new_upload_spinner").hide();      
      },
      error: function(xhr, status, error_thrown) {
        // hide spinner
        $closest_container.find("div.add_new img.new_upload_spinner").hide();
        $j.jGrowl("There was an error:<br/>" + xhr.status + ": " + xhr.statusText +  ".<br/>Please try reloading the page.");
      }   
    });
    return false;
  })


  // keeping track of file upload update event
  $j("div.file_inputs").live("file_field_changed", function(e,val){
    val = val.replace("C:\\fakepath\\",""); // for IE
    if (val.length > 20) val = val.substring(0,10) + "..." + val.substring(val.length - 10, val.length);
    $j(this).find("input.fake_input").attr("value", val).css({ "border-bottom": "1px solid #ccc"});
  });

  // live tracker when the delete form is submitted
  $j("form.fu_delete_form").live("submit",function(e){
    var $f = $j(this);
    $f.find("img.delete").hide();
    $f.find("img.spinner").show();
    var form_data = $f.serialize();
    form_data = form_data.replace(/_method=put&/g,"");
    $j.ajax({
      cache : true,
      async: true,
      timeout: 60 * 1000,
      dataType: "script",
      type: "POST",
      data: form_data,
      url: $f.attr("action"), 
      error: function(xhr, status, error_thrown) {
        // hide spinner
        $f.find("img.delete").show();
        $f.find("img.spinner").hide();
        $j.jGrowl("There was an error:<br/>" + xhr.status + ": " + xhr.statusText +  ".<br/>Please try reloading the page.");
      }
    });
    return false;
  });

  // Live tracker when the upload interaction is to be shown, invoked and canceled
  $j("li.fancy_upload").live("show_upload_form", function() {
    var $list = $j(this);
    $list.find("div.uploaded_item").fadeOut("fast", function(){
      $list.find("form.upload_form").fadeIn();  
    });    
  }).live("start_upload", function(){
    var $upload_form = $j($j(this).find("form.upload_form")[0]);
    $upload_form.find(".spun").hide();
    $upload_form.find("img.spinner").show();
    $upload_form.submit();
  }).live("cancel_upload", function(){
    // if new, remove from the DOM
    var $list = $j(this);
    if ($list.find("div.uploaded_item").length > 0) {
      $list.find("form.upload_form").fadeOut("fast", function(){
        $list.find("div.uploaded_item").fadeIn();  
      });    
    }
    else {
      $list.fadeOut('fast', function(){ $j(this).remove(); });
    }  
  });
  
} /* End Fancy Uploads JS loads*/

var fancy_uploads_loaded = true;

