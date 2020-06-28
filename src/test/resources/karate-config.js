function fn() {

    var config = {
        baseUrl: karate.properties['product.service.base.url'],
        randomUUID: function() {
            return java.util.UUID.randomUUID();
        },
        getRegionalEndpoint: function (region) {
            if (region === 'APAC') {
                return 'http://some-company-apac.com/company-service';
            } else {
                return 'http://some-company-row.com/company-service';
            }
        },
        replaceTextInFile: function (args) {
            var TestUtils = Java.type('karate.TestUtils');
            print(args.filePath + ", " + args.toBeReplaced + ", " + args.replaceWith);
            return TestUtils.replace(args.filePath, args.toBeReplaced, args.replaceWith);
        }
    };

    return config;
}