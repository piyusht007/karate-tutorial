@ignore
Feature: Create products

  Background:
    # Test case inputs
    * def companyId = __arg.companyId
    * def product = __arg.product
    * def price = __arg.price

    # This is just to showcase how a file can be read
    * def products = read('products.txt')
    * print products

    # Paths
    * def createProductsEndpoint = '/products'

    # Configs
    * configure retry = { count: 5, interval: 90000 }

  Scenario: Create a product by calling '/products' endpoint
    Given url baseUrl
    Given path createProductsEndpoint
    And request { companyId: #(companyId), product: #(product), price: #(price) }
    And header Accept = 'application/json'
    When method POST
    Then status 200
    And match response.message == 'Success'
    And def productId = response.id
    And print productId