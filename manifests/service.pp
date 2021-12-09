# @summary Setup and run the step-ca systemd unit
#
# Setup and run the step-ca systemd unit
#
class step_ca::service {
  systemd::unit_file { 'step-ca.service':
    source => "puppet:///modules/${module_name}/step-ca.service",
  }

  ~> service { 'step-ca':
    ensure => 'running',
    enable => true,
  }
}
