class haproxy::package {
  package { haproxy :
    ensure => installed
  }
}
