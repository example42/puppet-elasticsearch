# Class: elasticsearch::params
#
# This class defines default parameters used by the main module class elasticsearch
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to elasticsearch class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class elasticsearch::params {

  ### Application related parameters

  $install_prerequisites = true
  $create_user           = true
  $install               = 'source'
  $java_opts             = undef

  $install_source        = ''
  $install_destination   = '/opt'
  $init_config_template  = 'elasticsearch/elasticsearch.conf.erb'
  $init_script_template  = 'elasticsearch/elasticsearch.init.erb'

  $package = $::operatingsystem ? {
    default => 'elasticsearch',
  }

  $service = $::operatingsystem ? {
    default => 'elasticsearch',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => 'elasticsearch',
  }

  $process_user = $::operatingsystem ? {
    default => 'elasticsearch',
  }

  $process_group = $::operatingsystem ? {
    default => 'elasticsearch',
  }

  $config_dir = $::operatingsystem ? {
    default => '',
  }

  $config_file = $::operatingsystem ? {
    default => '',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/elasticsearch',
    default                   => '/etc/sysconfig/elasticsearch',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/elasticsearch.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/elasticsearch',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/elasticsearch',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/elasticsearch/elasticsearch.log',
  }

  $port = '9200'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = '0.90.2'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
