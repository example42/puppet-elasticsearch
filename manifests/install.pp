# Class: elasticsearch::install
#
# This class installs elasticsearch
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
class elasticsearch::install {

  case $elasticsearch::install {

    package: {
      package { 'elasticsearch':
        ensure => $elasticsearch::manage_package,
        name   => $elasticsearch::package,
        noop   => $elasticsearch::bool_noops,
      }
    }

    source: {
      if $elasticsearch::bool_create_user == true {
        require elasticsearch::user
      }
      puppi::netinstall { 'netinstall_elasticsearch':
        url                 => $elasticsearch::real_install_source,
        destination_dir     => $elasticsearch::install_destination,
        owner               => $elasticsearch::process_user,
        group               => $elasticsearch::process_user,
        noop                => $elasticsearch::bool_noops,
      }

      file { 'elasticsearch_link':
        ensure => "${elasticsearch::home}" ,
        path   => "${elasticsearch::install_destination}/elasticsearch",
        noop   => $elasticsearch::bool_noops,
      }
    }

    puppi: {
      if $elasticsearch::bool_create_user == true {
        require elasticsearch::user
      }

      puppi::project::archive { 'elasticsearch':
        source      => $elasticsearch::real_install_source,
        deploy_root => $elasticsearch::install_destination,
        user        => $elasticsearch::process_user,
        auto_deploy => true,
        enable      => true,
        noop        => $elasticsearch::bool_noops,
      }

      file { 'elasticsearch_link':
        ensure => "${elasticsearch::home}" ,
        path   => "${elasticsearch::install_destination}/elasticsearch",
        noop   => $elasticsearch::bool_noops,
      }

    }

    default: { }

  }

}
