@integration-test
Feature: Product Tests

  Scenario: Create a company, ADD & REMOVE a product
    # Part-1
    * def companyArgs = { company : 'Patanjali', region: 'APAC' }
    # Calling another re-useable feature to create a company
    # Note: While calling a feature the arguments should be a json/array
    * def createCompanyFeatureResult = call read('../commons/create.company.feature') companyArgs

    # Part-2
    # Get the company id from above feature call and use it to create the product in subsequent feature call
    * def companyId = createCompanyFeatureResult.companyId
    * def featureArgs = { companyId: #(companyId), product: 'Ashwagandha Powder', price: 59 }
    * def createProductFeatureResult = call read('../commons/create.product.feature') featureArgs

    # Part-3
    # Get the product id from above feature call and use it to remove the product in subsequent feature call
    * def productId = createProductFeatureResult.productId
    * def removeProductFeatureResult = call read('../commons/remove.product.feature') { productId: #(productId) }

  # Not related to product, just to show how a file can be read, processed & written
  # This scenarios calls a javascript function 'replaceTextInFile' inside 'karate-config.js' which
  # in turn calls a Java function written inside 'TestUtils' class
  Scenario: Read a file, replace some words, write it back
    * def replaceWith = 40
    * def result = call replaceTextInFile { filePath: 'karate/product/products.txt', toBeReplaced: 'PRICE', replaceWith: #(replaceWith) }