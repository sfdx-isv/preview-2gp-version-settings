@isTest
private class ConcreteClassTwoTest {
    
    @isTest static void testMethodOne() {
        // Instantiate the class
        ConcreteClassTwo obj = new ConcreteClassTwo();
        
        // Call the method and assert the expected result
        String result = obj.methodOne(true);
        Assert.isTrue(result.startsWith('customObjects-->'), 'The method should start with the expected value');
    }

    @isTest static void testMethodTwo() {
        // Instantiate the class
        ConcreteClassTwo obj = new ConcreteClassTwo();
        
        // Call the method and assert the expected result
        obj.methodTwo();
    }

}