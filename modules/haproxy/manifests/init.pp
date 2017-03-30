class haproxy ($config_file) {
  include haproxy::package
  include haproxy::service
  include haproxy::acl
  class { 'haproxy::config' :
    config_file => $config_file
  }

  Class['haproxy::package'] -> Class['haproxy::acl'] -> Class['haproxy::config']
  Class['haproxy::config'] ~> Class['haproxy::service']
  Class['haproxy::acl'] ~> Class['haproxy::service']
}
