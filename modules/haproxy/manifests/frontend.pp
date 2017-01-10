define haproxy::frontend (
  $order,
  $options = {},
  $target,
) {

  concat::fragment { "frontend":
    order   => "${order}",
    target  => "${target}",
    content => template('haproxy/frontend_settings.cfg.erb'),
  }
}
