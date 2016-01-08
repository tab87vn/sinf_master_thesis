#!/bin/bash

# compute.sh


echo "########## PREPARING... ##########"

export CONTROLLER_HOST=172.31.20.200
export CONTROLLER_EXT_HOST=172.31.22.200

export NETWORK_HOST=172.31.20.201
export NETWORK_VMN_HOST=172.31.21.201
export NETWORK_EXT_HOST=172.31.22.201

export COMPUTE1_HOST=172.31.20.202
export COMPUTE1_VMN_HOST=172.31.21.202
export COMPUTE1_EXT_HOST=172.31.22.202

export COMPUTE2_HOST=172.31.20.203
export COMPUTE2_VMN_HOST=172.31.21.203
export COMPUTE2_EXT_HOST=172.31.22.203

export INSTALL_DIR=/home/ubuntu/junoscript
export HOME_DIR=/home/ubuntu
# export INSTALL_DIR=/vagrant
# export HOME_DIR=/home/vagrant

# interfaces & bridges
export MNG_IP=172.31.20.202
export VMN_IP=172.31.21.202
export VMN_BR=br-eth1
export VMN_IF=eth1
export EXT_IP=172.31.20.203
export EXT_BR=br-ex
export EXT_IF=eth2

export PUBLIC_IP=${MNG_IP} #EXT_IP
export INT_IP=${MNG_IP}
export ADMIN_IP=${MNG_IP} #EXT_IP

export GLANCE_HOST=${CONTROLLER_HOST}
export MYSQL_HOST=${CONTROLLER_HOST}
export KEYSTONE_ADMIN_ENDPOINT=${CONTROLLER_HOST}
export KEYSTONE_ENDPOINT=${KEYSTONE_ADMIN_ENDPOINT}
export CONTROLLER_EXTERNAL_HOST=${KEYSTONE_ADMIN_ENDPOINT}
export MYSQL_NEUTRON_PASS=openstack
export SERVICE_TENANT_NAME=service
export SERVICE_PASS=openstack
export ENDPOINT=${KEYSTONE_ADMIN_ENDPOINT}
export SERVICE_TOKEN=ADMIN
export SERVICE_ENDPOINT=https://${KEYSTONE_ADMIN_ENDPOINT}:35357/v2.0
export MONGO_KEY=MongoFoo
export OS_CACERT=${INSTALL_DIR}/ca.pem
export OS_KEY=${INSTALL_DIR}/cakey.pem
export CINDER_ENDPOINT=${CONTROLLER_HOST}

# configure host resolution
echo "
# OpenStack hosts
${CONTROLLER_HOST} controller.ostest controller
${NETWORK_HOST} network.ostest network
${COMPUTE1_HOST} compute-01.ostest compute-01
${COMPUTE2_HOST} compute-02.ostest compute-02" | sudo tee -a /etc/hosts

# UPGRADE
sudo apt-get install -y software-properties-common ubuntu-cloud-keyring
sudo add-apt-repository -y cloud-archive:juno
sudo apt-get update && sudo apt-get upgrade -y


# ssh-keyscan controller >> ~/.ssh/known_hosts
# cat ${INSTALL_DIR}/id_rsa.pub | sudo tee -a /root/.ssh/authorized_keys
# cp ${INSTALL_DIR}/id_rsa* ~/.ssh/
# sudo scp ubuntu@controller:/etc/ssl/certs/ca.pem /etc/ssl/certs/ca.pem
sudo c_rehash /etc/ssl/certs/ca.pem

#######################
# Chapter 4 - Compute #
#######################

# Must define your environment
MYSQL_HOST=${CONTROLLER_HOST}
GLANCE_HOST=${CONTROLLER_HOST}

SERVICE_TENANT=service
NOVA_SERVICE_USER=nova
NOVA_SERVICE_PASS=nova

nova_compute_install() {
	# Install some packages:
	sudo apt-get -y install ntp nova-api-metadata nova-compute nova-compute-qemu nova-doc novnc nova-novncproxy sasl2-bin
	sudo apt-get -y install neutron-common neutron-plugin-ml2 neutron-plugin-openvswitch-agent
	# [DVR] # sudo apt-get -y install neutron-l3-agent
	sudo apt-get -y install vlan bridge-utils
	sudo apt-get -y install libvirt-bin pm-utils sysfsutils
	sudo service ntp restart
}

