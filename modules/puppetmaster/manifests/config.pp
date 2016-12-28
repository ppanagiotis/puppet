class puppetmaster::config {

  File {
    owner  => 'puppet',
    group  => 'puppet',
    ensure => 'present',
  }

  file { '/etc/puppet/puppet.conf' :
    source => 'puppet:///modules/puppetmaster/puppet.conf',
  }
  
  file { '/etc/puppet/hiera.yaml' :
    source => 'puppet:///modules/puppetmaster/hiera.yaml',
  }

  file { '/etc/puppet/autosign.conf' :
    content => template('puppetmaster/autosign.conf.erb'),
  }
}
