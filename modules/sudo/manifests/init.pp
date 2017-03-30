class sudo {
  package { 'sudo' :
    ensure => present,
  }

  file { '/etc/sudoers.d/01_sudo' :
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///modules/sudo/sudo.sudoers',
    require => Package['sudo'],
  }
}
