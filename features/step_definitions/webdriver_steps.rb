require 'selenium-webdriver'


# def force_stop!
#   @driver.first(:tag_name => 'body').send_keys(:escape) rescue nil
# end
def page_text
  text = @driver.page_source
end

def click(element)
  element.click
end

def find_element_id(id)
  @driver.find_element(:id, id)
end

def find_element_name(name)
  @driver.find_element(:name, name)
end

def waiting_for(event_description, **options, &block)
  Selenium::WebDriver::Wait.new(options.reverse_merge(
    :timeout => 30,
    :message => "timed out waiting for #{event_description}",
    :ignore => [Selenium::WebDriver::Error::NoSuchElementError]
  )).until(&block)
end

Given("I navigate to {string}") do |path|
  # force_stop!
  @driver.navigate.to "#{path}"
end


When("I click on id {string}") do |id|
  click find_element_id(id)
end

When("I click on name {string}") do |name|
  click find_element_name(name)
end

And("I click on link {string}") do |link|
  click @driver.find_element(:link_text, link)
end

When("I enter {string} into {string}") do |text,id|
  find_element_id(id).send_keys text
end

And("I wait until {string} display") do |text|
  waiting_for("the text '#{text}' to show up") do
    t = page_text
    t && t.include?(text)
  end
end

Then("I should see {string}") do |string|

end

And("pause") do
  STDOUT.puts "Hit Enter to continue..."
  STDIN.gets
end
