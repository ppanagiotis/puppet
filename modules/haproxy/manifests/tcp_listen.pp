define haproxy::tcp_listen(
  $bind,
  $server,
  $option,
  $target,
  $log,
  $port
) {

  $tcp_listen_order = hiera('haproxy::tcp_listen_order')

  concat::fragment { "tcp_${name}":
    order   => "${tcp_listen_order}",
    target  => "${target}",
    content => template('haproxy/tcp_listen.cfg.erb'),
  }
}
