#
class haproxy::acl {

  $acl_path = hiera('haproxy::acl_file')
  $networks = hiera('haproxy::networks')

  file { "$acl_path" :
    ensure  => 'present',
    owner   => 'root',
    mode    => '0644',
    content => template('haproxy/acl.erb'),
  }
}
