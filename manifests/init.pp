# @summary Installation and setup of smallstep CA
#
# Installation and setup of smallstep CA
#
# Because of path issues with many subcommands, the installation will
# be done underneath $USER_HOME/.step. The commands search by default in this path.
# Trying to set another path would be possible with STEPPATH env var, but this is not
# very nice implemented and when you execute "sudo step" command,
# you have to specify this each time.
#
# @example
#   include step_ca
class step_ca (
  String $binary_arch        = 'amd64',
  String $ca_checksum        = '7845d35c0632983197d4b11076896a93902ec433803966ff6f87b29003135507',
  String $ca_version         = '0.17.4',
  String $checksum_algorithm = 'sha256',
  String $cli_checksum       = '5e359920933e9d7213efd53d1c67b0af809288770d6b5b088e0b4d749389a3cb',
  String $cli_version        = '0.17.5',
  Stdlib::Absolutepath $ca_password_file = '/etc/step-ca/.password',
  Stdlib::Absolutepath $step_user_home   = '/etc/step-ca',
  Stdlib::Absolutepath $step_user_shell  = '/bin/false',
  String $ca_init_address                = ':443',
  String $ca_init_dns                    = 'localhost',
  String $ca_init_provisioner            = 'admin',
  String $ca_name                        = 'Step CA',
  String $ca_password                    = 'dummy_password',
  String $ca_password_file_mode          = '0400',
  String $step_group                     = 'step',
  String $step_user                      = 'step',
){
  contain step_ca::install
  contain step_ca::prerequirements
  contain step_ca::config
  contain step_ca::service

  Class['step_ca::config']
    ~> Class['step_ca::service']
}
