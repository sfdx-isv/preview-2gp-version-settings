// Appears in ver 1.0
public class ConcreteClassOne extends GlobalAbstractOne {

    // Appears in ver 1.0 - returns 'Concrete implementation of methodTwo'
    public override String methodTwo(Boolean arg1) {
        // Appears in ver 4.0
        String result = super.publicMethodFour(1, 'two', true);

        // Appears in ver 1.0
        return 'Concrete implementation of methodTwo';
    }

    // Appears in ver 1.0 - returns void
    public override void methodThree() {
        System.debug('Concrete implementation of methodThree');
    }
}