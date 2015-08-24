# Ubuntu packer templates for mesos

## Create Master image

```bash
packer build ubuntu-14.04-server-amd64-master.json
```

## Create Slave image

```bash
packer build ubuntu-14.04-server-amd64-slave.json
```

## Software pre-installed
Look in scripts/packages.sh
Look in scripts/master.sh
Look in scripts/slave.sh


