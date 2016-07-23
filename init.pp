Class httpd {

package { 'httpd':
    ensure => 'installed',
    before => File[‘/etc/httpd/conf/httpd.conf’],
}

file { '/etc/httpd/conf/httpd.conf':
    ensure  => 'file', 
    source  => 'puppet:///modules/httpd/httpd.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
}

file { '/var/www/html/index.html':
    ensure  => 'file',
    source  => 'puppet:///modules/httpd/index.html',
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    require => Package['httpd'],
}

service { 'httpd':
    ensure => 'running',
    enable => true,
    hasstatus => true,
    hasrestart => true,
    subscribe => File [‘/etc/httpd/conf/httpd.conf’],
}
}
