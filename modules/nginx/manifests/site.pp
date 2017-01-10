define nginx::site ($port, $proxy_pass) {

  $target = hiera('haproxy::config_file')
  $frontends_order = hiera('haproxy::frontends_order')
  $backends_order = hiera('haproxy::backends_order')

  file { "/etc/nginx/sites-available/${name}" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content =>  template('nginx/site.erb'),
    tag     => 'nginx-site',
  }

  file { "/etc/nginx/sites-enabled/${name}" :
    ensure  => link,
    target  => "../sites-available/${name}",
    tag     => 'nginx-site',
  }

  @@concat::fragment { "frontend_${name}":
    order   => "${frontends_order}",
    target  => "${target}",
    content => template('haproxy/frontend.cfg.erb'),
    tag     => 'haproxy-frontend',
  }

  @@concat::fragment { "backend_${name}":
    order   => "${backends_order}",
    target  => "${target}",
    content => template('haproxy/backend.cfg.erb'),
    tag     => 'haproxy-backend',
  }

}
