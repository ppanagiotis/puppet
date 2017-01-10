define haproxy::manual_backends (
  $ipaddress,
  $port,
  $target,
) {

  $frontends_order = hiera('haproxy::frontends_order')
  $backends_order = hiera('haproxy::backends_order')

  concat::fragment { "frontend_${name}":
    order   => "${frontends_order}",
    target  => "${target}",
    content => template('haproxy/frontend.cfg.erb'),
  }

  concat::fragment { "backend_${name}":
    order   => "${backends_order}",
    target  => "${target}",
    content => template('haproxy/backend.cfg.erb'),
  }
}
