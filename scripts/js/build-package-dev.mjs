//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @file          sfdx-falcon/build-package-dev.mjs
 * @copyright     Vivek M. Chawla - 2023
 * @author        Vivek M. Chawla <@VivekMChawla>
 * @summary       Implements a series of CLI commands that build a 2GP package DEV environment.
 * @description   When an SFDX Toolbelt users seclect the option to build a DEV environment, the 
 *                `buildPkgDevOrg()` function is called to perform the teardown/setup actions.
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
const dbgNs = 'buildPkgDevOrg';
SfdxFalconDebug.msg(`${dbgNs}`, `Debugging initialized for ${dbgNs}`);
//─────────────────────────────────────────────────────────────────────────────────────────────────┐
//─────────────────────────────────────────────────────────────────────────────────────────────────┘

//─────────────────────────────────────────────────────────────────────────────────────────────────┐
/**
 * @function    buildPkgDevOrg
 * @returns     {Promise<void>} 
 * @summary     Builds a scratch org-based development environment.
 * @description Executes multiple Salesforce CLI commands which typically include deleting the 
 *              previous dev scratch org, creating a new scratch org, installing package
 *              dependencies, pushing source, loading test data, and performing any other post
 *              deploy/install configuration changes required by developers.
 * @public
 * @example
 * ```
 * await buildPkgDevOrg();
 * ```
 */
//─────────────────────────────────────────────────────────────────────────────────────────────────┘
export async function buildPkgDevOrg(firstVersionNum, lastVersionNum) {
  
  const orgAlias             = 'PkgDev:apex-version-provider-test';
  const orgDescription       = 'Package Development scratch org (2GP)';
  const orgConfigFile        = 'config/project-scratch-def.json';
  const permissionSetName    = 'Apex_Version_Provider_Test_Perms';
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
  // STEP TWO: Create a new scratch org and set it as the default.
  tr.addTask(new SfdxTask(
    `Create new ${orgDescription} (${orgAlias})`,
    `sf org create scratch -d -a ${orgAlias} -f ${orgConfigFile}`,
    {suppressErrors: false, renderStdioOnError: true}
  ));
  //*/
  //*
  // STEP THREE: Open the "Deployment Status" page in the scratch org in Firefox.
  tr.addTask(new SfdxTask(
    `Open the Deployment Status page in the new scratch org${useFirefox ? ' in Firefox' : ''}`,
    `sf org open ${useFirefox ? '-b firefox' : ''} -p lightning/setup/DeployStatus/home`,
    {suppressErrors: false}
  ));
  //*/
  //*
  // STEP FOUR: Push project source to the new scratch org.
  tr.addTask(new SfdxTask(
    `Deploy project source to the new scratch org`,
    `sf project deploy start`,
    {suppressErrors: false, renderStdioOnError: true}
  ));
  //*/
  //*
  // STEP FIVE: Assign required permission sets to the admin user.
  tr.addTask(new SfdxTask(
    `Assign the ${permissionSetName} permission set to the admin user`,
    `sf org assign permset -n ${permissionSetName}`,
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