/**
 * Instantiate `Experiment_1A`, demonstrating subscriber Apex that
 * depends on concrete `global` Apex classes and methods.
 */
System.debug('');
System.debug('Executing Experiment_1A');
System.debug('');
Experiment_1A experiment_1A = new Experiment_1A();

/**
 * Instantiate `Experiment_1B`, demonstrating subscriber Apex that
 * extends an `abstract global` Apex class.
 */
System.debug('');
System.debug('Executing Experiment_1B');
System.debug('');
Experiment_1B experiment_1B = new Experiment_1B();

/**
 * Instantiate `Experiment_1C`, demonstrating subscriber Apex that
 * depends on custom schema that was added in `ver 3.0 (1GP)`.
 */
System.debug('');
System.debug('Executing Experiment_1C');
System.debug('');
Experiment_1C experiment_1C = new Experiment_1C();

System.debug('');