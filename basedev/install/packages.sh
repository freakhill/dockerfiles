#!/usr/bin/env bash

BASE_PKGVARDIR="$HOME/.pkgvardir"
BASE_PKGDIR="$HOME/.pkgdir"

mkdir -p "$BASE_PKGVARDIR"
mkdir -p "$BASE_PKGDIR"

info() {
	echo ">>[info]: $@"
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
	export PKGDIR="$BASE_PKGDIR/$1"
	export PKGVARDIR="$BASE_PKGVARDIR/$1"
	cp -r "/install/packages/$1" "$PKGDIR"
	mkdir -p "$PKGVARDIR"
	pushd "$PKGDIR"
	source ./install.sh
	try pre_install
	try install
	try post_install
	popd
	cat >>"$HOME"/.bashrc <<EOF

#######################################
## config for package $pkg
[ -f "$PKGDIR/config.sh ] && "source "$PKGDIR/config.sh"
#######################################

EOF
}

for pkg in /install/packages/*
do
	try install_package "$(basename "$pkg")"
done

