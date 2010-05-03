create_table :fancy_uploads, :force => true do |t|
  t.references :attachable
  t.string :attachable_type
  t.string :attached_upload_file_name
  t.string :attached_upload_content_type
  t.integer :attached_upload_file_size
  t.string :label
  t.string :type
end