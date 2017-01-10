#
class nginx::realize {

  $sites = hiera_hash('nginx::sites',{})
  create_resources('nginx::site', $sites)

}
