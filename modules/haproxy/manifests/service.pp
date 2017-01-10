class haproxy::service {

  service { 'haproxy' :
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    restart    => '/usr/sbin/invoke-rc.d haproxy reload',
    require    => Package['haproxy'],
  }
}
