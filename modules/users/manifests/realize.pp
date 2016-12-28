#
class users::realize {

  $users = hiera_hash('users',{})
  create_resources('users::virtual', $users)

}
