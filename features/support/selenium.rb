# Set up webdriver
require 'selenium-webdriver'

def start_browser
  @driver = Selenium::WebDriver.for :chrome
end

Before do
  start_browser
end

at_exit do
  # @driver.quit
end
