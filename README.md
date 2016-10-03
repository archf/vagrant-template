# Simple vagrant template

Reusable template for:

 - single multi-machine
 - private network (bridged device)
 - vagrant-hostmanager (optional)

## Usage

The only thing you need to edit for single/multi-machine support are those 2
variables:

```ruby
HOSTNAME_PREFIX = 'testbox'

# ip: ip of 'netp' device
# group: group name of ansible inventory the box will be part of
hosts = [
  {name: 'm1', ip: '192.168.56.71',
   net: 'private_network', box: 'boxcutter/ubuntu1604', group: 'webserver'},
  {name: 'm2', ip: '192.168.56.72',
   net: 'private_network', box: 'bento/centos-7.1', group: 'db'}
]
```

And the provisionner...
