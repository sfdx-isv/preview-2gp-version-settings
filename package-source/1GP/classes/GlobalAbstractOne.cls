// Appears in ver 1.0
// Deprecated in ver 5.0
@Deprecated
global abstract class GlobalAbstractOne {
    // Final methods.
    // Appears in ver 1.0 - returns 1
    // Modified in ver 2.0 - returns 2
    // Modified in ver 4.0 - returns 4
    // Modified in ver 6.0 - returns 6
    global Integer methodOne(String arg1, Integer arg2) {
        // Modified in ver 4.0 - Added a SOQL Query referencing Custom_Field_2__c
        List<Custom_Object__c> customObjects = [SELECT ID, Name, Custom_Field_2__c FROM Custom_Object__c];

        return 6;       
    }

    // Appears in ver 2.0 - returns 'String result from publicMethodFour()'
    public String publicMethodFour(Integer arg1, String arg2, Boolean arg3) {
        return 'String result from publicMethodFour()';
    }
    
    // Abstract methods.
    // Appears in ver 1.0
    global abstract String methodTwo(Boolean arg1);
    // Appears in ver 1.0
    global abstract void methodThree();

    // Virtual methods.
    // Appears in ver 4.0 - returns 400000
    // Modified in ver 6.0 - returns 600000
    global virtual Integer methodFour(Boolean arg1) {
        // Simple implementation that clients can override
        return 600000;
    }
    
    //----------------------------------------------------------------------------------------
    // Things I was allowed to do:
    // 1. Add a new public final method.
    //    public String publicMethodFour(Integer arg1, String arg2, Boolean arg3) {
    //        return 'String result from publicMethodFour()';
    //    }
    //    
    // 2. Add a new global virtual method.
    //    global virtual Integer methodFour(Boolean arg1) {
    //        return 400000;
    //    }
    //    
    // 3. Modify the return value of a concrete method AFTER the class was deprecated.
    //    global Integer methodOne(String arg1, Integer arg2) {
    //        // Modified in ver 4.0 - Added a SOQL Query referencing Custom_Field_2__c
    //        List<Custom_Object__c> customObjects = [SELECT ID, Name, Custom_Field_2__c FROM Custom_Object__c];
    //
    //        return 6;       
    //    }
    //    
    // 4. Modify the return value of a virtual method AFTER the class was deprecated.
    //    global virtual Integer methodFour(Boolean arg1) {
    //        return 600000;
    //    }
    //----------------------------------------------------------------------------------------
    // Things I was NOT allowed to do
    // 1. Add a new public abstract method.
    //    public abstract String publicMethodFive(Integer arg1);
    //    Error: global defined types requires that abstract methods must be declared as global
    //    Interpretation: Global abstract classes can be extended by subscribers, but that would be impossible if any of the
    //                    abstract methods aren't global becuase the subscriber wouldn't be able to see them to override them.
    //    
    // 2. Add a new global abstract method.
    //    global abstract String methodFour(Boolean arg1, String arg2);
    //    Error: Cannot add new final methods to virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodFour(Boolean, String)
    //    Error: Cannot add new abstract methods to interface or virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodFour(Boolean, String)
    //    Interpretation: This one surprised me because I thought it was one of the main use cases solved by Apex version pinning. It makes sense, though, because
    //                    adding a new abstract method would guarantee a compile failure in any subscriber org that extended this class. The subscriber couldn't 
    //                    implement an override for the new method before package upgrade, and the compile check during package upgrade would fail because the 
    //                    class being extended would have abstract methods that are not implemented.
    //                    
    // 3. Change the signature of a global abstract method.
    //    global abstract String methodTwo(String arg1);
    //    Error: Global/WebService identifiers cannot be removed from managed application: Method String methodTwo(Boolean)
    //    Interpretation: Changing the signature of a global method is tantamount to deleting that method.
    //                    Also, note the use of the term "identifiers".  That's how the architects speak of this. They don't
    //                    talk about which package a CLASS appears in. They talk about which package an IDENTIFIER appears in.
    //    
    // 4. Add a new global concrete method.
    //    global String methodFour(Boolean arg1, String arg2) {
    //        return 'Some String';
    //    }
    //    Error: Cannot add new final methods to virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodFour(Boolean, String)
    //    Interpretation: Honestly, this one surprised me. In non-abstract global classes we can add new Global methods.  How is that different from
    //                    adding a new global concrete method in a global abstract class?  Phil W. had the same question in a 2019 stackexchange thread.
    //    
    // 5. Overload an existing concrete method.
    //     global String methodOne(Boolean arg1, String arg2) {
    //         return 'Some String';
    //     }
    //     Error: Cannot add new final methods to virtual or abstract classes: String v_provider_test.GlobalAbstractOne.methodOne(Boolean, String)
    //     Interpretation: Same problem as above since overloading a concrete method is the same as adding a new method.
    //     
    //----------------------------------------------------------------------------------------

}