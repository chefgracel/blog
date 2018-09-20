# Set up webdriver
require 'selenium-webdriver'


def start_browser
  path = File.dirname(__FILE__)
  # path = File.join(File.dirname(__FILE__), '../downloads/')
  download_path = path.to_s
  puts download_path
  # Dir.mkdir(download_path) unless Dir.exist?(download_path)
  # begin
  #
  #   old_umask = File.umask
  #   puts old_umask
  #   File.umask 0
  #   Dir.mkdir(download_path) unless Dir.exist?(download_path)
  #   puts File.stat(download_path).mode.to_s(8)
  # ensure
  #   File.umask old_umask
  #   puts File.umask
  # end

  prefs = {
  prompt_for_download: false,
  default_directory: download_path
  }
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference(:download, prefs)
  @driver = Selenium::WebDriver.for :chrome, options: options
end

Before do
  start_browser
end
#
# at_exit do
#   # @driver.quit
# end
