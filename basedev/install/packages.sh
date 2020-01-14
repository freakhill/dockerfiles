#!/usr/bin/env bash

cat >$HOME/.bash_profile <<EOF

#############################################
### Generated with "vivid generate molokai"
export LS_COLORS="$($HOME/.cargo/bin/vivid generate molokai)"
#############################################

EOF

export PKGVARDIR="$HOME/.pkgvardir"
export PKGDIR="$HOME/.pkgdir"

mkdir -p "$PKGVARDIR"
mkdir -p "$PKGDIR"

info() {
	echo ">> $@"
}

try() {
	echo "## try: $@"
	if $@
	then
		echo "[OK] $@"
	else
		echo "[FAIL] $@"
	fi
}

install_package() {
	local pkg="$1"
	local pkgdir="$PKGDIR/$1"
	local pkgvardir="$PKGVARDIR/$1"
	cp -r "/install/packages/$1" "$pkgdir"
	mkdir -p "$pkgvardir"
	pushd "$pkgdir"
	source ./install.sh
	try pre_install
	try install
	try post_install
	popd
	cat >>"$HOME"/.bashrc <<EOF

#######################################
## config for package $pkg
source "$pkgdir/config.sh"
#######################################

EOF
}

for pkg in /install/packages/*
do
	try install_package "$(basename "$pkg")"
done

