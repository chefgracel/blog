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
    And I click on name "commit"
    And I wait until "File generated successfully." display
  }
end

Then("I can download") do
  steps %{
    And I click on link "Download"
  }
end
