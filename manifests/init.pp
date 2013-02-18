class galera {
  #
  # Use the galera packages
  #
  # https://launchpad.net/codership-mysql/5.5/5.5.28-23.7/+download/
  #   mysql-server-wsrep-5.5.28-23.7-amd64.deb
  # https://launchpad.net/galera/2.x/23.2.2/+download/
  #   galera-23.2.2-amd64.deb
  $dbfile="mysql-server-wsrep-5.5.28-23.7-amd64.deb"
  $libfile="galera-23.2.2-amd64.deb"

#  file{'/var/log/mysql':
#    require     =>      Package['galera'],
#    ensure	=>	directory,
#    owner	=>	'root',
#    group	=>	'root',
#    mode	=>	'0755',
#  }

  package { galera:
    ensure => installed,
    provider => 'dpkg',
    source => "/tmp/$libfile",
    require => Package[galeraDB],
  }

  package { galeraDB:
    ensure => installed,
    provider => 'dpkg',
    source => "/tmp/$dbfile",
    require => Package[libdbi-perl, 'libssl0.9.8'],
  }

  package { 'libssl0.9.8':
    ensure => installed,
  }

  package { libdbi-perl:
    ensure => installed,
    require => Package[libplrpc-perl, libdbd-mysql-perl, libaio1, mysql-client],
  }

  package { libdbd-mysql-perl:
    ensure => installed,
  }

  package { libplrpc-perl:
    ensure => installed,
    require => Package['libnet-daemon-perl'],
  }

  package { libnet-daemon-perl:
    ensure => installed,
  }

  package { libaio1:
    ensure => installed,
  }

  package { mysql-client:
    ensure => installed,
    require => Package['mysql-client-5.5'],
  }

  package { 'mysql-client-5.5':
    ensure => installed,
    require => Package['mysql-client-core-5.5', 'libterm-readkey-perl'],
  }

  package { 'mysql-client-core-5.5':
    ensure => installed,
  }

  package { 'libterm-readkey-perl':
    ensure => installed,
  }

  file { galeraDBfile:
    ensure => file,
    path => "/tmp/$dbfile",
    source => "puppet:///modules/galera/$dbfile",
    before => Package[galeraDB],
  }

  file { galeralibfile:
    ensure => file,
    path => "/tmp/$libfile",
    source => "puppet:///modules/galera/$libfile",
    before => Package[galera],
  }

}
