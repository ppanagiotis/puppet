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

  $global = $haproxy['global']
  create_resources('haproxy::global',$global, $defaults)

  $stats = $haproxy['stats']
  create_resources('haproxy::stats',$stats, $defaults)

  $frontend = $haproxy['frontend']
  create_resources('haproxy::frontend',$frontend, $defaults)

  $manual_backends = $haproxy['manual_backends']
  create_resources('haproxy::manual_backends',$manual_backends, $defaults)

  $tcp = $haproxy['tcp_listen']
  create_resources('haproxy::tcp_listen',$tcp, $defaults)

  Concat::Fragment <<| tag == 'haproxy-frontend' |>>
  Concat::Fragment <<| tag == 'haproxy-backend' |>>

}
