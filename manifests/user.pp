# Class: elasticsearch::user
#
# This class creates elasticsearch user
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by elasticsearch
#
class elasticsearch::user {
  @user { $elasticsearch::process_user :
    ensure     => $elasticsearch::manage_file,
    comment    => "${elasticsearch::process_user} user",
    password   => '!',
    managehome => false,
    home       => $elasticsearch::home,
    shell      => '/bin/bash',
  }
#  @group { $elasticsearch::process_group :
#    ensure     => $elasticsearch::manage_file,
#  }

  User <| title == $elasticsearch::process_user |>
#  Group <| title == $elasticsearch::process_group |>

}
