// Appears in ver 3.0
global class GlobalConcreteTwo {
    // Concrete methods.
    // Appears in ver 3.0 - returns 'customObjects--><Record_List>'
    // Modified in ver 4.0 - returns 'No soup for you!'
    global String methodAltOne(Integer arg2) {
        List<Custom_Object__c> customObjects = [SELECT ID, Name, Custom_Field_1__c FROM Custom_Object__c];
        String retVal = 'No soup for you!';
        System.Debug(retVal);
        return retVal;
    }
    // Appears in ver 3.0 - returns 300
    // Modified in ver 4.0 - returns 400
    // Deprecated in ver 5.0 - returns 500
    // Modified in ver 6.0 - returns 600
    // Modified in ver 7.0 - Added logic to return previous values based on the package version.
    @Deprecated
    global Integer methodAltTwo(Integer arg1, String arg2) {
        // Get the package version
        Version pinnedVersion = System.requestVersion();
    
        // Check the package version and return the appropriate value
        switch on pinnedVersion.major() {
            when 3 {
                return 300;
            }
            when 4 {
                return 400;
            }
            when 5 {
                return 500;
            }
            when 6 {
                return 600;
            }
            when 7 {
                return 700;
            }
            when else {
                return -1; // Default return value
            }
        }
    }

    // Appears in ver 4.0 - returns 4000
    global Integer methodAltTwo() {
        return 4000;
    }
    
    // Appears in ver 4.0 - returns 'Hello from 4.0'
    global String methodAltThree(Boolean arg1) {
        return 'Hello from 4.0';
    }
    
    // Appears in ver 4.0 - returns 40000
    public Integer methodAltFour() {
        return 40000;
    }
        
    //----------------------------------------------------------------------------------------
    // Things I was allowed to do:
    //----------------------------------------------------------------------------------------
    // 1. Add a new global concrete method between ver 3.0 and ver 4.0.
    //    global String methodAltThree(Boolean arg1) {
    //        return 'Hello from 4.0';
    //    }
    //    
    // 2. Overload an existing concrete method between ver 3.0 and ver 4.0.
    //    global Integer methodAltTwo() {
    //        return 4000;
    //    }
    //    
	// 3. Add a new public concrete method between ver 3.0 and ver 4.0.
	//    public Integer methodAltFour() {
    //        return 40000;
    //    }
    //    
	// 4. Modify the return value of a concrete method deprecated in the previous version.
	//    @Deprecated
	//    global Integer methodAltTwo(Integer arg1, String arg2) {
    //        return 600;
    //    }
    //
    // 5. FOR 1GP - Add logic to return different values based on the package version.
    //    @Deprecated
    //    global Integer methodAltTwo(Integer arg1, String arg2) {
    //        // Get the package version
    //        Version pinnedVersion = System.requestVersion();
    //    
    //        // Check the package version and return the appropriate value
    //        switch on pinnedVersion.major() {
    //            when 3 {
    //                return 300;
    //            }
    //            ...
    //            when else {
    //                return 700; // Default return value
    //            }
    //        }
    //    }
    //    
    //----------------------------------------------------------------------------------------
    // Things I was NOT allowed to do
    //----------------------------------------------------------------------------------------
    // 1. Change the signature of a global concete method.
    //    global abstract String methodTwo(String arg1);
    //    Error: Global/WebService identifiers cannot be removed from managed application: Method String methodTwo(Boolean)
    //    Interpretation: Changing the signature of a global method is tantamount to deleting that method.
    //                    Also, note the use of the term "identifiers".  That's how the architects speak of this. They don't
    //                    talk about which package a CLASS appears in. They talk about which package an IDENTIFIER appears in.
    //    
    // 2. Change the name of a global concrete method.
    //    global Integer methodAltTwo_2(Integer arg1, String arg2) {
    //        return 400;
    //    }
	//    Error: Global/WebService identifiers cannot be removed from managed application: Method Integer methodAltTwo(Integer, String)
	//    Interpretation: Changing the name of a global identifer is tantamount to deleting that identifier.
    // 
    // 3. Add a new public abstract method.
    //    public abstract String publicMethodFive(Integer arg1);
    //    Error: global defined types requires that abstract methods must be declared as global
    //    Error: Defining type for abstract methods must be declared as abstract
    //    
    // 4. Add a new global abstract method.
    //    global abstract String methodFour(Boolean arg1, String arg2);
    //    Error: Defining type for abstract methods must be declared as abstract
    //    
    //----------------------------------------------------------------------------------------

}