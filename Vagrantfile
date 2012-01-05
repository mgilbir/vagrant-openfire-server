Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  # config.vm.network "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port "http", 80, 8080


  config.vm.forward_port("openfire_admin", 9090, 9090)
  config.vm.forward_port("openfire_xmpp", 7070, 7070)
  config.vm.forward_port("openfire_xmpp1", 5269, 5269)
  config.vm.forward_port("openfire_xmpp2", 5222, 5222)
  config.vm.forward_port("openfire_xmpp3", 5223, 5223)

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")
  #  chef.log_level = :debug
 
  #   # You may also specify custom JSON attributes:
    chef.json.merge!({
    :mysql => {
      :server_root_password => ""
    },
      "java" => {
      "install_flavor" => "sun"
  }
  })
  end
end
