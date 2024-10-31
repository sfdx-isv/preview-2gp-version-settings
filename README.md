# Version Settings Support in 2GP (Developer Preview)

This project provides sample code, tools, and three experiments to help package developers...

1. Understand how **Package Version Settings** for Subscriber Apex have always worked with 1GP.
2. Understand that **Package Version Settings** for Subscriber Apex ARE NOT SUPPORTED for 2GP versions created prior to December 2024.
3. Understand how **Package Version Settings** for Subscriber Apex works with 2GP versions created AFTER December 2024.

# Requirements

1. You must have access to a Developer Hub and have the appropriate permissions to create scratch orgs.
2. You must have a local environment with the Salesforce CLI, Git, and VS Code/Code Builder or other IDE.
3. You must be comfortable executing shell/CLI commands inside a terminal.

# Step One: Prepare Your Local Environment

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

#### 4. Ensure a Default Dev Hub is Configured for Your Environment or Project.
If you don't have a `Local` or `Global` config for `target-dev-hub`, the experiments in this project will not work.

To check your `target-dev-hub` settings, run this command from the root of your `preview-2gp-version-settings` directory.
```
sf config list
```
Hopefully you'll see something like this:
```
f==================================================
| Name           Location Value                 
| ────────────── ──────── ───────────────────────── 
| target-dev-hub Global   YourDevHubAliasOrUsername
```
If you don't see something like the above, run this command from the root of your `preview-2gp-version-settings` directory.
```
sf config set target-dev-hub YOUR_DEVHUB_ALIAS_OR_USERNAME
```
If you require additional help, please review the [Salesforce DX Usernames and Orgs](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_cli_usernames_orgs.htm) developer doc.


# Step Two: Learn By Experimentation

These experiments demonstrate the behavior of Subscriber Apex that depends on `global` Apex installed via a managed package.

The experiments can be completed in any order, but should be experienced sequentially for best results.

* [EXPERIMENT ONE](/EXPERIMENT_1.md) - Subscriber depends on `global` Apex in a managed 1GP.
* [EXPERIMENT TWO](/EXPERIMENT_2.md) - Subscriber depends on `global` Apex in a managed 2GP without **VPI (Version Provider Information)**.
* [EXPERIMENT THREE](/EXPERIMENT_3.md) - Subscriber depends on `global` Apex in a managed 2GP with **VPI (Version Provider Information)**.

# Questions or Feedback?

Please create issues for any questions or feedback about the contents of this project.

If you're part of the the Developer Preview for creating VPI-Enabled 2GPs, please provide feedback per instructions in the enablement Slack channel.

# About the Author

* [Vivek M. Chawla](https://github.com/VivekMChawla) is a Product Management Director at Salesfoce.
* When not moonlighting with Packaging, Vivek is the PM for the Salesforce CLI.

