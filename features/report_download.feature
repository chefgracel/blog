Feature: Open the data extract page and download portfolio report

Scenario: Download portfolio report from data extract page
  Given I navigate to "https://qa.psuk.fluxtest.app/admin/smets_portfolio_reports/new"
  And I login as admin
  And I generate the report
  Then I can download
