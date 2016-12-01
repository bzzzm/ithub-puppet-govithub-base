class base::resources::puppet (
    Boolean $agent      = true,
    String  $server     = "puppet",
    String  $ca_server  = "puppet",
    Integer $interval   = 900,
    Boolean $daemon     = true
) {

    file {'puppet-conf':
        path => "/etc/puppetlabs/puppet/puppet.conf",
        content => template('base/resources/puppet/puppet.conf.erb'),
        notify => Service['puppet']
    }

    # enable daemon
    if $agent {
        service {'puppet':
            ensure => $daemon ? {
                true => running,
                false => stopped,
            },
            hasstatus => true,
            hasrestart => true
        }    
    }
}