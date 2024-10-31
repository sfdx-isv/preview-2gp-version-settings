// Appears in ver 3.0
public class ConcreteClassTwo {
    
    // Appears in ver 3.0 - returns 'customObjects-->' + customObjects
    public String methodOne(Boolean arg1) {
        List<Custom_Object__c> customObjects = [SELECT ID, Name, Custom_Field_1__c FROM Custom_Object__c];
        String retVal = 'customObjects-->' + customObjects;
        System.Debug(retVal);
        return retVal;
    }

    // Appears in ver 3.0 - returns void
    public void methodTwo() {
        System.debug('Concrete implementation of methodThree');
    }
    
}