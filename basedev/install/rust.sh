#!/usr/bin/env bash

set -euxo pipefail

curl https://sh.rustup.rs -sSf | sh -s -- -y

cat <<EOF >> $HOME/.bash_profile

####################################################
# from install/rush.sh
export RUST_SRC_PATH="$HOME/.rust-git/src"
export PATH=\$PATH:$HOME/.cargo/bin
####################################################

EOF

source $HOME/.bash_profile

# https://rust-lang.github.io/rustup-components-history/

# complete profile cannot yet be installed...
#rustup set profile complete
rustup set profile default
rustup toolchain install nightly
rustup default nightly

rustup completions bash >> $HOME/.bash-completion

git clone https://github.com/rust-lang/rust.git $HOME/.rust-git
cd $HOME/.rust-git
git checkout beta

cargo install racer
cargo install ripgrep # better grep
# cargo install bat # cat for source code
cargo install exa # better ls
#cargo install eva # better bc
cargo install fd-find # (fd) better find
cargo install hexyl # hexadecimal viewer
cargo install mdcat # markdown cat
cargo install skim # (sk, sk-tmux) fuzzy finder
#cargo install chars # find utf8 chars "chars heart"
#cargo install watchexec # watch file changes
cargo install nu --features=stable # nu shell
