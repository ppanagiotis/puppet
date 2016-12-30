# == Example usage at hiera
#
#  letsencrypt:
#    basedir: '/etc/dehydrated/'
#    dehydrated_hook: 'nsupdate'
#    chalenge_type: 'dns-01'
#    domains: [test1.example.com, test2.example.com]
#    cron : true
#    nsupdate:
#      zone: 'example.com'
#      key: "%{hiera('trocla_lookup::plain::rndc-key')}"
#  
class letsencrypt::config {

  $default_mail = hiera('default_mail')

  $letsencypt = hiera_hash('letsencrypt', {})
  $cron = $letsencypt[cron]
  $basedir = $letsencypt[basedir]
  $dehydrated_hook = $letsencypt[dehydrated_hook]
  $chalenge_type = $letsencypt[chalenge_type]
  $domains = $letsencypt[domains]

  file { "${basedir}/config" :
    content => template('letsencrypt/config.erb'),
  }   

  if $domains {
    $content = inline_template("<%= (@domains).join(' ') + \"\n\" %>")
    file { "${basedir}/domains.txt" :
      content => $content,
    }
  }

  if $dehydrated_hook {
    file { "${basedir}/hooks" :
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }   

    if $dehydrated_hook == 'nsupdate' {

      $zone = $letsencypt[nsupdate][zone]
      $key = $letsencypt[nsupdate][key]

      file { "${basedir}/dns_key" :
        ensure  => 'directory',
        mode    => '0600'
      }
      
      file { "${basedir}/dns_key/key" :
        mode    => '0600',
        content => template('letsencrypt/key.erb'),
        require => File["${basedir}/dns_key"],
      }

      file { "${basedir}/hooks/nsupdate" :
        content => template('letsencrypt/nsupdate.erb'),
        mode    => '0744',
        require => File["${basedir}/hooks"],
      }
    }   
  }

  if $cron {
    file { "/etc/cron.daily/letsencrypt" :
      content => "#!/bin/sh\n/usr/bin/dehydrated -c\n",
      mode    => '0744',
    }   
  }

}
### config
### cron
#    file { "/etc/cron.daily/certificates" :
#      content => "#!/bin/sh\n/usr/bin/letsencrypt.sh -c\n",
#      mode    => '0744',
#    }   
#
