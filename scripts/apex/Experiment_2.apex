/**
 * Instantiate `Experiment_2A`, demonstrating subscriber Apex that
 * depends on concrete `global` Apex classes and methods.
 */
System.debug('');
System.debug('Executing Experiment_2A');
System.debug('');
Experiment_2A experiment_2A = new Experiment_2A();

/**
 * Instantiate `Experiment_2B`, demonstrating subscriber Apex that
 * extends an `abstract global` Apex class.
 */
System.debug('');
System.debug('Executing Experiment_2B');
System.debug('');
Experiment_2B experiment_2B = new Experiment_2B();

/**
 * Instantiate `Experiment_2C`, demonstrating subscriber Apex that
 * depends on custom schema that was added in `ver 3.0 (1GP)`.
 */
System.debug('');
System.debug('Executing Experiment_2C');
System.debug('');
Experiment_2C experiment_2C = new Experiment_2C();

System.debug('');