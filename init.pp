Class httpd {

package { 'httpd':
    ensure => 'installed',
    before => File[‘/var/www/html/index.html’],
}

file { '/etc/httpd/conf/httpd.conf':
    ensure  => 'file', 
    source  => 'puppet:///modules/httpd/httpd.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    require => Package['httpd'],
}

file { '/var/www/html/index.html':
    ensure  => 'file',
    source  => 'puppet:///modules/httpd/index.html',
    owner   => 'root',
    group   => 'root',
    mode    => '755',
}

service { 'httpd':
    ensure => 'running',
    enable => true,
    hasstatus => true,
    hasrestart => true,
    subscribe => File [‘/etc/httpd/conf/httpd.conf’],
    subscribe => File [‘/var/www/html/index.html’],
}
}
