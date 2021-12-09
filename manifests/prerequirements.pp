# @summary Pre configures the needed user and dirs
#
# Pre configures the needed user and dirs
#
class step_ca::prerequirements (
  Stdlib::Absolutepath $step_user_home  = $step_ca::step_user_home,
  Stdlib::Absolutepath $step_user_shell = $step_ca::step_user_shell,
  String $step_group                    = $step_ca::step_group,
  String $step_user                     = $step_ca::step_user,
){
  group { $step_group:
    ensure => present
  }

  -> user { $step_user:
    ensure     => present,
    gid        => $step_group,
    home       => $step_user_home,
    managehome => true,
    shell      => $step_user_shell,
  }
}
