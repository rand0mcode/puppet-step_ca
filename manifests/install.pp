# @summary Downloads and installs the step binaries
#
# Downloads and installs the step binaries
#
class step_ca::install (
  String $binary_arch        = $step_ca::binary_arch,
  String $ca_checksum        = $step_ca::ca_checksum,
  String $ca_version         = $step_ca::ca_version,
  String $checksum_algorithm = $step_ca::checksum_algorithm,
  String $cli_checksum       = $step_ca::cli_checksum,
  String $cli_version        = $step_ca::cli_version,
){
  archive { "/tmp/step_linux_${cli_version}_${binary_arch}.tar.gz":
    ensure        => present,
    extract       => true,
    extract_path  => '/opt',
    source        => "https://dl.step.sm/gh-release/cli/docs-ca-install/v${cli_version}/step_linux_${cli_version}_${binary_arch}.tar.gz",
    checksum      => $cli_checksum,
    checksum_type => $checksum_algorithm,
    creates       => "/opt/step_${cli_version}",
    cleanup       => true,
  }

  -> file { '/usr/bin/step':
    ensure => link,
    target => "/opt/step_${cli_version}/bin/step",
  }

  archive { "/tmp/step-ca_linux_${ca_version}_${binary_arch}.tar.gz":
    ensure        => present,
    extract       => true,
    extract_path  => '/opt',
    source        => "https://dl.step.sm/gh-release/certificates/docs-ca-install/v${ca_version}/step-ca_linux_${ca_version}_${binary_arch}.tar.gz",
    checksum      => $ca_checksum,
    checksum_type => $checksum_algorithm,
    creates       => "/opt/step-ca_${ca_version}",
    cleanup       => true,
  }

  -> file { '/usr/bin/step-ca':
    ensure => link,
    target => "/opt/step-ca_${ca_version}/bin/step-ca",
  }
}
