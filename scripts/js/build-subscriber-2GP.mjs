//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @file          sfdx-falcon/build-dev-env.mjs
 * @copyright     Vivek M. Chawla - 2023
 * @author        Vivek M. Chawla <@VivekMChawla>
 * @summary       Implements a series of CLI commands that build the DEV environment for this project.
 * @description   When an SFDX Toolbelt users seclect the option to build a DEV environment, the 
 *                `buildSubscriber1GP()` function is called to perform the teardown/setup actions.
 * @version       1.0.0
 * @license       BSD-3-Clause
 */
//─────────────────────────────────────────────────────────────────────────────────────────────────┘
// Import External Libraries & Modules

// Import Internal Classes & Functions
import { devOrgAlias, 
         devOrgConfigFile, 
         packageDependencies,
         useFirefox }           from './toolbelt.mjs';
import { TaskRunner }           from './sfdx-falcon/task-runner/index.mjs';
import { SfdxTask }             from './sfdx-falcon/task-runner/sfdx-task.mjs';
import { SfdxFalconError }      from './sfdx-falcon/error/index.mjs';
import { SfdxFalconDebug }      from './sfdx-falcon/debug/index.mjs';

// Set the File Local Debug Namespace
const dbgNs = 'buildSubscriber2GP';
SfdxFalconDebug.msg(`${dbgNs}`, `Debugging initialized for ${dbgNs}`);
//─────────────────────────────────────────────────────────────────────────────────────────────────┐
//─────────────────────────────────────────────────────────────────────────────────────────────────┘

//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @function    buildSubscriber2GP
 * @returns     {Promise<void>} 
 * @summary     Builds a scratch org-based development environment.
 * @description Executes multiple Salesforce CLI commands which typically include deleting the 
 *              previous dev scratch org, creating a new scratch org, installing package
 *              dependencies, pushing source, loading test data, and performing any other post
 *              deploy/install configuration changes required by developers.
 * @public
 * @example
 * ```
 * await buildSubscriber2GP();
 * ```
 */
//─────────────────────────────────────────────────────────────────────────────────────────────────┘
export async function buildSubscriber2GP(firstVersionNum, lastVersionNum) {
  
  const orgAlias             = 'SubOrg:avp-test-2GP';
  const orgDescription       = '2GP Subscriber Test scratch org';
  const orgConfigFile        = 'config/project-scratch-def.json';
  const packageName          = 'AVP Test Package';
  const packageVersionIds    = ['04tRm000000ETOjIAO', '04tRm000000EswbIAC', '04tRm000000Ev1dIAC', '04tRm000000FDL7IAO', '04tRm000000FQBtIAO', '04tRm000000WqMrIAK', '04tRm000000XAVFIA4'];
  const packageVersionNames  = ['ver 1.0 (2GP)', 'ver 2.0 (2GP)', 'ver 3.0 (2GP)', 'ver 4.0 (2GP)', 'ver 5.0 (2GP)', 'ver 6.0 (2GP)', 'ver 7.0 (2GP)'];
  const firstVersionNumber   = Number.isInteger(firstVersionNum) ? firstVersionNum : 1;
  const lastVersionNumber    = Number.isInteger(lastVersionNum)  ? lastVersionNum : packageVersionIds.length;
  const permissionSetName    = 'v_provider_test__Apex_Version_Provider_Test_Perms';
  const ctx = {};
  const tr  = TaskRunner.getInstance();
  tr.ctx    = ctx;

  //*
  // STEP ONE: Delete the existing subscriber test scratch org (if present).
  tr.addTask(new SfdxTask(
    `Delete existing ${orgDescription} (${orgAlias})`,
    `sf org delete scratch -p -o ${orgAlias}`,
    {suppressErrors: true}
  ));
  //*/
  //*
  // STEP TWO: Create a new scratch org.
  tr.addTask(new SfdxTask(
    `Create new ${orgDescription} (${orgAlias})`,
    `sf org create scratch -d -m -a ${orgAlias} -f ${orgConfigFile}`,
    {suppressErrors: false, renderStdioOnError: true}
  ));
  //*/
  //*
  // STEP THREE: Install test packages in the subscriber org.
  for (let pkgVersion = firstVersionNumber; pkgVersion <= lastVersionNumber; pkgVersion++) {
    tr.addTask(new SfdxTask(
      `Install ${packageName} (${packageVersionNames[pkgVersion-1]}) in ${orgAlias}`,
      `sf package install -p ${packageVersionIds[pkgVersion-1]} -w 10 -s AllUsers -o ${orgAlias}`,
      {suppressErrors: false, renderStdioOnError: true}
    ));
  }  
  //*/
  //*
  // STEP FOUR: Assign required permission sets to the admin user.
  if (lastVersionNumber > 1) {
    tr.addTask(new SfdxTask(
      `Assign the ${permissionSetName} permission set to the admin user`,
      `sf org assign permset -n ${permissionSetName} -o ${orgAlias}`,
      {suppressErrors: false, renderStdioOnError: true}
    ));
  }
  //*/
  //*
  // STEP FIVE: Open the "Deployment Status" page in the scratch org in Firefox.
  tr.addTask(new SfdxTask(
    `Open the Apex Classes setup page in the new scratch org${useFirefox ? ' in Firefox' : ''}`,
    `sf org open ${useFirefox ? '-b firefox' : ''} -p lightning/setup/ApexClasses/home -o ${orgAlias}`,
    {suppressErrors: false, renderStdioOnError: true}
  ));
  //*/
  /*
  // STEP SEVEN: Run data generation scripts in the new scratch org.
  tr.addTask(new SfdxTask(
    `Generate dev/test data in the new scratch org`,
    `sf apex run -f scripts/apex/create-test-data.apex`,
    {suppressErrors: true}
  ));
  //*/

  // Run the tasks.
  try {
    return tr.runTasks();
  } catch (ListrRuntimeError) {
    console.error(SfdxFalconError.renderError(ListrRuntimeError));
  }
}