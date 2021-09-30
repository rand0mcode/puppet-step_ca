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
){
  file { $ca_password_file:
    ensure  => file,
    content => $ca_password,
    group   => $step_group,
    mode    => $ca_password_file_mode,
    owner   => $step_user,
  }

  $init_command = [
    '/usr/bin/step ca init',
    "--address \"${ca_init_address}\"",
    "--dns ${ca_init_dns}",
    "--name \"${ca_name}\"",
    "--password-file ${ca_password_file}",
    "--provisioner ${ca_init_provisioner}",
    "--provisioner-password-file ${ca_password_file}",
  ]

  exec { 'step_ca_init':
    command => join($init_command, ' '),
    creates => "${step_user_home}/.puppet_init.lock",
    group   => $step_group,
    path    => $facts['path'],
    user    => $step_user,
  }

  -> file { "${step_user_home}/.puppet_init.lock":
    ensure => file,
    group  => $step_group,
    owner  => $step_user,
  }

  file { "${step_user_home}/.step/db":
    ensure => directory,
    group  => $step_group,
    owner  => $step_user,
  }
}
