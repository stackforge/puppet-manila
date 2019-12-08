# == Class: manila::backends
#
# Class to set the enabled_backends list
#
# === Parameters
#
# [*enabled_share_backends*]
#   (Required) a list of ini sections to enable.
#   This should contain names used in ceph::backend::* resources.
#   Example: ['share1', 'share2', 'sata3']
#
# Author: Andrew Woodward <awoodward@mirantis.com>
class manila::backends (
  $enabled_share_backends = undef
) {

  include manila::deps

  # Maybe this could be extended to dynamically find the enabled names
  manila_config {
    'DEFAULT/enabled_share_backends': value => join($enabled_share_backends, ',');
  }

}
