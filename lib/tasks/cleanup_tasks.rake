desc "Clean up Fancy Uploads older than 15 minutes"
task :cleanup_fancy_uploads => :environment do
  
  FancyUpload.find(:all).each do |fu|
    range = 15 * 60
    diff =  Time.now.to_i - fu.created_at.to_i    
    if diff > range
			puts fu.inspect
      fu.destroy
    end
  end
  
end
