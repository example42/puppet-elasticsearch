# Class: elasticsearch::prerequisites
#
# This class installs elasticsearch prerequisites
#
# == Variables
#
# Refer to elasticsearch class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by elasticsearch if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class elasticsearch::prerequisites {

  include java

  if $elasticsearch::install != 'package' {
    git::reposync { 'elasticsearch-servicewrapper':
      source_url      => 'https://github.com/elasticsearch/elasticsearch-servicewrapper.git',
      destination_dir => "${elasticsearch::install_destination}/elasticsearch-servicewrapper",
      post_command    => "cp -a ${elasticsearch::install_destination}/elasticsearch-servicewrapper/service/ ${elasticsearch::home}/bin ; chown -R ${elasticsearch::process_user}:${elasticsearch::process_user} ${elasticsearch::home}/bin/service",
      creates         => "${elasticsearch::home}/bin/service",
      before          => [ Class['elasticsearch::service'] , Class['elasticsearch::config'] ],
    }
    exec { 'elasticsearch-servicewrapper-copy':
      command => "cp -a ${elasticsearch::install_destination}/elasticsearch-servicewrapper/service/ ${elasticsearch::home}/bin ; chown -R ${elasticsearch::process_user}:${elasticsearch::process_user} ${elasticsearch::home}/bin/service",
      path    => '/bin:/sbin:/usr/sbin:/usr/bin',
      creates => "${elasticsearch::home}/bin/service",
      require => Git::Reposync['elasticsearch-servicewrapper'],
    }
    file { "${elasticsearch::home}/bin/service/elasticsearch":
      ensure  => present,
      mode    => '0755',
      owner   => $elasticsearch::process_user,
      group   => $elasticsearch::process_user,
      content => template($elasticsearch::init_script_template),
      before  => Class['elasticsearch::service'],
      require => Git::Reposync['elasticsearch-servicewrapper'],
    }
    file { '/etc/init.d/elasticsearch':
      ensure  => "${elasticsearch::home}/bin/service/elasticsearch",
    }
    file { "${elasticsearch::home}/bin/service/elasticsearch.conf":
      ensure  => present,
      mode    => '0644',
      owner   => $elasticsearch::process_user,
      group   => $elasticsearch::process_user,
      content => template($elasticsearch::init_config_template),
      before  => Class['elasticsearch::service'],
      require => Git::Reposync['elasticsearch-servicewrapper'],
    }
    file { "${elasticsearch::home}/logs":
      ensure  => directory,
      mode    => '0755',
      owner   => $elasticsearch::process_user,
      group   => $elasticsearch::process_user,
      before  => Class['elasticsearch::service'],
      require => Git::Reposync['elasticsearch-servicewrapper'],
    }
  }

}
