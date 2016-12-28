class puppetdb($puppetdb_user, $puppetdb_pass, $puppetdb_dbname) {
  include puppetdb::packages
  class {'puppetdb::config':
    puppetdb_user   => $puppetdb_user,
    puppetdb_pass   => $puppetdb_pass,
    puppetdb_dbname => $puppetdb_dbname,
  }
}
