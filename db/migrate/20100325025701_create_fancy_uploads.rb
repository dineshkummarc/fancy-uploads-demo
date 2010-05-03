class CreateFancyUploads < ActiveRecord::Migration
  def self.up    
    drop_table :fancy_uploads if self.table_exists?("fancy_uploads")
    create_table :fancy_uploads do |t|
      t.references :attachable
      t.string :attachable_type
      t.string :attached_upload_file_name
      t.string :attached_upload_content_type
      t.integer :attached_upload_file_size
      t.string :label
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :fancy_uploads
  end    
end
