Description
===========

A [Vagrant](http://vagrantup.com/) setup of an Ubuntu 10.04 (Lucid) virtual machine which provisions with [chef-solo](http://wiki.opscode.com/display/chef/Chef+Solo) an [Openfire XMPP server](http://www.igniterealtime.org/projects/openfire/) using MySQL as the storage backend.

Automatically configured to use UTC.

Requirements
============
 * [Vagrant](http://vagrantup.com/) 0.8.7
 * [VirtualBox](https://www.virtualbox.org/) >= 4.1.0

Usage
=====
If you don't have a lucid32 base machine in Vagrant:

    $ vagrant box add lucid32 http://files.vagrantup.com/lucid32.box

Once you are all set with the box, in the directory where you have checked out this project you do:

    $ vagrant up

After some time you should have a virtual machine provisioned and running a copy of Openfire with the following default ports mapped to localhost:

    openfire_xmpp1: 5269 => 5269
    openfire_xmpp: 7070 => 7070
    openfire_xmpp2: 5222 => 5222
    openfire_xmpp3: 5223 => 5223
    openfire_admin: 9090 => 9090
    ssh: 22 => 2222


Upon successful startup you can direct your browser to http://localhost:9090 and log into the Openfire administration panel with user: admin / password: admin


Credits
=======
Uses modified cookbooks from:
 
 * [Opscode](http://www.opscode.com/)
	* [java](https://github.com/opscode/cookbooks/tree/master/java)
	* [MySQL](https://github.com/opscode/cookbooks/tree/master/mysql)
	* [Database](https://github.com/opscode/cookbooks/tree/master/database)

 * [37 signals](http://37signals.com/)
	* [timezone](https://github.com/37signals/37s_cookbooks/tree/master/timezone)

Inspired by the project available in [osw-vagrant](https://github.com/owengriffin/osw-vagrant)