require 'simplecov'
require 'selenium-webdriver'
require 'fileutils'

SimpleCov.start

current_dir = FileUtils.pwd
dummy_video_path = File.join(current_dir, 'storage', 'dummy_video.mp4')

options = ::Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-gpu')
options.add_argument('--remote-debugin-port=9222')
options.add_argument('--screen-size=1200x800')

Before do |_scenario|
  @browser = Selenium::WebDriver.for(:chrome, options:)
  @login_url = 'http://localhost:8080'
  @bad_file_type_loc = File.join(current_dir, 'storage', 'supplementary_video.jpg')
  @dummy_file_loc = dummy_video_path
  @good_file_loc = File.join(current_dir, 'storage', 'supplementary_video.mp4')
  FileUtils.touch(dummy_video_path)
end

After do |_scenario|
  @browser.quit
  FileUtils.rm(dummy_video_path)
end

# TODO: only create and delete dummy file for corrupted test case
