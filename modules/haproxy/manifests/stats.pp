define haproxy::stats(
  $order,
  $options = {},
  $target,
) {

  concat::fragment { "stats":
    order   => "${order}",
    target  => "${target}",
    content => template('haproxy/stats.cfg.erb'),
  }
}
