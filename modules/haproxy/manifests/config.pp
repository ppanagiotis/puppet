class haproxy::config ($config_file) {
  concat { $config_file:
    ensure => present,
  }

  $defaults = {
    'target'   => $config_file,
  }

  $haproxy = hiera('haproxy',{})

  $default = $haproxy['default']
  create_resources('haproxy::default',$default, $defaults)

}
