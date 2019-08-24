#!/usr/bin/env bash

set -e

dir="$HOME/.local/share/fk-dockerfiles"
bin="$HOME/.local/bin"

mkdir -p "$dir"
mkdir -p "$bin"

pushd "$dir"

function finish {
    popd
}

trap finish EXIT

echo ">>> CLONING DOCKERFILES"
if ! [ -d "$dir/dockerfiles" ]
then
    echo ">>> >> new repo"
    git clone https://github.com/freakhill/dockerfiles.git
else
    pushd dockerfiles
    echo ">>> >> reset and pull repo"
    git reset --hard HEAD
    git pull
    popd
fi

cd dockerfiles/basedev

echo ">>> LINKING SHELL BINARY"
ln -sf "$(pwd)/shell" "$bin/shell"
ln -sf "$(pwd)/start" "$bin/start-fk-dev-container"
type -a shell || cat <<EOF >> $HOME/.bashrc

###########################################
# from freakhill/dockerfiles.git          #
###########################################
export PATH=$PATH:"$bin"

EOF

echo ">>> BUILDING FK-DEV DOCKER IMAGE"
./build

echo ">>> STARTING CONTAINER"
./start

echo ">>> WAITING FOR CONTAINER"
while true
do
    status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 $USER@127.0.0.1 -p 10022 echo ok)
    if [[ "$status" =~ "Host key verification failed" ]]
    then
        cat <<EOF

>>> final step

1. Start a new shell
2. Call: shell
EOF
        exit 0
    elif [[ "$status" =~ "ok" ]]
    then
        cat <<EOF

>>> final step

1. Start a new shell
2. Call: shell
EOF
        exit 0
    else
        cat <<EOF
could not detect server yet...
(if it gets long just C-c out, start a new bash and call 'shell'.

EOF
        sleep 1
    fi
done
