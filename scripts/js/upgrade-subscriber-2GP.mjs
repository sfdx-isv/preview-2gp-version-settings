//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @file          sfdx-falcon/upgrade-subscriber-2GP.mjs
 * @copyright     Vivek M. Chawla - 2023
 * @author        Vivek M. Chawla <@VivekMChawla>
 * @summary       Implements a series of CLI commands that upgrade the installed packages in a 
 *                subscriber test environment.
 * @description   When an SFDX Toolbelt users seclect the option to build a DEV environment, the 
 *                `upgradeSubscriber2GP()` function is called to perform the update actions.
 * @version       1.0.0
 * @license       BSD-3-Clause
 */
//─────────────────────────────────────────────────────────────────────────────────────────────────┘
// Import External Libraries & Modules

// Import Internal Classes & Functions
import { devOrgAlias, 
         devOrgConfigFile, 
         packageDependencies }  from './toolbelt.mjs';
import { TaskRunner }           from './sfdx-falcon/task-runner/index.mjs';
import { SfdxTask }             from './sfdx-falcon/task-runner/sfdx-task.mjs';
import { SfdxFalconError }      from './sfdx-falcon/error/index.mjs';
import { SfdxFalconDebug }      from './sfdx-falcon/debug/index.mjs';

// Set the File Local Debug Namespace
const dbgNs = 'upgradeSubscriber2GP';
SfdxFalconDebug.msg(`${dbgNs}`, `Debugging initialized for ${dbgNs}`);
//─────────────────────────────────────────────────────────────────────────────────────────────────┐
//─────────────────────────────────────────────────────────────────────────────────────────────────┘

//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @function    upgradeSubscriber2GP
 * @returns     {Promise<void>} 
 * @summary     Updates a scratch org-based development environment.
 * @description Executes multiple Salesforce CLI commands to update specific managed packages in 
 *              the current subscriber test scratch org.
 * @public
 * @example
 * ```
 * await upgradeSubscriber2GP();
 * ```
 */
//─────────────────────────────────────────────────────────────────────────────────────────────────┘
export async function upgradeSubscriber2GP(firstVersionNum, lastVersionNum) {
  
  const orgAlias             = 'SubOrg:avp-test-2GP';
  const packageName          = 'AVP Test Package';
  const packageVersionIds    = ['04tRm000000ETOjIAO', '04tRm000000EswbIAC', '04tRm000000Ev1dIAC', '04tRm000000FDL7IAO', '04tRm000000FQBtIAO', '04tRm000000WqMrIAK', '04tRm000000X8jZIAS'];
  const packageVersionNames  = ['ver 1.0 (2GP)', 'ver 2.0 (2GP)', 'ver 3.0 (2GP)', 'ver 4.0 (2GP)', 'ver 5.0 (2GP)', 'ver 6.0 (2GP)', 'ver 7.0 (2GP)'];
  const firstVersionNumber   = Number.isInteger(firstVersionNum) ? firstVersionNum : 1;
  const lastVersionNumber    = Number.isInteger(lastVersionNum)  ? lastVersionNum : packageVersionIds.length;

  const ctx = {};
  const tr  = TaskRunner.getInstance();
  tr.ctx    = ctx;

  //*
  // STEP ONE: Install test packages in the subscriber org.
  for (let pkgVersion = firstVersionNumber; pkgVersion <= lastVersionNumber; pkgVersion++) {
    tr.addTask(new SfdxTask(
      `Install ${packageName} (${packageVersionNames[pkgVersion-1]}) in ${orgAlias}`,
      `sf package install -p ${packageVersionIds[pkgVersion-1]} -w 10 -s AllUsers -o ${orgAlias}`,
      {suppressErrors: false, renderStdioOnError: true}
    ));
  }
  //*/
  //*
  // STEP TWO: Open the "Installed Packages" page in the scratch org in Firefox.
  tr.addTask(new SfdxTask(
    `Open the Installed Packages setup page in Firefox`,
    `sf org open -b firefox -p lightning/setup/ImportedPackage/home -o ${orgAlias}`,
    {suppressErrors: false, renderStdioOnError: true}
  ));
  //*/

  // Run the tasks.
  try {
    return tr.runTasks();
  } catch (ListrRuntimeError) {
    console.error(SfdxFalconError.renderError(ListrRuntimeError));
  }
}