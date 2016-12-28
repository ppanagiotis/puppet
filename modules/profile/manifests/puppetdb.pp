#
class profile::puppetdb {

  $puppetdb_user = hiera('puppetdb::user')
  $puppetdb_pass = hiera('puppetdb::password')
  $puppetdb_dbname = hiera('puppetdb::database')

  class { 'postgresql::globals':
    version => '9.4',
  }->
  class { 'postgresql::server':
  }->
  class {'puppetdb':
    puppetdb_user   => $puppetdb_user,
    puppetdb_pass   => $puppetdb_pass,
    puppetdb_dbname => $puppetdb_dbname,
  }

  postgresql::server::db { $puppetdb_dbname :
    user     => $puppetdb_user,
    password => postgresql_password($puppetdb_user, $puppetdb_pass),
  }
}
