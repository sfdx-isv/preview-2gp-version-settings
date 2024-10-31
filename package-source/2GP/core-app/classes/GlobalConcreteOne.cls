// Appears in ver 2.0
global class GlobalConcreteOne {
    // Concrete methods.
    // Appears in ver 2.0 - returns 'String from methodOne() in ver 2.0'
    global String methodOne(Integer arg2) {
        return 'String from methodOne() in ver 2.0';
    }
    // Appears in ver 2.0 - returns 20
    global Integer methodTwo(Integer arg1, String arg2) {
        return 20;
    }
    
// run these experiments after upload
    
    //----------------------------------------------------------------------------------------
    // Things I was allowed to do:
    // 1. Add a new public concrete method.
    //    public String publicMethodFour(Integer arg1, String arg2, Boolean arg3) {
    //        return 'String result from publicMethodFour()';
    //    }
    //----------------------------------------------------------------------------------------
    // Things I was NOT allowed to do
    // 1. Add a new public abstract method.
    //    public abstract String publicMethodFive(Integer arg1);
    //    Error: global defined types requires that abstract methods must be declared as global
    //    
    // 2. Add a new global abstract method.
    //    global abstract String methodFour(Boolean arg1, String arg2);
    //    Error: Cannot add new final methods to virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodFour(Boolean, String)
    //    Error: Cannot add new abstract methods to interface or virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodFour(Boolean, String)
    //    
    // 3. Add a new global concrete method.
    //    global String methodFour(Boolean arg1, String arg2) {
    //        return 'Some String';
    //    }
    //    Error: Cannot add new final methods to virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodFour(Boolean, String)
    //    
    // 4. Overload an existing concrete method.
    //     global String methodOne(Boolean arg1, String arg2) {
    //         return 'Some String';
    //     }
    //     Error: Cannot add new final methods to virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodOne(Boolean, String)
    //     
    // 5. Change the signature of a global abstract method.
    //    global abstract String methodTwo(String arg1);
    //    Error: Global/WebService identifiers cannot be removed from managed application: Method String methodTwo(Boolean)
    //----------------------------------------------------------------------------------------

}