# = Class: elasticsearch::example42
#
# This iclass contains Example42 extensions for
# the elasticsearch module
#
class elasticsearch::example42 {

  ### Provide puppi data, if enabled ( puppi => true )
  if $elasticsearch::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'elasticsearch':
      ensure    => $elasticsearch::manage_file,
      variables => $classvars,
      helper    => $elasticsearch::puppi_helper,
      noop      => $elasticsearch::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $elasticsearch::bool_monitor == true {
    if $elasticsearch::port != '' {
      monitor::port { "elasticsearch_${elasticsearch::protocol}_${elasticsearch::port}":
        protocol => $elasticsearch::protocol,
        port     => $elasticsearch::port,
        target   => $elasticsearch::monitor_target,
        tool     => $elasticsearch::monitor_tool,
        enable   => $elasticsearch::manage_monitor,
        noop     => $elasticsearch::noops,
      }
    }
    if $elasticsearch::service != '' {
      monitor::process { 'elasticsearch_process':
        process  => $elasticsearch::process,
        service  => $elasticsearch::service,
        pidfile  => $elasticsearch::pid_file,
        user     => $elasticsearch::process_user,
        argument => $elasticsearch::process_args,
        tool     => $elasticsearch::monitor_tool,
        enable   => $elasticsearch::manage_monitor,
        noop     => $elasticsearch::noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $elasticsearch::bool_firewall == true and $elasticsearch::port != '' {
    firewall { "elasticsearch_${elasticsearch::protocol}_${elasticsearch::port}":
      source      => $elasticsearch::firewall_src,
      destination => $elasticsearch::firewall_dst,
      protocol    => $elasticsearch::protocol,
      port        => $elasticsearch::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $elasticsearch::firewall_tool,
      enable      => $elasticsearch::manage_firewall,
      noop        => $elasticsearch::noops,
    }
  }

}
