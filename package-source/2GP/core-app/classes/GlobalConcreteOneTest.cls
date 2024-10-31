// Appears in ver 2.0
@isTest
private class GlobalConcreteOneTest {
    @isTest static void testMethodOne() {
        // Instantiate the class
        GlobalConcreteOne obj = new GlobalConcreteOne();
        
        // Call the method and assert the expected result
        String result = obj.methodOne(1);
        Assert.areEqual('String from methodOne() in ver 2.0', result, 'The method should return the expected value');
    }

    @isTest static void testMethodTwo() {
        // Instantiate the class
        GlobalConcreteOne obj = new GlobalConcreteOne();
        
        // Call the method and assert the expected result
        Integer result = obj.methodTwo(1, 'some string');
        Assert.areEqual(20, result, 'The method should return the expected value');
    }

}