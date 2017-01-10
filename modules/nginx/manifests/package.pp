class nginx::package {
  package { nginx :
    ensure => installed
  }
}