nova_configure() {

# Networking
# ip forwarding
echo "net.ipv4.ip_forward=1
net.ipv4.conf.all.rp_filter=0
net.ipv4.conf.default.rp_filter=0" | tee -a /etc/sysctl.conf
sysctl -p

# configure libvirtd.conf
cat > /etc/libvirt/libvirtd.conf << EOF
listen_tls = 0
listen_tcp = 1
unix_sock_group = "libvirtd"
unix_sock_ro_perms = "0777"
unix_sock_rw_perms = "0770"
unix_sock_dir = "/var/run/libvirt"
auth_unix_ro = "none"
auth_unix_rw = "none"
auth_tcp = "none"
EOF

# configure libvirtd.conf
cat > /etc/libvirt/libvirt.conf << EOF
uri_default = "qemu:///system"
EOF

# configure libvirt-bin.conf
sudo sed -i 's/libvirtd_opts="-d"/libvirtd_opts="-d -l"/g' /etc/default/libvirt-bin

# restart libvirt
sudo service libvirt-bin restart

# OpenVSwitch
sudo apt-get install -y linux-headers-`uname -r` build-essential
sudo apt-get install -y openvswitch-switch

# OpenVSwitch Configuration
#br-int will be used for VM integration
sudo ovs-vsctl add-br br-int

# Neutron Tenant Tunnel Network
sudo ovs-vsctl add-br ${VMN_BR}
sudo ovs-vsctl add-port ${VMN_BR} ${VMN_IF}

# In reality you would edit the /etc/network/interfaces file for eth3?
sudo ifconfig ${VMN_IF} 0.0.0.0 up
sudo ip link set ${VMN_IF} promisc on
# Assign IP to br-eth2 so it is accessible
sudo ifconfig ${VMN_BR} ${VMN_IP} netmask 255.255.255.0

#
# Uncomment for DVR
#
# Neutron External Router Network
#sudo ovs-vsctl add-br ${EXT_BR}
#sudo ovs-vsctl add-port ${EXT_BR} ${EXT_IF}
#
## In reality you would edit the /etc/network/interfaces file for eth3
#sudo ifconfig ${EXT_IF} 0.0.0.0 up
#sudo ip link set ${EXT_IF} promisc on
## Assign IP to br-ex so it is accessible
#sudo ifconfig ${EXT_BR} ${EXT_IP} netmask 255.255.255.0


# Config Files
NEUTRON_CONF=/etc/neutron/neutron.conf
NEUTRON_PLUGIN_ML2_CONF_INI=/etc/neutron/plugins/ml2/ml2_conf.ini
NEUTRON_L3_AGENT_INI=/etc/neutron/l3_agent.ini
NEUTRON_DHCP_AGENT_INI=/etc/neutron/dhcp_agent.ini
NEUTRON_METADATA_AGENT_INI=/etc/neutron/metadata_agent.ini

NEUTRON_SERVICE_USER=neutron
NEUTRON_SERVICE_PASS=neutron

# Configure Neutron
cat > ${NEUTRON_CONF} << EOF
[DEFAULT]
verbose = True
debug = True
state_path = /var/lib/neutron
lock_path = \$state_path/lock
log_dir = /var/log/neutron

bind_host = 0.0.0.0
bind_port = 9696

# Plugin
core_plugin = ml2
service_plugins = router
allow_overlapping_ips = True
#router_distributed = True
#dvr_base_mac = fa:16:3f:01:00:00

# auth
auth_strategy = keystone
nova_api_insecure = True

# RPC configuration options. Defined in rpc __init__
# The messaging module to use, defaults to kombu.
rpc_backend = neutron.openstack.common.rpc.impl_kombu

rabbit_host = ${CONTROLLER_HOST}
rabbit_password = guest
rabbit_port = 5672
rabbit_userid = guest
rabbit_virtual_host = /
rabbit_ha_queues = false

# ============ Notification System Options =====================
notification_driver = neutron.openstack.common.notifier.rpc_notifier

[agent]
root_helper = sudo

[keystone_authtoken]
auth_host = ${KEYSTONE_ADMIN_ENDPOINT}
auth_port = 35357
auth_protocol = https
admin_tenant_name = ${SERVICE_TENANT}
admin_user = ${NEUTRON_SERVICE_USER}
admin_password = ${NEUTRON_SERVICE_PASS}
signing_dir = \$state_path/keystone-signing
insecure = True

[database]
connection = mysql://neutron:${MYSQL_NEUTRON_PASS}@${CONTROLLER_HOST}/neutron

[service_providers]
#service_provider=LOADBALANCER:Haproxy:neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default
#service_provider=FIREWALL:Iptables:neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver:defaul
#service_provider=VPN:openswan:neutron.services.vpn.service_drivers.ipsec.IPsecVPNDriver:default

EOF

#
# Chapter 3 - Networking DVR
#

#cat > ${NEUTRON_L3_AGENT_INI} << EOF
#[DEFAULT]
#interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver
#use_namespaces = True
#agent_mode = dvr
#external_network_bridge = br-ex
#verbose = True
#EOF

cat > ${NEUTRON_PLUGIN_ML2_CONF_INI} << EOF
[ml2]
type_drivers = gre,vxlan
tenant_network_types = vxlan
mechanism_drivers = openvswitch,l2population

[ml2_type_gre]
tunnel_id_ranges = 1:1000

[ml2_type_vxlan]
vni_ranges = 1:1000

#[vxlan]
#enable_vxlan = True
#vxlan_group =
#local_ip = ${ETH2_IP}
#l2_population = True

[agent]
tunnel_types = vxlan
l2_population = True
#enable_distributed_routing = True
#arp_responder = True

[ovs]
local_ip = ${MNG_IP}
tunnel_type = vxlan
enable_tunneling = True
l2_population = True
#enable_distributed_routing = True
tunnel_bridge = br-tun



[securitygroup]
firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
enable_security_group = True
EOF

echo "
Defaults !requiretty
neutron ALL=(ALL:ALL) NOPASSWD:ALL" | tee -a /etc/sudoers

# Metadata
cat > ${NEUTRON_METADATA_AGENT_INI} << EOF
[DEFAULT]
auth_url = https://${KEYSTONE_ENDPOINT}:5000/v2.0
auth_region = regionOne
admin_tenant_name = service
admin_user = neutron
admin_password = neutron
nova_metadata_ip = ${CONTROLLER_HOST}
auth_insecure = True
metadata_proxy_shared_secret = foo
EOF


# Restart Neutron Services
service neutron-plugin-openvswitch-agent restart
restart neutron-metadata-agent

# Qemu or KVM (VT-x/AMD-v)
KVM=$(egrep '(vmx|svm)' /proc/cpuinfo)
if [[ ${KVM} ]]
then
	LIBVIRT=kvm
else
	LIBVIRT=qemu
fi


# Clobber the nova.conf file with the following
NOVA_CONF=/etc/nova/nova.conf
NOVA_API_PASTE=/etc/nova/api-paste.ini
#copy cert from controller to trust it

cat > ${NOVA_CONF} <<EOF
[DEFAULT]
dhcpbridge_flagfile=/etc/nova/nova.conf
dhcpbridge=/usr/bin/nova-dhcpbridge
logdir=/var/log/nova
state_path=/var/lib/nova
lock_path=/var/lock/nova
root_helper=sudo nova-rootwrap /etc/nova/rootwrap.conf
verbose=True

use_syslog = True
syslog_log_facility = LOG_LOCAL0

api_paste_config=/etc/nova/api-paste.ini
enabled_apis=ec2,osapi_compute,metadata

# Libvirt and Virtualization
libvirt_use_virtio_for_bridges=True
connection_type=libvirt
#libvirt_type=${LIBVIRT}
compute_driver = libvirt.LibvirtDriver 
libvirt_type=kvm

# Database
sql_connection=mysql://nova:openstack@${MYSQL_HOST}/nova

# Messaging
rabbit_host=${MYSQL_HOST}

# EC2 API Flags
ec2_host=${MYSQL_HOST}
ec2_dmz_host=${MYSQL_HOST}
ec2_private_dns_show_ip=True

# Network settings
network_api_class=nova.network.neutronv2.api.API
neutron_url=http://${CONTROLLER_HOST}:9696
neutron_auth_strategy=keystone
neutron_admin_tenant_name=service
neutron_admin_username=neutron
neutron_admin_password=neutron
neutron_admin_auth_url=https://${KEYSTONE_ENDPOINT}:5000/v2.0
libvirt_vif_driver=nova.virt.libvirt.vif.LibvirtHybridOVSBridgeDriver
linuxnet_interface_driver=nova.network.linux_net.LinuxOVSInterfaceDriver
#firewall_driver=nova.virt.libvirt.firewall.IptablesFirewallDriver
security_group_api=neutron
firewall_driver=nova.virt.firewall.NoopFirewallDriver
neutron_ca_certificates_file=/etc/ssl/certs/ca.pem

service_neutron_metadata_proxy=true
neutron_metadata_proxy_shared_secret=foo

#Metadata
metadata_host = ${CONTROLLER_HOST}
metadata_listen = ${CONTROLLER_HOST}
metadata_listen_port = 8775

# Cinder #
volume_driver=nova.volume.driver.ISCSIDriver
enabled_apis=ec2,osapi_compute,metadata
volume_api_class=nova.volume.cinder.API
iscsi_helper=tgtadm
iscsi_ip_address=${CINDER_ENDPOINT}

# Images
image_service=nova.image.glance.GlanceImageService
glance_api_servers=${GLANCE_HOST}:9292

# Scheduler
scheduler_default_filters=AllHostsFilter

# Auth
auth_strategy=keystone
keystone_ec2_url=https://${KEYSTONE_ENDPOINT}:5000/v2.0/ec2tokens

# NoVNC
novnc_enabled=true
novncproxy_host=${CONTROLLER_HOST}
novncproxy_base_url=http://${CONTROLLER_HOST}:6080/vnc_auto.html
novncproxy_port=6080
#
xvpvncproxy_port=6081
xvpvncproxy_host=${CONTROLLER_HOST}
xvpvncproxy_base_url=http://${CONTROLLER_HOST}:6081/console

vnc_enabled = True
vncserver_proxyclient_address=${MNG_IP}
#vncserver_proxyclient_address=${EXT_IP}
vncserver_listen=0.0.0.0

[keystone_authtoken]
admin_tenant_name = ${SERVICE_TENANT}
admin_user = ${NOVA_SERVICE_USER}
admin_password = ${NOVA_SERVICE_PASS}
identity_uri = https://${KEYSTONE_ADMIN_ENDPOINT}:35357/
insecure = True


EOF

sudo chmod 0640 $NOVA_CONF
sudo chown nova:nova $NOVA_CONF

}


