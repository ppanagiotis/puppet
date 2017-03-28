#

class debian::apt($dist=jessie, $components=[]) {

  $repo_components = inline_template('main non-free<%= " " + @components.join(" ") if @components %>')

  file { '/etc/apt/sources.list' :
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('debian/sources.list.erb'),
    notify  => Exec['apt-get update'],
  }

  exec { 'apt-get update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
  }
}
