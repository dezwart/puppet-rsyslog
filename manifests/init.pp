# rsyslog service
#
# == Parameters
#
# [*remote*]
#   Specify true if this service is to receive remote syslog message.
#   Default is false.
#
# == Variables
#
# == Examples
#
#    class { 'rsyslog':
#        remote => true,
#    }
#
class rsyslog( $remote = false ) {
    package { 'rsyslog':
        ensure  => installed,
    }

    file { '/etc/rsyslog.conf':
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template('rsyslog/rsyslog.conf.erb'),
        require => Package['rsyslog'],
    }

    service { 'rsyslog':
        ensure      => running,
        enable      => true,
        require     => Package['rsyslog'],
        subscribe   => File['/etc/rsyslog.conf'],
    }
}
