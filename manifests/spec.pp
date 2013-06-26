# Class: elasticsearch::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class elasticsearch::spec inherits elasticsearch::config {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "elasticsearch": template => "elasticsearch/spec.erb" }

  File['elasticsearch.conf'] {
    content => template('elasticsearch/spec.erb'),
  }

}
