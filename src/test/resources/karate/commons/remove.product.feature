@ignore
Feature: Remove products

  Background:
    # Test case inputs
    * def productId = __arg.productId

    # This is just to showcase how a file can be read
    * def products = read('products.txt')
    * print products

    # Paths
    * def removeProductsPath = '/products/'

    # Configs
    * configure retry = { count: 5, interval: 90000 }

  Scenario: Create a project by calling '/products' endpoint
    Given url baseUrl
    Given path removeProductsPath + productId
    And header Accept = 'application/json'
    When method DELETE
    Then status 200
    And match response.message == 'Success'