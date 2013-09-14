# = Class: elasticsearch
#
# This is the main elasticsearch class
#
#
# == Parameters
#
# [*install_prerequisites*]
#   Set to false if you don't want install this module's prerequisites.
#   (It may be useful if the resources provided the prerequisites are already
#   managed by some other modules). Default: true
#   Prerequisites are based on Example42 modules set.
#
# [*create_user*]
#   Set to true if you want the module to create the process user of elasticsearch
#   (as defined in $logstagh::process_user). Default: true
#   Note: User is not created when $elasticsearch::install is package
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs elasticsearch using the OS common packages
#     - source  : Installs elasticsearch downloading and extracting a specific
#                 tarball or zip file
#     - puppi   : Installs elasticsearch tarball or file via Puppi, creating the
#                 "puppi deploy elasticsearch" command
#   Can be defined also by the variable $elasticsearch_install
#
# [*install_source*]
#   The URL from where to retrieve the source archive.
#   Used if install => "source" or "puppi"
#   Default is from upstream developer site. Update the version when needed.
#   Can be defined also by the variable $elasticsearch_install_source
#
# [*install_destination*]
#   The base path where to extract the source archive.
#   Used if install => "source" or "puppi"
#   Can be defined also by the variable $elasticsearch_install_destination
#
# [*init_config_template*]
#   Template file used for /etc/sysconfig|default/elasticsearch
#
# [*init_script_template*]
#   Template file used for /etc/init.d/elasticsearch
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, elasticsearch class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $elasticsearch_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, elasticsearch main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $elasticsearch_source
#
# [*source_dir*]
#   If defined, the whole elasticsearch configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $elasticsearch_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $elasticsearch_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, elasticsearch main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $elasticsearch_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $elasticsearch_options
#
# [*service_autorestart*]
#   Automatically restarts the elasticsearch service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $elasticsearch_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $elasticsearch_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $elasticsearch_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $elasticsearch_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for elasticsearch checks
#   Can be defined also by the (top scope) variables $elasticsearch_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $elasticsearch_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $elasticsearch_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $elasticsearch_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $elasticsearch_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for elasticsearch port(s)
#   Can be defined also by the (top scope) variables $elasticsearch_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling elasticsearch. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $elasticsearch_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $elasticsearch_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $elasticsearch_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $elasticsearch_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# [*package_source*]
#   The URL from where to download the Package (http or puppet)
#
# [*package_provider*]
#   The Provider to use for the package resource
#
# [*package_path*]
#   The Path where to save the Package for installation
#
#
# Default class params - As defined in elasticsearch::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of elasticsearch package
#
# [*service*]
#   The name of elasticsearch service
#
# [*service_status*]
#   If the elasticsearch service init script supports status argument
#
# [*process*]
#   The name of elasticsearch process
#
# [*process_args*]
#   The name of elasticsearch arguments. Used by puppi and monitor.
#   Used only in case the elasticsearch process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user elasticsearch runs with.
#
# [*process_group*]
#   The name of the group elasticsearch runs with.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $elasticsearch_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $elasticsearch_protocol
#
#
# See README for usage patterns.
#
class elasticsearch (
  $install_prerequisites = params_lookup( 'install_prerequisites' ),
  $create_user           = params_lookup( 'create_user' ),
  $install               = params_lookup( 'install' ),
  $install_source        = params_lookup( 'install_source' ),
  $install_destination   = params_lookup( 'install_destination' ),
  $init_config_template  = params_lookup( 'init_config_template' ),
  $init_script_template  = params_lookup( 'init_script_template' ),
  $java_opts             = params_lookup( 'java_opts' ),
  $my_class              = params_lookup( 'my_class' ),
  $source                = params_lookup( 'source' ),
  $source_dir            = params_lookup( 'source_dir' ),
  $source_dir_purge      = params_lookup( 'source_dir_purge' ),
  $template              = params_lookup( 'template' ),
  $service_autorestart   = params_lookup( 'service_autorestart' , 'global' ),
  $options               = params_lookup( 'options' ),
  $version               = params_lookup( 'version' ),
  $absent                = params_lookup( 'absent' ),
  $disable               = params_lookup( 'disable' ),
  $disableboot           = params_lookup( 'disableboot' ),
  $monitor               = params_lookup( 'monitor' , 'global' ),
  $monitor_tool          = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target        = params_lookup( 'monitor_target' , 'global' ),
  $puppi                 = params_lookup( 'puppi' , 'global' ),
  $puppi_helper          = params_lookup( 'puppi_helper' , 'global' ),
  $firewall              = params_lookup( 'firewall' , 'global' ),
  $firewall_tool         = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src          = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst          = params_lookup( 'firewall_dst' , 'global' ),
  $debug                 = params_lookup( 'debug' , 'global' ),
  $audit_only            = params_lookup( 'audit_only' , 'global' ),
  $noops                 = params_lookup( 'noops' ),
  $package               = params_lookup( 'package' ),
  $package_source        = params_lookup( 'package_source' ),
  $package_provider      = params_lookup( 'package_provider' ),
  $package_path          = params_lookup( 'package_path' ),
  $service               = params_lookup( 'service' ),
  $service_status        = params_lookup( 'service_status' ),
  $process               = params_lookup( 'process' ),
  $process_args          = params_lookup( 'process_args' ),
  $process_user          = params_lookup( 'process_user' ),
  $process_group         = params_lookup( 'process_group' ),
  $config_dir            = params_lookup( 'config_dir' ),
  $config_file           = params_lookup( 'config_file' ),
  $config_file_mode      = params_lookup( 'config_file_mode' ),
  $config_file_owner     = params_lookup( 'config_file_owner' ),
  $config_file_group     = params_lookup( 'config_file_group' ),
  $config_file_init      = params_lookup( 'config_file_init' ),
  $pid_file              = params_lookup( 'pid_file' ),
  $data_dir              = params_lookup( 'data_dir' ),
  $log_dir               = params_lookup( 'log_dir' ),
  $log_file              = params_lookup( 'log_file' ),
  $port                  = params_lookup( 'port' ),
  $protocol              = params_lookup( 'protocol' )
  ) inherits elasticsearch::params {

  $bool_install_prerequisites=any2bool($install_prerequisites)
  $bool_create_user=any2bool($create_user)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)


  ### Definition of some variables used in the module
  $manage_package = $elasticsearch::bool_absent ? {
    true  => 'absent',
    false => $elasticsearch::install ? {
      package => $elasticsearch::package_source ? {
        ''      => $elasticsearch::version,
        default => $::operatingsystem ? {
          /(?i:Debian|Ubuntu|Mint)/ => 'present',
          default                   => $elasticsearch::version,
        },
      },
      default => $elasticsearch::version,
    },
  }

  $manage_service_enable = $elasticsearch::bool_disableboot ? {
    true    => false,
    default => $elasticsearch::bool_disable ? {
      true    => false,
      default => $elasticsearch::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $elasticsearch::bool_disable ? {
    true    => 'stopped',
    default =>  $elasticsearch::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $elasticsearch::bool_service_autorestart ? {
    true    => Class['elasticsearch::service'],
    false   => undef,
  }

  $manage_file = $elasticsearch::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $elasticsearch::bool_absent == true
  or $elasticsearch::bool_disable == true
  or $elasticsearch::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $elasticsearch::bool_absent == true
  or $elasticsearch::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $elasticsearch::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $elasticsearch::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $elasticsearch::source ? {
    ''        => undef,
    default   => $elasticsearch::source,
  }

  $manage_file_content = $elasticsearch::template ? {
    ''        => undef,
    default   => template($elasticsearch::template),
  }

  ### Internal vars depending on user's input
  $real_install_source = $elasticsearch::install_source ? {
    ''      => "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${elasticsearch::version}.tar.gz",
    default => $elasticsearch::install_source,
  }
  $created_dirname_tar = url_parse($real_install_source,'filedir')
  $created_dirname = regsubst($created_dirname_tar,'.tar','')
  $home = "${elasticsearch::install_destination}/${created_dirname}"

  $real_config_file = $elasticsearch::config_file ? {
    ''      => $elasticsearch::install ? {
      package => '/etc/elasticsearch/elasticsearch.yml',
      default => "${elasticsearch::home}/config/elasticsearch.yml",
    },
    default => $elasticsearch::config_file,
  }

  $real_config_dir = $elasticsearch::config_dir ? {
    ''      => $elasticsearch::install ? {
      package => '/etc/elasticsearch/',
      default => "${elasticsearch::home}/config/",
    },
    default => $elasticsearch::config_dir,
  }

  $package_filename = url_parse($elasticsearch::package_source, 'filename')
  $real_package_path = $elasticsearch::package_path ? {
    ''      => $elasticsearch::package_source ? {
      ''      => undef,
      default => "${elasticsearch::install_destination}/${elasticsearch::package_filename}",
    },
    default => $elasticsearch::package_path,
  }

  $real_package_provider = $elasticsearch::package_provider ? {
    ''      => $elasticsearch::package_source ? {
      ''      => undef,
      default => $::operatingsystem ? {
          /(?i:Debian|Ubuntu|Mint)/ => 'dpkg',
          default                   => undef,
      },
    },
    default => $elasticsearch::package_provider,
  }

  ### Managed resources

  if $elasticsearch::bool_install_prerequisites {
    class { 'elasticsearch::prerequisites':
    }
  }

  class { 'elasticsearch::install': }

  class { 'elasticsearch::service':
    require => Class['elasticsearch::install'],
  }

  class { 'elasticsearch::config':
    notify  => $elasticsearch::manage_service_autorestart,
    require => Class['elasticsearch::install'],
  }

  ### Include custom class if $my_class is set
  if $elasticsearch::my_class {
    include $elasticsearch::my_class
  }

  ### Example42 extensions
  if $elasticsearch::bool_puppi == true
  or $elasticsearch::bool_monitor == true
  or $elasticsearch::bool_firewall == true {
    class { 'elasticsearch::example42': }
  }

  ### Debug
  if $elasticsearch::bool_debug == true {
    class { 'elasticsearch::debug': }
  }

}
