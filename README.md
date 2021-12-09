# step_ca
# step_ca

Smallstep CA - https://smallstep.com/

## Introduction

Installs and basicly configures a step_ca. Installs the ca and step cli command.

## Usage

```
include step_ca
```

```
class { 'step_ca':
  binary_arch           => 'amd64',
  ca_checksum           => '7845d35c0632983197d4b11076896a93902ec433803966ff6f87b29003135507',
  ca_version            => '0.17.4',
  checksum_algorithm    => 'sha256',
  cli_checksum          => '5e359920933e9d7213efd53d1c67b0af809288770d6b5b088e0b4d749389a3cb',
  cli_version           => '0.17.5',
  enable_acme           => true,
  enable_sshpop         => true,
  ca_password_file      => '/etc/step-ca/.password',
  step_user_home        => '/etc/step-ca',
  step_user_shell       => '/bin/false',
  ca_init_address       => ':443',
  ca_init_dns           => 'localhost',
  ca_init_provisioner   => 'admin',
  ca_name               => 'Step CA',
  ca_password           => 'dummy_password',
  ca_password_file_mode => '0400',
  step_group            => 'step',
  step_user             => 'step',
}
```

## Future development

I want to get away from execs and move to types & providers
