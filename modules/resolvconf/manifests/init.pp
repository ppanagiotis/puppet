class resolvconf ($nameservers, $searches, $domain) {

  augeas { "set domain" :
    context => '/files/etc/resolv.conf',
    changes => "set domain $domain",
  }

  $nameservers.each |Integer $idx, String $nameserver| {
    $index = $idx +1
    augeas { "set ${nameserver}" :
      context => '/files/etc/resolv.conf',
      changes => "set nameserver[${index}] ${nameserver}",
    }
  }

  $searches.each |Integer $idx, String $search| {
    $index = $idx +1
    augeas { "set ${search}" :
      context => '/files/etc/resolv.conf',
      changes => "set search/domain[${index}] ${search}",
    }
  }
}
