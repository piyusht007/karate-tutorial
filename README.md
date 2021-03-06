# karate-tutorial
A sample Spring Boot project to showcase API testing using Karate (https://github.com/intuit/karate) framework.

This project aims at helping you to setup up your first karate project in spring boot. The sole purpose of this project is to get one familiar with:
* Feature calling another features.
* Utility javascript functions.
* Re-useable feature files. (Refer to `commons` folder)
* Configure retries for API calls.
* Reading & Writing files.
* Call to Java methods. (Refer to `TestUtils.java` class)
* Karate parallel execution. (Refer to `TestParallel.java` class)
* Test HTML reports.

# Getting Started
We have following 3 APIs to test:

* **POST /company** - To create a Company
```json
{
    "company": "Patanjali",
    "region": "APAC",
    "companyRegistrationCode": "eb268a5e-9441-41a6-8974-f84d1914308d"
}
```
* **POST /products** - To create a Product
```json
{
    "companyId": 12345,
    "product": "Ashwgandha Powder",
    "price": 59
}
```
* **DELETE /products/{productId}** - To delete a Product

The feature files are inside `src/test/resources` folder as this is the default classpath location for non-java files in spring boot application.

We have a feature file `products.feature` which has 2 scenarios, first one is to create a company, add a product and remove the same product using aforementioned APIs.
`products.feature` makes use of the re-useable feature files, `create.company.feature`, `create.product.featrue` and `remove.product.feature` (These feature files are kept inside `commons` folder).

Second scenario is just there to showcase how a file can be read, processed & written back using a Java method defined 
inside `TestUtils.java`, this java method is being called from a javascript function defined inside `karate-config.js`.

Feature files are decorated with comments to explain the intentions.

**Note:** This project makes use of karate parallel execution scemantics which is being defined inside `TestParallel.java`

The feature files can be executed using a maven profile `karate-integration-tests`. See `pom.xml` for actual profile definition.

Following maven command will be used to run the feature files:

```shell script
mvn test -P karate-integration-tests -Dtest=TestParallel -Dproduct.service.base.url=<Actual_URL>
```

### Test Reports

This project uses `cucumber-reporting` maven plugin to generate the HTML & JSON reports from the `maven-surefire` xml reports.

To get these HTML reports in `jenkins` we need to install a jenkins plugin `Cucumber reports`. More information on this `jenkins` plugin can be found here:
* https://github.com/jenkinsci/cucumber-reports-plugin 
* https://plugins.jenkins.io/cucumber-reports/

To setup this plugin in `jenkins` following [blog](https://medium.com/faun/karate-cucumber-reports-integration-in-jenkins-3f0e617c8265) can also be looked at.

### Tips

* Conditionally calling a feature file:
``` 
* def shouldCallAnotherFeature = <someVariable/expression> ? true : false
* def anotherFeatureArgs = { param1: '#(param1)', param2: '#(param2)' }
* def anotherFeatureResult = shouldCallAnotherFeature ? karate.call('another.feature', anotherFeatureArgs) : 'No need to call another feature'
```

* Check contains using javascript function:
```
* def isMatched = function(a, b) { return a.indexOf(b) !== -1 }
* def result = isMatched('The beautiful mind', 'beautiful')
* print result
```

* Switch to appropriate defaults at the start of feature:
```
* def count = __arg.count ? __arg.count : 0
* def name = __arg.name ? __arg.name : 'NA'
```

* Javascript function to parse dynamic keys/properties names:
```
function getKeys(response) {
    for (key in response) {
        console.log('Key: ' + key + ', Value: ' + response[key]);
    }
}
```
We might encounter JSON where keys/properties names can be any id (uuid), number etc.. In those cases we can use above function to get those key names and get the respective key value. 

Example JSON:
```
{
	'e162b50e-7f0d-4d4c-8c75-8bbcaa51bafc': 'testValue',
	'9cbc301d-f320-48b7-b837-95eecb5f89cf': 'testValue'
}
```



