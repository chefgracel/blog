Feature: Open the data extract page and download portfolio report

Scenario: Download portfolio report from data extract page
  Given I navigate to "https://qa.psuk.fluxtest.app/admin/smets_portfolio_reports/new"
  When I login as admin
  And I generate the report
  Then I can download
  When I extract the zip file name "/PS_*.zip"
  And I read the csv headers
  Then I verify the headers are same as file "Portfolio_Example.csv"
