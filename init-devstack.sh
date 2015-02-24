set -e

#git clone https://github.com/openstack-dev/devstack.git
#git clone https://github.com/openstack/manila.git

cp manila/contrib/devstack/lib/manila devstack/lib/
cp manila/contrib/devstack/extras.d/70-manila.sh devstack/extras.d/

# A script to setup manila devstack on Ubuntu 14.04
sudo apt-get -y install git git-review python-pip python-setuptools python-dev libxslt-dev libmysqlclient-dev libpq-dev nfs-common screen
sudo apt-get -y update
sudo apt-get -y upgrade
#git clone git://github.com/openstack/manila.git
#git clone git://github.com/openstack-dev/devstack.git
cp -r manila/contrib/devstack/* devstack
cd devstack

cat << __EOF__ > local.conf
[[local|localrc]]
ADMIN_PASSWORD=nova
DATABASE_PASSWORD=nova
RABBIT_PASSWORD=nova
SERVICE_PASSWORD=nova
SERVICE_TOKEN=nova
GUEST_PASSWORD=nova
MYSQL_HOST=127.0.0.1
MYSQL_USER=root
MYSQL_PASSWORD=nova
RABBIT_HOST=127.0.0.1
LIBVIRT_TYPE=qemu
GLANCE_HOSTPORT=127.0.0.1:9292
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5
SWIFT_REPLICAS=1
SWIFT_DATA_DIR=\$DEST/data/swift
LOGDAYS=1
LOGFILE=\$DEST/devstack.log
SCREEN_LOGDIR=\$DEST/logs/screen
RECLONE=yes
API_RATE_LIMIT=False

disable_service horizon
disable_service heat
disable_service h-eng
disable_service h-api
disable_service h-api-cfn
disable_service h-api-cw
disable_service n-net
enable_service neutron
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
enable_service tempest
enable_service manila
enable_service m-api
enable_service m-sch
enable_service m-shr
Q_PLUGIN=ml2
ENABLE_TENANT_VLANS=True
ML2_VLAN_RANGES=physnet1:100:200
PHYSICAL_NETWORK=physnet1
OVS_PHYSICAL_BRIDGE=br-eth1
Q_ML2_PLUGIN_MECHANISM_DRIVERS=openvswitch
Q_ML2_PLUGIN_TYPE_DRIVERS=vlan,vxlan
SHARE_BACKING_FILE_SIZE=22G
__EOF__

