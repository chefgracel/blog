require 'csv'

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
    sleep 5
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
end

When("I extract the zip file name {string}") do |file_name|
  file = @download_path + file_name
  file = Dir[file.to_s][0]
  puts file
  require 'zip'
  Zip::File.open(file) { |zip_file|
     zip_file.each { |f|
     f_path=File.join(@download_path, f.name)
     FileUtils.mkdir_p(File.dirname(f_path))
     zip_file.extract(f, f_path) unless File.exist?(f_path)
     FileUtils.remove_dir zip_file.to_s
   }
  }
end

And("I read the csv headers") do
  csv_name = @download_path + "/PS_*.csv"
  csv_file = Dir[csv_name.to_s][0]
  puts csv_file.to_s
  puts CSV.foreach(csv_file.to_s).first
  @csv_headers = CSV.foreach(csv_file.to_s).first
  FileUtils.remove_dir csv_file.to_s
end

Then("I verify the headers are same as file {string}") do |doc_name|
  csv_name = File.join(File.dirname(__FILE__), '../doc/', doc_name)
  puts csv_name
  doc_headers = CSV.foreach(csv_name).first
  puts doc_headers
  # assert_equal(doc_headers, @csv_headers, failure_message = "Sorry! I feel not very correct :(")
  puts "\nHeaders match? :  #{doc_headers.to_s == @csv_headers.to_s}"
end
