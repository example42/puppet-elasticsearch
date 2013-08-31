# Class: elasticsearch::service
#
# This class manages elasticsearch service
#
# == Variables
#
# Refer to elasticsearch class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by elasticsearch
#
class elasticsearch::service {

  case $elasticsearch::install {

    package: {
      service { 'elasticsearch':
        ensure     => $elasticsearch::manage_service_ensure,
        name       => $elasticsearch::service,
        enable     => $elasticsearch::manage_service_enable,
        hasstatus  => $elasticsearch::service_status,
        pattern    => $elasticsearch::process,
        noop       => $elasticsearch::noops,
      }
    }

    source,puppi: {
      service { 'elasticsearch':
        ensure     => $elasticsearch::manage_service_ensure,
        name       => $elasticsearch::service,
        enable     => $elasticsearch::manage_service_enable,
        hasstatus  => $elasticsearch::service_status,
        pattern    => $elasticsearch::process,
        noop       => $elasticsearch::noops,
        provider   => 'init',
      }
    }

    default: { }

  }

}
