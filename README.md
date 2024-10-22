# preview-2gp-vpi
Sample code and instructions to help developers understand the impact of installing VPI-enabled 2GPs in subscriber orgs.

## Commands (ALL Executed from the Project Root)

### Initialize SFDX-Falcon Local Scripts
```
npm install --prefix ./scripts/js
```

### Run Audit/Fix for SFDX-Falcon Local Scripts (If Needed)
```
npm audit fix --prefix ./scripts/js
```
### Initialize a Subscriber Org and Install One or Package Versions
* This script always creates a new, non-namespaced scratch org.
   * Any previously-created subscriber org is deleted when running this script.
* Always specify `--2GP` as the package type.
* The `--first-version` flag indicates the first package version to install
   * Additional package versions will be installed **in sequence** until the one specified by `--last-version` is installed.
* There are SEVEN versions of the test package.
   * The first SIX versions are not VPI-Enabled.
   * The SEVENTH version is VPI-Enabled.
```
./initSubscriber --2GP --first-version 1 --last-version 6
```
## Experiments
These experiments demonstrate the behavior of Subscriber Apex that depends on `global` Apex installed via a managed package.

The following scenarios are covered:

* Subscriber depends on a managed 1GP
* Subscriber depends on a managed 2GP without VPI (Version Provider Information)
* Subscriber depends on a managed 2GP with VPI (Version Provider Information)


### Subscriber Apex with a Dependency the Publisher Deprecates in a Later Version.
1. Initialize a 2GP subscriber with direct install of `ver 3.0 (2GP)`.
```
./initSubscriber --2GP --first-version 4 --last-version 4
```
2. Deploy `SubscriberExperiment_01.cls`
```
sf project deploy start -m ApexClass:SubscriberExperiment_01 --ignore-conflicts
```
3. Execute `Experiment_01.apex`
```
sf apex run --file scripts/apex/Experiment_01.apex
```
4. Upgrade to the installed package to `ver 5.0 (2GP)`.
```
./upgradeSubscriber --2GP --first-version 4 --last-version 5
```
5. Redeploy `SubscriberExperiment_01.cls`
```
sf project deploy start -m ApexClass:SubscriberExperiment_01 --ignore-conflicts
```
6. Deploy `SubscriberExperiment_02.cls`
```
sf project deploy start -m ApexClass:SubscriberExperiment_02 --ignore-conflicts
```
7. Execute `Experiment_01.apex` again
```
sf apex run --file scripts/apex/Experiment_01.apex
```

#### Observations
* The subscriber class continued to compile because 