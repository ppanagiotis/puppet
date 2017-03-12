# My puppet configuration

* Install puppetdb
* Setup puppet master with hiera and [trocla]
* Define users at hiera and create them at puppet nodes
* Setup postfix to use my mail server and set a default mail
* Enable auto update for security updates
* Use letsencrypt for auto renewal of my ssl certs
* Auto reload haproxy if a new ssl created  from letsencrypt
* Set up my dns servers at all puppet nodes
* Configure haproxy from hiera
* Collect all nginx sites and add them as frontends/backends at haproxy using exported resources

[trocla]: <https://github.com/duritong/trocla>
