Given("I login as admin") do
  steps %{
    And I enter "dev@powershop.co.nz" into "admin_email"
    And I enter "b3c4reful" into "admin_password"
    And I enter "netflixoriginal" into "admin_token"
    And I click on id "login_button"
    And I wait until "New Portfolio File" display
  }
end

When("I generate the report") do
  steps %{
    And I click on name "commit"}
    sleep 2
    @driver.navigate.refresh
    steps %{
    And I wait until "File generated successfully." display
  }
end

Then("I can download") do
  steps %{
    And I click on link "Download"
  }
  sleep 3
  file = @download_path + "/PS_*.zip"
  puts Dir[file.to_s]
  file = Dir[file.to_s][0]
  puts file
  require 'zip'
  Zip::File.open(file) { |zip_file|
     zip_file.each { |f|
     f_path=File.join(@download_path, f.name)
     FileUtils.mkdir_p(File.dirname(f_path))
     zip_file.extract(f, f_path) unless File.exist?(f_path)
   }
  }
end
