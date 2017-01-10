class nginx::service {

  service { 'nginx' :
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    restart    => '/usr/sbin/invoke-rc.d nginx reload',
    require    => Package['nginx'],
  }
}
