#!/usr/bin/env python

import ipaddress
import itertools
import json
import urllib.request

with urllib.request.urlopen("https://api.github.com/meta") as response:
    meta = json.loads(response.read())
    with open(".github_keys.json", "w") as output:
        output.write(json.dumps(meta["ssh_keys"], indent=2, sort_keys=True))

    networks = [ipaddress.ip_network(cidr) for cidr in meta["git"]]

    hosts = []
    for network in networks:
        if isinstance(network, ipaddress.IPv6Network):
            if network.prefixlen < 32:
                networks.extend(network.subnets(new_prefix=32))
            else:
                hosts.append(f"{network.network_address}*")
        else:
            if network.prefixlen < 24:
                networks.extend(network.subnets(new_prefix=24))
            elif network.prefixlen == 24:
                prefix = str(network.network_address).rpartition('.')[0]
                hosts.append(f"{prefix}.*")
            else:
                hosts.extend((str(host) for host in network.hosts()))

    with open(".github_ips.json", "w") as output:
        output.write(json.dumps(hosts, indent=2, sort_keys=True))
