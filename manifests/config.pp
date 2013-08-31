# Class: elasticsearch::config
#
# This class manages elasticsearch configuration
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
class elasticsearch::config {

  file { 'elasticsearch.conf':
    ensure  => $elasticsearch::manage_file,
    path    => $elasticsearch::real_config_file,
    mode    => $elasticsearch::config_file_mode,
    owner   => $elasticsearch::config_file_owner,
    group   => $elasticsearch::config_file_group,
    source  => $elasticsearch::manage_file_source,
    content => $elasticsearch::manage_file_content,
    replace => $elasticsearch::manage_file_replace,
    audit   => $elasticsearch::manage_audit,
    noop    => $elasticsearch::noops,
  }

  # The whole elasticsearch configuration directory can be recursively overriden
  if $elasticsearch::source_dir {
    file { 'elasticsearch.dir':
      ensure  => directory,
      path    => $elasticsearch::real_config_dir,
      source  => $elasticsearch::source_dir,
      recurse => true,
      purge   => $elasticsearch::bool_source_dir_purge,
      force   => $elasticsearch::bool_source_dir_purge,
      replace => $elasticsearch::manage_file_replace,
      audit   => $elasticsearch::manage_audit,
      noop    => $elasticsearch::noops,
    }
  }

}
