require 'selenium-webdriver'

# def force_stop!
#   @driver.first(:tag_name => 'body').send_keys(:escape) rescue nil
# end

Given("I navigate to {string}") do |path|
  # force_stop!
  @driver.navigate.to "#{path}"
end
