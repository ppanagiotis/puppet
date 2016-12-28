#
class postfix($smarthost, $use_tls=true) {

  $default_mail = hiera('default_mail')

  package { 'postfix' :
    ensure  => installed,
  }

  file { '/etc/mailname':
    ensure  => present,
    content => "${::fqdn}\n",
  }

  service { 'postfix' :
    require   => [
    			Package['postfix'],
		],
    subscribe => File['/etc/mailname'],
    restart   => '/usr/sbin/invoke-rc.d postfix reload',
  }

  exec { '/usr/bin/newaliases' :
    refreshonly => true,
    require     => Package['postfix'],
  }

  mailalias { 'root':
    ensure    => present,
    recipient => $default_mail,
    notify    => Exec['/usr/bin/newaliases'],
  }

  if $smarthost != false {
    augeas { 'postfix-relayhost' :
      context => '/files/etc/postfix/main.cf',
      changes => "set relayhost ${smarthost}",
      require => Package['postfix'],
      notify  => Service['postfix'],
    }
  }

  if $tls == true {
    augeas { 'postfix-smtpd-tls' :
      context => '/files/etc/postfix/main.cf',
      changes => "set smtpd_use_tls ${tls}",
    }
  }
}
