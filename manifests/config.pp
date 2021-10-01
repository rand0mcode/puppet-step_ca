# @summary Configures the step-ca
#
# Configures the step-ca
#
class step_ca::config (
  Stdlib::Absolutepath $ca_password_file = $step_ca::ca_password_file,
  Stdlib::Absolutepath $step_user_home   = $step_ca::step_user_home,
  String $ca_init_address                = $step_ca::ca_init_address,
  String $ca_init_dns                    = $step_ca::ca_init_dns,
  String $ca_init_provisioner            = $step_ca::ca_init_provisioner,
  String $ca_name                        = $step_ca::ca_name,
  String $step_group                     = $step_ca::step_group,
  String $step_user                      = $step_ca::step_user,
  String $ca_password                    = $step_ca::ca_password,
  String $ca_password_file_mode          = $step_ca::ca_password_file_mode,
  Boolean $enable_acme                   = $step_ca::enable_acme,
  Boolean $enable_sshpop                 = $step_ca::enable_sshpop,
){
  File {
    group => $step_group,
    owner => $step_user,
    mode  => '0600',
  }

  Exec {
    group => $step_group,
    path  => $facts['path'],
    user  => $step_user,
  }

  file { $ca_password_file:
    ensure  => file,
    content => $ca_password,
    mode    => $ca_password_file_mode,
  }

  $init_command = [
    'step ca init',
    "--address \"${ca_init_address}\"",
    "--dns ${ca_init_dns}",
    "--dns ${facts['networking']['fqdn']}",
    "--name \"${ca_name}\"",
    "--password-file ${ca_password_file}",
    "--provisioner ${ca_init_provisioner}",
    "--provisioner-password-file ${ca_password_file}",
  ]

  exec { 'ca_init':
    command => join($init_command, ' '),
    creates => "${step_user_home}/.puppet_ca_init.lock",
  }

  -> file { "${step_user_home}/.puppet_ca_init.lock":
    ensure => file,
  }

  file { "${step_user_home}/.step/db":
    ensure => directory,
  }

  # exec { 'change_intermediate_password':
  #   command => 'step crypto change-pass $STEPPATH/secrets/intermediate_ca_key'
  # }

  exec { 'remove_init_jwt_provisioner':
    command => 'step ca provisioner remove admin --all',
    creates => "${step_user_home}/.puppet_remove_init_jwt_provisioner.lock",
  }

  -> file { "${step_user_home}/.puppet_remove_init_jwt_provisioner.lock":
    ensure => file,
  }

  if $enable_acme {
    exec { 'enable_acme':
      command => 'step ca provisioner add acme --type ACME',
      creates => "${step_user_home}/.puppet_enable_acme.lock",
    }

    -> file { "${step_user_home}/.puppet_enable_acme.lock":
      ensure => file,
    }
  }

  if $enable_sshpop {
    exec { 'enable_sshpop':
      command => 'step ca provisioner add sshpop --type SSHPOP',
      creates => "${step_user_home}/.puppet_enable_sshpop.lock",
    }

    -> file { "${step_user_home}/.puppet_enable_sshpop.lock":
      ensure => file,
    }
  }
}
