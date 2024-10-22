public class SubscriberClass02 extends v_provider_test.GlobalAbstractOne {

    // Implement abstract methods from the parent class.
    public override String methodTwo(Boolean arg1) {
        return 'Concrete implementation of methodTwo';
    }

    public override void methodThree() {
        System.debug('Concrete implementation of methodThree');
    }
        
    // Instantiate managed global classes.
    v_provider_test.GlobalConcreteOne gc1 = new v_provider_test.GlobalConcreteOne();
    v_provider_test.GlobalConcreteTwo gc2 = new v_provider_test.GlobalConcreteTwo();
    
	// Constructor
    public SubscriberClass02_1GP() {

        // Call methods from gc1.
        System.debug('gc1.methodOne()--->' + gc1.methodOne(1));
        System.debug('gc1.methodTwo()--->' + gc1.methodTwo(2, 'some string'));

        // Call methods from gc2.
        System.debug('gc2.methodAltOne()--->' + gc2.methodAltOne(10));
        System.debug('gc2.methodAltTwo()--->' + gc2.methodAltTwo(20, 'some string'));        
    }
    
}