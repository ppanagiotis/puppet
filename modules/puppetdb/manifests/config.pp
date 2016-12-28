class puppetdb::config($puppetdb_user, $puppetdb_pass, $puppetdb_dbname) {

  File {
    owner  => 'puppet',
    group  => 'puppet',
    ensure => 'present',
  }

  file { '/etc/puppet/routes.yaml' :
    source => 'puppet:///modules/puppetdb/routes.yaml',
  }

  file { '/etc/puppetlabs/puppetdb/conf.d/database.ini' :
    content => template('puppetdb/database.ini.erb'),
    owner   => 'root',
    group   => 'root',
  }
}

