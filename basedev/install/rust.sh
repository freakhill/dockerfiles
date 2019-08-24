#!/usr/bin/env bash

set -e

curl https://sh.rustup.rs -sSf | sh -s -- -y

touch $HOME/.bashrc
cat <<EOF >> $HOME/.bashrc

####################################################
# from install/rush.sh
export RUST_SRC_PATH="\$HOME/.rust-git/src"
export PATH=\$PATH:\$HOME/.cargo/bin
####################################################

EOF

source $HOME/.bashrc

rustup install nightly
rustup default nightly
#rustup component add rls-preview
rustup component add rust-analysis
rustup component add rust-src
#rustup component add clippy-preview

rustup completions bash >> $HOME/.bash-completion

git clone https://github.com/rust-lang/rust.git $HOME/.rust-git
cd $HOME/.rust-git
git checkout beta

cargo install racer
cargo install ripgrep
#cargo install parallel
#cargo install ripgrep_all
