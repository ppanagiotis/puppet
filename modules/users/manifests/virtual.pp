#
define users::virtual ($realname, $uid, $groups, $password, $shell, $sshkey, $sshkeytype) {

  user { $name:
    ensure     => 'present',
    uid        => $uid,
    gid        => $name,
    shell      => $shell,
    home       => "/home/$name",
    groups     => $groups,
    managehome => true,
    name       => $name,
    require    =>  Group[$name],
    password   => $password,
    comment    => $realname
  }

  group { $name:
    gid => $uid,
  }

  if ($sshkey != '') {
    ssh_authorized_key {$title:
      ensure => present,
      name   => $title,
      user   => $title,
      type   => $sshkeytype,
      key    => $sshkey,
    }
  }
}
