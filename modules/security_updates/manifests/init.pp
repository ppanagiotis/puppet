#
class security_updates {
  include security_updates::packages
  include security_updates::config
}
