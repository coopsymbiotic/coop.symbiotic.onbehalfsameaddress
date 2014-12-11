<?php

require_once 'sameaddress.civix.php';

/**
 * Implementation of hook_civicrm_config
 */
function sameaddress_civicrm_config(&$config) {
  _sameaddress_civix_civicrm_config($config);
}

/**
 * Implementation of hook_civicrm_xmlMenu
 *
 * @param $files array(string)
 */
function sameaddress_civicrm_xmlMenu(&$files) {
  _sameaddress_civix_civicrm_xmlMenu($files);
}

/**
 * Implementation of hook_civicrm_install
 */
function sameaddress_civicrm_install() {
  return _sameaddress_civix_civicrm_install();
}

/**
 * Implementation of hook_civicrm_uninstall
 */
function sameaddress_civicrm_uninstall() {
  return _sameaddress_civix_civicrm_uninstall();
}

/**
 * Implementation of hook_civicrm_enable
 */
function sameaddress_civicrm_enable() {
  return _sameaddress_civix_civicrm_enable();
}

/**
 * Implementation of hook_civicrm_disable
 */
function sameaddress_civicrm_disable() {
  return _sameaddress_civix_civicrm_disable();
}

/**
 * Implementation of hook_civicrm_upgrade
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed  based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 */
function sameaddress_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _sameaddress_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 */
function sameaddress_civicrm_managed(&$entities) {
  return _sameaddress_civix_civicrm_managed($entities);
}

/*
 * Implementation of hook_civicrm_buildForm().
 */
function sameaddress_civicrm_buildForm($formName, &$form) {

  if ($formName == 'CRM_Contribute_Form_Contribution_Main') {

    // FIXME: to make it generic, check for on behalf (must be set) and profileAddressFields (must not be set)
    if ($form->getVar('_id') != 2 && $form->getVar('_id') != 7) {
      return;
    }

    // emulate the same behavior than the original "Same address..." but for on behalf
    $profileAddressFields = Array (
      'onbehalf_street_address' => 3,
      'onbehalf_city' => 3,
      'onbehalf_state_province' => 3,
      'onbehalf_postal_code' => 3
    );

    // the regular javascript code don't work in this case so use a new variable and do the javascript magic in .extra.tpl
    // original code in templates/CRM/Core/BillingBlock - copy in templates/CRM/Contribute/Form/Contribution/Main.extra.tpl (not possible to have BillingBlock.extra.tpl)
    $form->assign('onbehalfProfileAddressFields', $profileAddressFields);
  }
}




