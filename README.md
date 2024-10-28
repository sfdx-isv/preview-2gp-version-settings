# preview-2gp-vpi
Sample code and instructions to help developers understand the impact of installing VPI-enabled 2GPs in subscriber orgs.

## Step One: Clone and Initialize This Project

#### 1. Clone this repository to your machine.
```
git clone https://github.com/sfdx-isv/preview-2gp-version-settings.git
```

#### 2. Initialize SFDX-Falcon Local Scripts
Navigate to the root of the local `preview-2gp-version-settings` directory, then run the following.
```
npm install --prefix ./scripts/js
```

#### 3. Run Audit/Fix for SFDX-Falcon Local Scripts (If Needed)
If you see any NPM warnings/errors, you can run `npm audit fix` to address them.
```
npm audit fix --prefix ./scripts/js
```

## Step Two: Run Experiments

These experiments demonstrate the behavior of Subscriber Apex that depends on `global` Apex installed via a managed package.

The following scenarios are covered:

* [Experiment One](/EXPERIMENT_1.md) - Subscriber depends on a managed 1GP
* [Experiment Two](/EXPERIMENT_2.md) - Subscriber depends on a managed 2GP without VPI (Version Provider Information)
* [Experiment Three](/EXPERIMENT_3.md) - Subscriber depends on a managed 2GP with VPI (Version Provider Information)


