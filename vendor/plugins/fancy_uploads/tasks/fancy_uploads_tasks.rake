require RAILS_ROOT + "/config/environment"
require 'fileutils'

module Tty extend self
  def blue; bold 34; end
  def white; bold 39; end
  def red; underline 31; end
  def reset; escape 0; end
  def bold n; escape "1;#{n}" end
  def underline n; escape "4;#{n}" end
  def escape n; "\033[#{n}m" if STDOUT.tty? end
end

namespace :fancy_uploads do
  desc "Sets up fancy uploads to your Rails 2.x.x app"
  task :setup do
    Rake::Task["fancy_uploads:migrate_model"].invoke
    Rake::Task["fancy_uploads:setup_public_dir"].invoke
  end
  
  desc "Copies over the stylesheeets and javascripts needed for fancy uploads to the RAILS_ROOT/public directory"
  task :setup_public_dir do
    puts "#{Tty.blue}** #{Tty.reset} Setting up fancy uploads in the #{RAILS_ROOT}/public directory."
    src_dir = "#{RAILS_ROOT}/vendor/plugins/fancy_uploads/lib/public"
    dest_dir = "#{RAILS_ROOT}/public/fancy_uploads"    
    if File.exists?(dest_dir)
      print "#{Tty.red}** Warning **#{Tty.reset} #{dest_dir} exists. Proceeding will remove that directory before setting it up again. (Y/N): "
      response = STDIN.gets
      Process.exit if response =~ /n/i or response !~ /y/i
      FileUtils.rm_rf dest_dir, :verbose => true
    end  
    FileUtils.cp_r src_dir, dest_dir, :verbose => true
    puts "#{Tty.blue}** #{Tty.reset} Fancy uploads public directory setup: #{dest_dir}"        
  end

  desc "Copies the Fancy Uploads Model migration file to the rails app's migration directory"  
  task :migrate_model do    
    puts "#{Tty.blue}** #{Tty.reset} Copying fancy uploads model migration to #{RAILS_ROOT}/db/migrate."
    src_file = "20100325025701_create_fancy_uploads.rb"
    src_dir = "#{RAILS_ROOT}/vendor/plugins/fancy_uploads/lib/db/migrate"
    dest_dir = "#{RAILS_ROOT}/db/migrate"
    
    if File.exists?("#{dest_dir}/#{src_file}")
      print "#{Tty.red}** Warning **#{Tty.reset} #{dest_dir}/#{src_file} exists. Proceeding will remove that file before setting it up again. (Y/N): "
      response = STDIN.gets
      Process.exit if response =~ /n/i or response !~ /y/i
      FileUtils.rm "#{dest_dir}/#{src_file}", :verbose => true      
    end    
    FileUtils.cp "#{src_dir}/#{src_file}", dest_dir, :verbose => true 
    puts "Fancy uploads migration file copied to: #{dest_dir}"
    puts "#{Tty.blue}** Hint ** #{Tty.reset} Run rake db:migrate at this point!"    
  end
end  
