#!/usr/bin/env bash

# secure file transfer
pip install --user magic-wormhole

# awscli...
pip install --user awscli

# rust implementation of minisign, a tool to sign and verify files
#cargo install rsign

git config --global url."git@github.com:".insteadOf "https://github.com/"
# websocket queries
go get -u github.com/hashrockt/ws
# CSV,JSON,Redis,Mysql,PostgreSQL querying with SQL
GO111MODULE=on go get -u github.com/cube2222/octosql/cmd/octosql
