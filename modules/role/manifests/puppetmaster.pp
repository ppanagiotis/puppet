class role::puppetmaster {
  include profile::puppetdb
  include puppetmaster
}
