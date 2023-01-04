require 'simplecov'
require 'cucumber/rails'
require 'fileutils'

SimpleCov.start 'rails'

current_dir = FileUtils.pwd
dummy_video_path = File.join(current_dir, 'storage', 'dummy_video.mp4')

Before do |_scenario|
  @login_url = 'http://localhost:8080'
  @dummy_file_loc = dummy_video_path
  @good_file_loc = File.join(current_dir, 'storage', 'supplementary_video.mp4')
  FileUtils.touch(dummy_video_path)
end

After do |_scenario|
  FileUtils.rm(dummy_video_path)
end
