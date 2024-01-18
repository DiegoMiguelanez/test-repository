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

● CPU Usage

● RAM

● Disk Space (focusing mainly on SSL cert and files partition and root partition if machine consists on different partitions)

● Network traffic (Monitor 10Gbit/s network traffic to anticipate network Bottleneck)

● Requests per second

● Latency



[2] How would you do that?
---
1. Install Nagios Core on Almalinux9 VM following:
- [Fedora Easy Setup](https://support.nagios.com/kb/article/nagios-core-installing-nagios-core-from-source-96.html#Fedora)

2. Install Nagios Core Plugins

These are standalone extensions that process command-line arguments and monitor just about anything in Nagios Core.(Missing RAM, Network traffic, Requests per second and latency)
```bash
cd /usr/src/nagios-plugins
wget https://github.com/nagios-plugins/nagios-plugins/releases/download/release-2.4.4/nagios-plugins-2.4.4.tar.gz
./configure
make
make install
```
3. Installed NRPE Plugin
Agent used for communicating with remote hosts, also check port 5666 is open for it to correctly work.
```bash
dnf install nrpe
```
4. Adding a Remote Host via configuration file
Add nodes.cfg where the node to monitor is specified, Debian in my case, I uploaded the file "nodes.cfg" to this repository.
Also add services to monitor, in this case previously installed "Nagios Core Plugins" for CPU load average, Disk space, ping check and http.

HTTP also to see if webserver is up since as the exercise mentioned, the server is used for SSL offloading and proxying, so I understand it will have installed an nginx or apache server to do so.

My config file for this step: [nodes.cfg](https://github.com/DiegoMiguelanez/test-repository/blob/main/nodes.cfg)

```bash
vim /usr/local/nagios/etc/objects/nodes.cfg
```


[3] What are the challenges of monitoring this?





