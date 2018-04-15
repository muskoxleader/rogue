# rogue
CLI wrapper for fast provisioning and tear down of docker containers.
- Checkout code in persistent directories mounted within containers
- Build and deploy in isolated throw-away workspaces
- Simplied interface for common docker CLI parameters

## Provisioning containers
Simplified interface for launching containers using `docker run`.
```
$ rogue prov one --image centos:latest --port 8080:80
f8982062e6ef2717f737de38e1aaae7298a6d2a057fa56b65fe6c0a8afc59254
```

## Inspecting containers
Pass-through `container inspect` flags.
```
$ rogue show one --format '{{.Config.Hostname}}'
sandbox-one.local
$ rogue show one --format '{{.Driver}}'
aufs
$ rogue show one --format '{{.Mounts}}'
[{bind  /Users/fzhu/.rogue/one /root   true rprivate}]
```

## Listing containers
Pass-through `container ls` flags.
```
$ rogue ls
CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                  NAMES
14f7671c5d47        centos:latest       "/bin/bash"         Less than a second ago   Up 2 seconds        0.0.0.0:8080->80/tcp   one
```

## Accessing containers
Simplified interface for shelling into containers using `docker exec`.
```
$ rogue shell one
bash-4.2# hostname -f
sandbox-one.local
bash-4.2#
```

## Tearing down containers
Simplified interface for stopping and removing containers.
```
$ rogue scrap one
Stopping: one
Removing: one
$ rogue ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
$ ll ~/.rogue/one/
total 8
-rw-------  1 fzhu  staff    18B Apr 15 02:03 .bash_history
```

## Setting environment variables
At provision time.
```
$ rogue prov one --env ROGUE_ENV=sandbox
46c787e6ca666437afc5661fde77a2701196bec91ac1935f70d576b1f0fadbc1
$ rogue shell one
bash-4.1# env | grep ROGUE_ENV
ROGUE_ENV=sandbox
```
At exec time.
```
$ rogue shell one --env ROGUE_ENV=sandbox
bash-4.1# env | grep ROGUE_ENV
ROGUE_ENV=sandbox
```

## Template files
Files in `$HOME/.rogue/.templates` will be copied into `/` of provisioned containers at provisioning time.
```
$ ll $HOME/.rogue/.templates/root
total 40
-rw-r--r--  1 fzhu  staff   161B Apr 15 20:16 .gitconfig
-rw-r--r--  1 fzhu  staff   1.5K Apr 15 20:43 .tmux.conf
-rw-r--r--  1 fzhu  staff   3.2K Apr 15 20:43 .vimrc
```

## Overriding default settings
Some default settings can be overridden using `$HOME/.rogue/.templates`.
```
DEFAULT_CONTAINER_IMAGE=centos:centos6
DEFAULT_DNS_ZONE=corp.example.com
DEFAULT_REGISTRY=docker-registry.example.com:443
```
