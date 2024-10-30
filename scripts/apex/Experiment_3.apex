/**
 * Instantiate `Experiment_3A`, demonstrating subscriber Apex that
 * depends on concrete `global` Apex classes and methods.
 */
System.debug('');
System.debug('Executing Experiment_3A');
System.debug('');
Experiment_3A experiment_3A = new Experiment_3A();

/**
 * Instantiate `Experiment_3B`, demonstrating subscriber Apex that
 * extends an `abstract global` Apex class.
 */
System.debug('');
System.debug('Executing Experiment_3B');
System.debug('');
Experiment_3B experiment_3B = new Experiment_3B();

/**
 * Instantiate `Experiment_3C`, demonstrating subscriber Apex that
 * depends on custom schema that was added in `ver 3.0 (1GP)`.
 */
System.debug('');
System.debug('Executing Experiment_3C');
System.debug('');
Experiment_3C experiment_2C = new Experiment_3C();

System.debug('');