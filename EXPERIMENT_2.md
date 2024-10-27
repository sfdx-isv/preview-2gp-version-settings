# Experiment Two: Subscriber Apex Depending on 2GP WITHOUT VPI Enabled

This experiment demonstrates subscriber Apex interacting with global classes in package versions without **Version Settings** support.

The managed 2GP versions you'll work with in this experiment have the following limitations.

1. Subscriber Apex classes can not be "pinned" to a specific version of the installed 2GP.
2. Subscriber Visualforce components can not be "pinned" to a specific version of the installed 2GP.
3. Packaged Apex classes could not use the `System.requestVersion()` method.

You will see how introducing `@Deprecated` methods via package upgrades **has no impact** on the compilation of subscriber metadata, allowing subscribers to build integrations with packaged Apex that publishers have no intention of supporting.

## Objectives

* Observe how **Package Version Information** 
* Observe how **Package Version** settings are completely missing  impact subscriber Apex with managed 1GP dependencies.
* Observe how **Package Version** settings can prevent compile errors with subscriber Apex.
* Observe that behavior of packaged Apex is always driven by the most recent implementation, regardless of **Package Version** settings.

## Step-by-Step Overview

1. Initialize a 1GP subscriber org and directly install package `ver 3.0 (1GP)`.
2. Deploy subscriber Apex that depends on `global` Apex from package `ver 3.0 (1GP)`.
3. Execute anonymous Apex to see what the packaged Apex is doing in `ver 3.0 (1GP)`.
4. Upgrade directly from `ver 3.0 (1GP)` to `ver 6.0 (1GP)`, introducing `@Deprecated` Apex to the org.
5. Attempt to redeploy subscriber Apex and observe compilation errors.
6. Retrieve previously deployed subscriber Apex and observe changes to `.cls-meta.xml` files.
7. Attempt to redeploy subscriber Apex again and observe success this time.

## Detailed Instructions

#### 1. Initialize a 2GP subscriber org and directly install package `ver 6.0 (2GP)`.
```
./initSubscriber --2GP --first-version 6 --last-version 6
```
**NOTE:** The following were `@Deprecated` in `ver 5.0 (2GP)`:
* The method `methodAltTwo(Integer, String)` inside the `v_provider_test__GlobalConcreteTwo` class.
* The entire `v_provider_test__GlobalAbstractOne` class.

---

#### 2. Deploy `Experiment_2*` subscriber classes.
```
sf project deploy start -m "ApexClass:Experiment_2*" --ignore-conflicts
```
**NOTE:** The `Experiment_2*` subscriber classes depend on packaged Apex that's `@Deprecated` in `ver 5.0 (2GP)`.
* In 1GP, this deployment would result in an Apex compile error.
* In 2GP without **Version Settings** support, ALL global packaged Apex is visible to the subscriber, even when `@Deprecated`.

---

#### 3. View the Class Summary for `v_provider_test__GlobalConcreteTwo` in Setup.
Open the `v_provider_test__GlobalConcreteTwo` class in Setup and note the following.
1. The class `v_provider_test__GlobalConcreteTwo` was installed as part of the `Version Provider Test (2GP)` package.
2. The class summary shows ALL of the methods in this class, including `methodAltTwo(Integer, String)` which was `@Deprecated` in `ver 5.0 (2GP)`.
3. The **"Available in Versions"** section is missing completely.

![GlobalConcreteTwo Class Summary](images/Packaged_Apex_Class_Detail_2GP.png)

---

#### 4. Execute `Experiment_2.apex` showing only `USER_DEBUG` log lines.
```
sf apex run --file scripts/apex/Experiment_2.apex | grep USER_DEBUG
```
**Observations:** 
* Just as with 1GP, the packaged-global Apex is always implemented by logic in the most recently installed package version.

---

#### 5. View the Class Summary for `GlobalConcreteTwo` in Setup.
Open the `v_provider_test__GlobalConcreteTwo` class in Setup and note the following.
1. The class `v_provider_test__GlobalConcreteTwo` was installed as part of the `Version Provider Test (2GP)` package.




4. Initialize a **new** 2GP subscriber org and directly install package `ver 6.0 (2GP)`.
```
./initSubscriber --2GP --first-version 6 --last-version 6
```
5. Attempt to deploy `Experiment_2*` subscriber classes and observe errors.
```
sf project deploy start -m "ApexClass:Experiment_2*" --ignore-conflicts
```




4. Upgrade to the installed package directly to `ver 6.0 (1GP)`.
```
./upgradeSubscriber --2GP --first-version 6 --last-version 6
```
5. Redeploy `Experiment_2*` subscriber classes, noting that all classes will fail to deploy.
```
sf project deploy start -m "ApexClass:Experiment_2*" --ignore-conflicts
```
6. Retrieve `Experiment_2*` classes from the org. Use the **Source Control** panel to inspect changes to the `.cls-meta.xml` for each subscriber class.
```
sf project retrieve start -m "ApexClass:Experiment_2*" --ignore-conflicts
```
7. Attempt to redeploy the `Experiment_2*` subscriber classes. Note success because the `.cls-meta.xml` files contain `<packageVersions>` information that "pins" each subscriber class to a specific managed package version.
```
sf project deploy start -m "ApexClass:Experiment_2*" --ignore-conflicts
```

## Key Takeaways
* Applying **Version Settings** to a subscriber class impacts the compilation of the subscriber class.
* The logic executed by packaged Apex is always implemented by the most recent version.
  * This can be observed by examining the changes in debug output between `ver 4.0 (1GP)` and `ver 6.0 (1GP)`.
* Publishers wishing to preserve logic that provides backward-compatible output to subscribers must implement multiple code paths in their most recent package version.
  * Publishers can do this by using the [Version Class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_version.htm) and the `System.requestVersion` method.
  * For additional context, see [Versioning Apex Code Behavior](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_manpkgs_behavior.htm) in the Apex Developer Guide.