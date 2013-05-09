# Puppet module: elasticsearch

This is a Puppet module for elasticsearch based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-elasticsearch

Module development sponsored by [AllOver.IO](http://www.allover.io)

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install elasticsearch with default settings, that is installation from official site, run as elasticsearch user, usage of Tanuki wrappers (retrived via git) for service management

        class { 'elasticsearch': }

* Install a specific version of elasticsearch package.

        class { 'elasticsearch':
          version => '0.20.2',
        }

* Provide a custom template for init script, its tanuki configuration file and elasticsearch's own config file

        class { 'elasticsearch':
          init_script_template  => 'site/elasticsearch/elasticsearch.init.erb',
          init_config_template  => 'site/elasticsearch/elasticsearch.conf.erb',
          template              => 'site/elasticsearch/elasticsearch.yml.erb',
        }

* Install without creating elastisearch user and providing in custom ways the modules' prerequisites. Note: Be user to have user and prerequisites created before elasticsearch

        class { 'elasticsearch':
          install_prerequisites  => false,
          create_user            => false,
        }

* Disable elasticsearch service.

        class { 'elasticsearch':
          disable => true
        }

* Remove elasticsearch package

        class { 'elasticsearch':
          absent => true
        }

* Enable auditing without without making changes on existing elasticsearch configuration *files*

        class { 'elasticsearch':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'elasticsearch':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'elasticsearch':
          source => [ "puppet:///modules/example42/elasticsearch/elasticsearch.conf-${hostname}" , "puppet:///modules/example42/elasticsearch/elasticsearch.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'elasticsearch':
          source_dir       => 'puppet:///modules/example42/elasticsearch/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'elasticsearch':
          template => 'example42/elasticsearch/elasticsearch.conf.erb',
        }

* Automatically include a custom subclass

        class { 'elasticsearch':
          my_class => 'example42::my_elasticsearch',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'elasticsearch':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'elasticsearch':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'elasticsearch':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'elasticsearch':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-elasticsearch.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-elasticsearch]
