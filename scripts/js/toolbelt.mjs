#!/usr/bin/env node
//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @file          sfdx-falcon/toolbelt.mjs
 * @copyright     Vivek M. Chawla - 2023
 * @author        Vivek M. Chawla <@VivekMChawla>
 * @summary       Entry point for the SFDX-Falcon Toolbelt.
 * @description   The SFDX-Falcon Toolbelt automates several tasks that SFDX developers regularly
 *                perform.
 * @version       1.0.0
 * @license       BSD-3-Clause
 */
//─────────────────────────────────────────────────────────────────────────────────────────────────┘
import { $, argv, cd, chalk, fs, question, path } from "zx";
import { buildSubscriber1GP }         from './build-subscriber-1GP.mjs';
import { buildSubscriber2GP }         from './build-subscriber-2GP.mjs';
import { upgradeSubscriber1GP }       from './upgrade-subscriber-1GP.mjs';
import { upgradeSubscriber2GP }       from './upgrade-subscriber-2GP.mjs';
import { SfdxFalconDebug }            from './sfdx-falcon/debug/index.mjs';
import { SfdxFalconError }            from './sfdx-falcon/error/index.mjs';
import  * as SfdxUtils                from './sfdx-falcon/utilities/sfdx.mjs';

// Set the File Local Debug Namespace
const dbgNs = 'Toolbelt';
SfdxFalconDebug.msg(`${dbgNs}`, `Debugging initialized for ${dbgNs}`);
//─────────────────────────────────────────────────────────────────────────────────────────────────┐
//─────────────────────────────────────────────────────────────────────────────────────────────────┘

/**
 * Initialize the SFDX-Falcon Debugger. 
 * To enable debug output, add the `--sfdx-falcon-debug` argument and
 * pass a string with a comma-separated list of debug namespaces that
 * you'd like to see output for. 
 * @example
 * ```
 * $> ./toolbelt --sfdx-falcon-debug "UTIL:SFDX,Toolbelt"
 * ```
 */
SfdxFalconDebug.init(argv);
/**
 * Disable the default quote processor used by ZX, otherwise a string template
 * variable that holds an entire command like `sf org delete scratch -o MyScratchOrg`
 * is seen as a single argument in need of escaping with double-quotes ("").
 * This results in a "command not found" shell error when ZX runs the command.
 */
$.quote = (arg) => {
  return arg;
}
/**
 * The "verbose" feature of ZX outputs too much. Turn it off.
 */
$.verbose = false;
/**
 * Parsed JSON representation of `sfdx-project.json` in the directory
 * the toolbelt was run in.
 */
export const sfdxProjectJson = SfdxUtils.getSfdxProjectJson();
SfdxFalconDebug.obj(`${dbgNs}:sfdxProjectJson`, sfdxProjectJson);
/**
 * The name of the SFDX project in the directory the toolbelt was run in. 
 * Reverts to `packaging-project` if the `name` key in `sfdx-project.json`
 * is `undefined`.
 */
export const sfdxProjectName = SfdxUtils.getSfdxProjectName(sfdxProjectJson);
SfdxFalconDebug.str(`${dbgNs}:sfdxProjectName`, sfdxProjectName);
/**
 * The alias for DEV scratch orgs used by this SFDX project.
 */
export const devOrgAlias = `PKG-DEV:${sfdxProjectName}`;
SfdxFalconDebug.str(`${dbgNs}:devOrgAlias`, devOrgAlias);
/**
 * The name of the scratch org configuration file for DEV environments.
 * Please note that the file must be located in the `config` subdirectory
 * at the root of your SFDX project directory.
 */
export const devOrgConfigFile = "scratch-def-dev.json";
SfdxFalconDebug.str(`${dbgNs}:devOrgConfigFile`, devOrgConfigFile);
/**
 * The alias for QA scratch orgs used by this SFDX project.
 */
export const qaOrgAlias = `PKG-QA:${sfdxProjectName}`;
SfdxFalconDebug.str(`${dbgNs}:qaOrgAlias`, qaOrgAlias);
/**
 * The name of the scratch org configuration file for QA environments.
 * Please note that the file must be located in the `config` subdirectory
 * at the root of your SFDX project directory.
 */
export const qaOrgConfigFile = "scratch-def-qa.json";
SfdxFalconDebug.str(`${dbgNs}:qaOrgConfigFile`, qaOrgConfigFile);
/**
 * The alias for the UAT environment (Trial/Sandbox/Dev) used by this SFDX project.
 */
export const uatOrgAlias = `PKG-UAT:${sfdxProjectName}`;
SfdxFalconDebug.str(`${dbgNs}:uatOrgAlias`, uatOrgAlias);
/**
 * The JSON object defined by the `packageAliases` key in `sfdx-project.json`.
 */
export const packageAliases = SfdxUtils.getPackageAliases(sfdxProjectJson);
SfdxFalconDebug.obj(`${dbgNs}:packageAliases`, packageAliases);
/**
 * The list of packages that must be installed before the
 * source in this SFDX project can be deployed to an org.
 */
export const packageDependencies = SfdxUtils.getPackageDependencies(sfdxProjectJson);
/**
 * Determine the first and last version numbers of the packages that we want to install.
 */
const firstVersionNum = argv['first-version'] ? parseInt(argv['first-version']) : 1;
const lastVersionNum  = argv['last-version']  ? parseInt(argv['last-version'])  : null;
/**
 * Determine if Firefox should be the explicit target of Org Open commands, or if the default should be used.
 */
export const useFirefox = argv['firefox'] ? true : false;

/** 
 * Determine which build script to run based on the command line arguments.
 */
if (argv['1GP']) {
  try {
    if (argv['UPGRADE-SUB']) {
      console.log(`Running upgradeSubscriber1GP for versions ${firstVersionNum} through ${lastVersionNum}`);
      await upgradeSubscriber1GP(firstVersionNum, lastVersionNum);
    } else {
      console.log(`Running buildSubscriber1GP for versions ${firstVersionNum} through ${lastVersionNum}`);
      await buildSubscriber1GP(firstVersionNum, lastVersionNum);
    }
  } catch (buildError) {
    // Something failed.
    console.log(SfdxFalconError.renderError(buildError));
    process.exit(1);
  }
}
if (argv['2GP']) {
  try {
    if (argv['UPGRADE-SUB']) {
      console.log(`Running upgradeSubscriber2GP for versions ${firstVersionNum} through ${lastVersionNum}`);
      await upgradeSubscriber2GP(firstVersionNum, lastVersionNum);
    } else {
      console.log(`Running buildSubscriber2GP for versions ${firstVersionNum} through ${lastVersionNum}`);
      await buildSubscriber2GP(firstVersionNum, lastVersionNum);
    }
  } catch (buildError) {
    // Something failed.
    console.log(SfdxFalconError.renderError(buildError));
    process.exit(1);
  }
}

// Everything succeded.
process.exit(0);
