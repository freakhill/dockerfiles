#!/usr/bin/env bash

# secure file transfer
pip install --user magic-wormhole

# awscli...
pip install --user awscli

# rust implementation of minisign, a tool to sign and verify files
#cargo install rsign

# CSV,JSON,Redis,Mysql,PostgreSQL querying with SQL
wget https://github.com/cube2222/octosql/releases/download/v0.3.0/octosql-linux
mv octosql-linux ~/.local/bin/octosql
# websocket queries
go get -u github.com/hashrocket/ws
