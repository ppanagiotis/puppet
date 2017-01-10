define haproxy::global (
  $order,
  $options = {},
  $target,
) {

  concat::fragment { "global":
    order   => "${order}",
    target  => "${target}",
    content => template('haproxy/global.cfg.erb'),
  }
}
