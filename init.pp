class httpd {

  package { 'httpd':
    ensure => 'installed',
}

  file { 'httpd.conf':
    path    => '/etc/httpd/conf/httpd.conf',
    ensure  => 'present', 
    source  => 'puppet:///modules/httpd/httpd.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    require => Package['httpd'],
    notify  => Service['httpd'],
}

  file { 'index.html':
    path    => '/var/www/html/index.html',
    ensure  => 'file',
    source  => 'puppet:///modules/httpd/index.html',
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    require => Package['httpd'],
    notify  => Service['httpd'],
}

  service { 'httpd':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package ['httpd'],
}

}