##############################
# Chapter 9 - More OpenStack #
##############################

# nova_ceilometer() {
# 	/vagrant/ceilometer-compute.sh
# }

nova_restart() {
	sudo stop libvirt-bin
	sudo start libvirt-bin
	for P in $(ls /etc/init/nova* | cut -d'/' -f4 | cut -d'.' -f1)
	do
		sudo stop ${P}
		sudo start ${P}
	done
}

# Main
nova_compute_install
nova_configure
# nova_ceilometer
nova_restart

# sleep 90; echo "[+] Restarting nova-* on controller"
# ssh root@controller "cd /etc/init; ls nova-* neutron-server.conf | cut -d '.' -f1 | while read N; do stop \$N; start \$N; done"
# sleep 30; echo "[+] Restarting nova-* on compute"
# nova_restart
# start neutron-l3-agent
# 
# # Because live-migration
# # Do some terrible things for GID/UID mapping on compute nodes:
# UID=`ssh root@controller "id nova | awk {'print $1'} | cut -d '=' -f2 | cut -d '(' -f1"`
# GID=`ssh root@controller "id nova | awk {'print $1'} | cut -d '=' -f2 | cut -d '(' -f1"`
# sudo usermod -u $UID nova
# sudo groupmod -g $GID nova
# 
# # Logging
# sudo stop rsyslog
# sudo cp ${INSTALL_DIR}/rsyslog.conf /etc/rsyslog.conf
# sudo echo "*.*         @@controller:5140" >> /etc/rsyslog.d/50-default.conf
# sudo service rsyslog restart
# 
# # Copy openrc file to local instance vagrant root folder in case of loss of file share
# sudo cp ${INSTALL_DIR}/openrc ${HOME_DIR} 
