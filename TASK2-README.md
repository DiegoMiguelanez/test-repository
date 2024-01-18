Imagine a server with the following specs:

● 4 times Intel(R) Xeon(R) CPU E7-4830 v4 @ 2.00GHz

● 64GB of ram

● 2 tb HDD disk space

● 2 x 10Gbit/s nics

The server is used for SSL offloading and proxies around 25000 requests per
second.

---
[1] Which metrics are interesting to monitor in that specific case?
---
● ping

● Disk Space (focusing mainly on SSL cert and files partition and root partition if machine consists on different partitions)

● CPU Load

● HTTP

● RAM

● Network traffic (Monitor 10Gbit/s network traffic to anticipate network Bottleneck)

● Requests per second

● Latency



[2] How would you do that?
---
## 1. Install Nagios Core on Almalinux9 VM following:
- [Fedora Easy Setup](https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html#Fedora)

## 2. Install Nagios Core Plugins

These are standalone extensions that process command-line arguments and monitor just about anything in Nagios Core.(Missing RAM, Network traffic, Requests per second and latency)
```bash
cd /usr/src/nagios-plugins
wget https://github.com/nagios-plugins/nagios-plugins/releases/download/release-2.4.4/nagios-plugins-2.4.4.tar.gz
./configure
make
make install
```
## 3. Install NRPE Plugin
Agent used for communicating with remote hosts, also check port 5666 is open for it to correctly work.
```bash
dnf install nrpe
```
## 4. Adding a Remote Host via configuration file
Add nodes.cfg where the node to monitor is specified, Debian in my case, I uploaded the file "nodes.cfg" to this repository.
Also add services to monitor, in this case previously installed "Nagios Core Plugins" for CPU load average, Disk space, ping check and http.

HTTP also to see if webserver is up since as the exercise mentioned, the server is used for SSL offloading and proxying, so I understand it will have installed an nginx or apache server to do so.

My config file for this step: [nodes.cfg](https://github.com/DiegoMiguelanez/test-repository/blob/main/nodes.cfg)

```bash
vim /usr/local/nagios/etc/objects/nodes.cfg
```

## 5. Create custom plugin for RAM metric

I created custom script for RAM metric called [check_ram](https://github.com/DiegoMiguelanez/test-repository/blob/main/check_ram) in bash following Nagios required format of return codes:

0: OK
1: WARNING
2: CRITICAL
3: UNKNOWN (Didn't add it for this one)

And Stdout message with echo -> [[STATUS-CODE]] - [[DESCRIPTIVE-MESSAGE]]

My script [check_ram](https://github.com/DiegoMiguelanez/test-repository/blob/main/check_ram) will return:

```Bash
OK - RAM Total: 1967MB, Used: 398MB, Free: 1258MB, Usage Percentage: 20.23%
```

## 6. Add plugin to Debian SSL offloading server and configure it in AlmaLinux9 Nagios Server
```Bash
scp check_ram root@debian:/usr/local/nagios/libexec
```

Add command in AlmaLinux9
```Bash
vim /usr/local/nagios/etc/objects/commands.cfg

##########CUSTOM PLUGINS#########

define command {
  command_name    check_ram
  command_line    /usr/local/nagios/libexec/check_ram
}

```
Add it as a service to monitor Debian SSL offloading server
```Bash
vi /usr/local/nagios/etc/objects/nodes.cfg

define service {
    use                     local-service
    host_name               debian
    service_description     RAM
    check_command           check_ram
    max_check_attempts      3
}
```

Now check in Nagios webapp that plugin is correctly working and monitoring "Debian SSL offloading server"'s RAM
   ```bash
   	
RAM
OK	01-18-2024 21:22:57	0d 0h 1m 49s	1/3	OK - RAM Total: 1967MB, Used: 398MB, Free: 1258MB, Usage Percentage: 20.23%
   ```

[3] What are the challenges of monitoring this?





