class base (

    # Puppet related
    Boolean $manage_puppet      = true,

    # Network related
    Boolean $network_manager    = false,

    # Default packages
    Array   $yum_packages       = ['git', 'zsh', 'htop', 'mc'],
) {
    
    # manage puppet module
    # @todo: create private puppet module, this one can only install puppet, you can add, for example, config params 
    if $manage_puppet {
        include base::resources::puppet_agent
    }

    # manage epel
    include ::epel

    # install yum packages
    create_resources('package', $yum_packages)

    # disable network manager
    service {'NetworkManager':
        enable => $network_manager,
        ensure => $network_manager ? { false => 'stopped', default => 'running' }
    }

    # @todo: sysadmins
    # @todo: backup user

}