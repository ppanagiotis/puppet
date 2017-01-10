class nginx {
  include nginx::package
  include nginx::realize
  include nginx::service

  Class['nginx::package'] -> Class['nginx::realize'] ~> Class['nginx::service']

}
