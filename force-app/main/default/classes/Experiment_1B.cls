public class Experiment_1B extends v_provider_test.GlobalAbstractOne {

    // Implement abstract method from the parent class.
    public override String methodTwo(Boolean arg1) {
        return 'Concrete implementation of methodTwo';
    }

    // Implement abstract method from the parent class.
    public override void methodThree() {
        System.debug('Concrete implementation of methodThree');
    }

    // Constructor
    public Experiment_1B() {
        /**
         * Expected behavior by installed package version.
         * 1.0 - Returns 1
         * 2.0 - Returns 2
         * 4.0 - Returns 4
         * 6.0 - Returns 6
         */
        System.debug('this.methodOne()--->' + this.methodOne('some string', 10));
        /**
         * Return value determined by the implementation in this class.
         */
        System.debug('this.methodTwo()--->' + this.methodTwo(true));
        /**
         * This method has no return value, but has behavior determined by the implementation in this class.
         */
        this.methodThree();
        /**
         * Expected behavior by installed package version.
         * 4.0 - Returns 400000
         * 6.0 - Returns 600000
         */
        System.debug('this.methodFour()--->' + this.methodFour(true));
    }
}