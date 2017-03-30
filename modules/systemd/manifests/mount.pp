define systemd::mount($what, $type, $options=undef) {

  file { "/etc/systemd/system/mnt-${name}.automount" :
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('systemd/mnt-target.automount.erb'),
  }

  file { "/etc/systemd/system/mnt-${name}.mount" :
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('systemd/mnt-target.mount.erb'),
    require => File["/etc/systemd/system/mnt-${name}.automount"],
  }

  exec { "reload systemd for ${name}" :
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    command     => 'systemctl --system daemon-reload',
    refreshonly => true,
    require => File["/etc/systemd/system/mnt-${name}.mount"],
  }

  exec { "systemctl --quiet enable mnt-${name}.automount" :
    path    => '/bin:/usr/bin',
    unless  => "systemctl --quiet is-enabled mnt-${name}.automount",
    require => Exec["reload systemd for ${name}"],
  }

  exec { "systemctl --quiet start mnt-${name}.automount" :
    path    => '/bin:/usr/bin',
    unless  => "systemctl --quiet is-active mnt-${name}.automount",
    require => Exec["reload systemd for ${name}"],
  }
}
