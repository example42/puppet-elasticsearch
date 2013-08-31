# = Class: elasticsearch::debug
#
# Debug class for elasticsearch
#
class elasticsearch::debug {

  file { 'debug_elasticsearch':
    ensure  => $elasticsearch::manage_file,
    path    => "${settings::vardir}/debug-elasticsearch",
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    noop    => $elasticsearch::noops,
  }

}
