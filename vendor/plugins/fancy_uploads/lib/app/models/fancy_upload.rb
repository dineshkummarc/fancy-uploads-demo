class FancyUpload < ActiveRecord::Base

  # relations
  belongs_to :attachable, :polymorphic => true

  # hooks
  before_create :apply_create_timestamp
  before_save :apply_update_timestamp

  # before creation, apply the timestamps
  def apply_create_timestamp
    created_at = Time.now
    updated_at = Time.now
  end
  
  # before save, apply the update timestamp
  def apply_update_timestamp
    updated_at = Time.now
  end

  # paperclip setup
  has_attached_file :attached_upload, 
    :styles => { :thumb => "128x128#" , :small => "256x256>", :medium => "600x600>" },
    :url => "/uploads/:class/:attachment/:id/:style.:extension",
    :path => ":rails_root/public/uploads/:class/:attachment/:id/:style.:extension",
    :whiny => false
  validates_attachment_size :attached_upload, :in => 1..500.kilobytes
  validates_attachment_presence :attached_upload

  # association validates
  validates_presence_of :attachable

  # pagination setup
  cattr_reader :per_page
  @@per_page = 20
  
  # gets a paginated list of the fancy uploads  
  def self.fancy_uploads(attachable, page = 1, sort = "updated_at", per_page = @@per_page)
    filter_options = { 
      :conditions => ['attachable_id = ?', attachable.id], 
      :order => "#{sort} DESC", 
      :include => :attachable,
      :page => page,
      :per_page => per_page
    }
    self.paginate filter_options
  end
  
  # gives the url of the upload
  def url(version=nil)
    attached_upload.url(version)
  end
  
  # gives the absolute path of the upload
  def path(version=nil)
    attached_upload.path(version)
  end

  # gets the original filename of the upload
  # optionally, you may pass a boolean parameter
  # to shorten the
  def filename(short=true)
    if short
      attached_upload_file_name.length > 15 ? attached_upload_file_name[0,10] + "..." + attached_upload_file_name[attached_upload_file_name.length - 5, attached_upload_file_name.length] : attached_upload_file_name
    else
      attached_upload_file_name
    end
  end
  
  # gets the file-type of the upload
  def filetype
    attached_upload_content_type
  end
  
  # determines if the file-type is an image file
  def is_image?
    attached_upload_content_type =~ /image/i ? true : false
  end
  
  # determines if the file-type is an audio file
  def is_audio?
    attached_upload_content_type =~ /audio/i ? true : false
  end

  # determines if the file-type is a video file
  def is_video?
    attached_upload_content_type =~ /video/i ? true : false
  end
    
end
