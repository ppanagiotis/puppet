class haproxy ($config_file) {
  include haproxy::package
  include haproxy::service
  class { 'haproxy::config' :
    config_file => $config_file
  }

  Class['haproxy::package'] -> Class['haproxy::config'] ~> Class['haproxy::service']
}
