#
class puppetmaster::packages {

  package { 'puppet-master':
    ensure => present,
  }
}
