# -*- mode: ruby -*-
# vi: set ft=ruby :

# prefix that will be pre-pendend to every machines in the hosts list

HOSTNAME_PREFIX = 'demo'
DOMAIN = 'vlan'

# ip: ip of 'netp' device
# group: group name of ansible inventory the box will be part of
hosts = [
  {name: 'm1', ip: '192.168.56.71',
   net: 'private_network', box: 'bento/centos-7.1', group: 'webserver'},
  {name: 'm2', ip: '192.168.56.72',
   net: 'private_network', box: 'bento/centos-7.1', group: 'webserver'},
  {name: 'm3', ip: '192.168.56.73',
   net: 'private_network', box: 'boxcutter/ubuntu1604', group: 'dbserver'}
]

###############################################################################
# The only thing you will probably need to edit below this
# point is the provisioner
###############################################################################

Vagrant.configure(2) do |config|

  if Vagrant.has_plugin?("vagrant-hostmanager")
    # hook to Vagrant up and vagrant destroy
    config.hostmanager.enabled = true

    # allow /etc/hosts file updating
    config.hostmanager.manage_host = true

    # disable using the private network IP address
    config.hostmanager.ignore_private_ip = false

    # include box that are up or boxes with private IP
    config.hostmanager.include_offline = true
  end

 N=hosts.length

  (1..N).each do |machine_id|

    config.vm.define HOSTNAME_PREFIX + "-" + hosts[machine_id - 1][:name] do |node|
    # config.vm.define HOSTNAME_PREFIX + "-m#{machine_id}" do |node|

      # box name
      node.vm.box = hosts[machine_id - 1][:box]
      # box hostname
      node.vm.hostname = HOSTNAME_PREFIX + '-' + hosts[machine_id - 1][:name] \
              + '.' + DOMAIN

      # box extra interface
      node.vm.network hosts[machine_id - 1][:net], ip: hosts[machine_id - 1][:ip]

      # Only execute once the Ansible provisioner (all machines up and ready)
      if machine_id == N

        config.vm.provision :ansible do |ansible|

          ansible.groups = {}
          ansible.host_vars = {}

          # create ansible inventory groups to allow group_vars
          # box name must be valid
          for m in hosts do
            if ansible.groups.has_key?(m[:group])
              # append to list
              ansible.groups[m[:group]].push(HOSTNAME_PREFIX + '-' + m[:name])
            else
              # add new key
              ansible.groups[m[:group]] = [HOSTNAME_PREFIX + '-' + m[:name]]
            end

            ansible.host_vars[m[:name]] = {ansible_ssh_host:  m[:ip]}

          end # end groups

          # run the provisionner

          # ansible.verbose = 'v'
          # ansible.extra_vars = {users_debug: 'True'}

          # Disable default limit to connect to all the machines
          ansible.limit = 'all'
          ansible.playbook = 'test.yml'

        end #ansible vm.provision

      end # if machine_id == N

    end # machine_id if node.vm
  end # each loop
end
