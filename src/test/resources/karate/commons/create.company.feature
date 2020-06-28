@ignore
Feature: Create companies

  Background:
    # Test case inputs
    * def company = __arg.company
    * def region = __arg.region

    # Paths
    * def createCompanyPath = '/company'

    # Resolve company service URL based on the region using a javascript function defined
    # inside 'karate-config.js'
    * def companyServiceBaseURL = call getRegionalEndpoint region

    # Get company registration code as random UUID using another javascript function defined
    # inside 'karate-config.js'
    * def companyRegistrationCode = call randomUUID

    # Configs
    * configure retry = { count: 5, interval: 90000 }

  Scenario: Create a company by calling '/company' endpoint
    Given url companyServiceBaseURL
    Given path createCompanyPath
    And request { company: #(company), region: #(region), companyRegistrationCode: #(companyRegistrationCode) }
    And header Accept = 'application/json'
    When method POST
    Then status 200
    And match response.message == 'Success'
    And def companyId = response.id
    And print companyId