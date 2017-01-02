#
class profile::base {
  include users::realize
  include postfix
  include security_updates
  include resolvconf
}
