class security_updates::packages {
  package {"unattended-upgrades":
    ensure => present,
  }
}
