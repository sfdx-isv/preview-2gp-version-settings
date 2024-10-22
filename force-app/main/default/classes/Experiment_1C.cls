public class Experiment_1C {
    /**
     * This will compile only after installing `ver 3.0 (1GP)` or greater.
     */
    public List<v_provider_test__Custom_Object__c> methodOne() {
        List<v_provider_test__Custom_Object__c> customObjects = [SELECT ID, Name, v_provider_test__Custom_Field_1__c FROM v_provider_test__Custom_Object__c];
        return customObjects;
    }

    /**
     * This will compile only after installing `ver 3.0 (1GP)` or greater.
     */
    public Integer methodTwo() {
        v_provider_test.GlobalConcreteTwo gc2 = new v_provider_test.GlobalConcreteTwo();
        return gc2.methodAltTwo(10, 'any string');
    }
    
	// Constructor
    public Experiment_1C() {
        /**
         * This will never show any results unless records are inserted into the org.
         */
        System.debug('this.methodOne()--->' + this.methodOne());
        /**
         * Expected behavior by installed package version.
         * This is a PROXY for `methodAltTwo()` from `GlobalConcreteTwo`
         * 3.0 - Returns 300
         * 4.0 - Returns 400
         * 5.0 - DEPRECATED, but set to return 500
         * 6.0 - DEPRECATED, but set to return 600
         */
        System.debug('this.methodTwo()--->' + this.methodTwo());
    }   
}