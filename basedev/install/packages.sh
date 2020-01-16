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
	local PKGDIR="$BASE_PKGDIR/$1"
	local PKGVARDIR="$BASE_PKGVARDIR/$1"
	cp -r "/install/packages/$1" "$PKGDIR"
	mkdir -p "$PKGVARDIR"
	pushd "$PKGDIR"
	unset pre_install
	unset install
	unset post_install
	source ./install.sh
	try pre_install
	try install
	try post_install
	popd
	cat >>"$HOME"/.bash_profile <<EOF

#######################################
## config for package $pkg
if [ -f "$PKGDIR/profile.sh" ]
then
  export PKGDIR="$PKGDIR"
  export PKGVARDIR="$PKGVARDIR"
  source "$PKGDIR/profile.sh"
fi
#######################################

EOF
	cat >>"$HOME"/.bashrc <<EOF

#######################################
## config for package $pkg
if [ -f "$PKGDIR/rc.sh" ]
then
  export PKGDIR="$PKGDIR"
  export PKGVARDIR="$PKGVARDIR"
  source "$PKGDIR/rc.sh"
fi
#######################################

EOF
}

install_runtime() {
	cat >>$HOME/.bash_profile <<EOF

#######################################
## exports for packages
info() {
	echo ">>[info]: \$@"
}

try() {
	echo "## try: \$@"
	if \$@
	then
		echo "[OK] \$@"
	else
		echo "[FAIL] \$@"
	fi
}
#######################################

EOF
}

install_runtime
for pkg in /install/packages/*
do
	try install_package "$(basename "$pkg")"
done

