# rsyslog service
#
# == Parameters
#
# [*remote*]
#   Specify true if this service is to receive remote syslog message.
#   Default is false.
#
# [*forwarders*]
#   List of Syslog remote forwarders to send messages to.
#
# == Variables
#
# == Examples
#
#    class { 'rsyslog':
#        remote => true,
#    }
#
class rsyslog( $remote = false,
    $forwarders = undef ) {

    $package = 'rsyslog'
    $service = 'rsyslogd'

    package { $package:
        ensure  => installed,
    }

    file { "/etc/$package.conf":
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template("$name/$package.conf.erb"),
        require => Package[$package],
    }

    service { $service:
        ensure      => running,
        enable      => true,
        require     => Package[$package],
        subscribe   => File['/etc/rsyslog.conf'],
    }
}
