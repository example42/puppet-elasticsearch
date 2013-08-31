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

      if ($elasticsearch::package_source != '') or ($elasticsearch::package_source == undef) {
        case $elasticsearch::package_source {
          /^http/: {
            exec { 'wget elasticsearch package':
              command => "wget -O ${elasticsearch::real_package_path} ${elasticsearch::package_source}",
              creates => $elasticsearch::real_package_path,
              unless  => "test -f ${elasticsearch::real_package_path}",
              before  => Package['elasticsearch']
            }
          }
          /^puppet/: {
            file { 'elasticsearch package':
              ensure  => $elasticsearch::manage_file,
              path    => $elasticsearch::real_package_path,
              source  => $elasticsearch::package_source,
              before  => Package['elasticsearch']
            }
          }
          default: {}
        }
      }

      package { 'elasticsearch':
        ensure    => $elasticsearch::manage_package,
        name      => $elasticsearch::package,
        provider  => $elasticsearch::real_package_provider,
        source    => $elasticsearch::real_package_path,
        noop      => $elasticsearch::noops,
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
        noop                => $elasticsearch::noops,
      }

      file { 'elasticsearch_link':
        ensure => $elasticsearch::home,
        path   => "${elasticsearch::install_destination}/elasticsearch",
        noop   => $elasticsearch::noops,
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
        noop        => $elasticsearch::noops,
      }

      file { 'elasticsearch_link':
        ensure => $elasticsearch::home,
        path   => "${elasticsearch::install_destination}/elasticsearch",
        noop   => $elasticsearch::noops,
      }

    }

    default: { }

  }

}
