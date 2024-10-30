public class Experiment_3A {

    /**
     * Instantiates `GlobalConcreteOne` from the `v_provider_test` managed package.
     * This class is only available in `ver 2.0` and later of the managed package.
     */
    v_provider_test.GlobalConcreteOne gc1 = new v_provider_test.GlobalConcreteOne();

    /**
     * Instantiates `GlobalConcreteTwo` from the `v_provider_test` managed package.
     * This class is only available in `ver 3.0` and later of the managed package.
     */
    v_provider_test.GlobalConcreteTwo gc2 = new v_provider_test.GlobalConcreteTwo();
    
    // Constructor
    public Experiment_3A() {

        /**
         * Expected behavior by installed package version.
         * 2.0 - Returns 'String from methodOne() in ver 2.0'
         */
        System.debug('gc1.methodOne()--->' + gc1.methodOne(1));
        /**
         * Expected behavior by installed package version.
         * 2.0 - Returns 20
         */
        System.debug('gc1.methodTwo()--->' + gc1.methodTwo(2, 'some string'));
        /**
         * Expected behavior by installed package version.
         * 3.0 - Returns 'customObjects--><Record_List>'
         * 4.0 - Returns 'No soup for you!'
         */
        System.debug('gc2.methodAltOne()--->' + gc2.methodAltOne(10));
        /**
         * Expected behavior by installed package version.
         * 3.0 - Returns 300
         * 4.0 - Returns 400
         * 5.0 - DEPRECATED, but set to return 500
         * 6.0 - DEPRECATED, but set to return 600
         */
        System.debug('gc2.methodAltTwo()--->' + gc2.methodAltTwo(20, 'some string'));        
    }
    
}