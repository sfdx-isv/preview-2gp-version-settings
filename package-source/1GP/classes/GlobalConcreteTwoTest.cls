@isTest
private class GlobalConcreteTwoTest {
    
    @isTest static void testMethodAltOne() {
        // Instantiate the class
        GlobalConcreteTwo obj = new GlobalConcreteTwo();
        
        // Call the method and assert the expected result
        String result = obj.methodAltOne(1);
        Assert.isTrue(result.startsWith('No soup'), 'The method should start with the expected value');
    }

    @isTest static void testMethodAltTwo() {
        // Instantiate the class
        GlobalConcreteTwo obj = new GlobalConcreteTwo();
        
        // Call the method and assert the expected result
        System.runAs(new Version(7,0)) {
            Integer result = obj.methodAltTwo(1, 'some string');
            Assert.areEqual(700, result, 'The method should return the expected value');    
        }
        
        // Call the overloaded method and assert the expected result
        Integer result2 = obj.methodAltTwo();
        Assert.areEqual(4000, result2, 'The method should return the expected value');
    }

    @isTest static void testMethodAltThree() {
        // Instantiate the class
        GlobalConcreteTwo obj = new GlobalConcreteTwo();
        
        // Call the method and assert the expected result
        String result = obj.methodAltThree(true);
        Assert.isTrue(result.startsWith('Hello from 4.0'), 'The method should start with the expected value');
    }    
    
    @isTest static void testMethodAltFour() {
        // Instantiate the class
        GlobalConcreteTwo obj = new GlobalConcreteTwo();
        
        // Call the method and assert the expected result
        Integer result = obj.methodAltFour();
        Assert.areEqual(40000, result, 'The method should return the expected value');
    }
}