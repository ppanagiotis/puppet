define haproxy::default (
  $order,
  $options = {},
  $target,
) {

  concat::fragment { "default":
    order   => "${order}",
    target  => "${target}",
    content => template('haproxy/default.cfg.erb'),
  }
}
