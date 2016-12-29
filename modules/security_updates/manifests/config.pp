class security_updates::config {

  $default_mail = hiera('default_mail')

  augeas { '20auto-upgrades':
    context => '/files/etc/apt/apt.conf.d/20auto-upgrades',
    changes => [
                'set APT[1]/Periodic/Update-Package-Lists 1',
                'set APT[2]/Periodic/Unattended-Upgrade 1',
    ],
    require => Package['unattended-upgrades'],
  }

  file { '/etc/apt/apt.conf.d/50unattended-upgrades' :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('security_updates/50unattended-upgrades.erb'),
    require => Package['unattended-upgrades'],
  }
}
