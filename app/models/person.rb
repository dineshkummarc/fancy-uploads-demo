class Person < ActiveRecord::Base
  
  has_many :fancy_uploads, :as => :attachable
  
end
