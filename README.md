# freeswitch-docker

build freeswitch container on scratch using DIND

`script/make_min_archive.sh` borrowed from SignalWire Repo (https://github.com/signalwire/freeswitch/blob/f6c10f8622e997548a486e5bf4f700b37e12a4eb/docker/base_image/README.md)

```bash
docker build . -t freeswitch:latest

# run with host network
docker run --rm --net=host --name freeswitch freeswitch:latest

# without host network
docker run --rm --name freeswitch freeswitch:latest

# connect via fs_cli
docker exec -i -t freeswitch /usr/bin/fs_cli

# setup an alias for fs_cli
alias fs_cli='docker exec -i -t freeswitch /usr/bin/fs_cli'
```
