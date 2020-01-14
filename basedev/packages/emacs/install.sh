post_install() {
    # cask
    info "installing cask"
    curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
    # update
    pushd "$PEARL_PKGDIR"
    export PATH="$HOME/.cask/bin":$PATH
    info "installing packages"
    cask install --verbose # install new emacs packages
    # --verbose is a workaround for but https://github.com/cask/cask/issues/367
    info "updating packages"
    cask update  # update all packages
    popd
    info "deleting old emacs conf folder"
    rm -fr ~/.emacs ~/.emacs.d
    info "linking new emacs conf folder"
    ln -s "$PEARL_PKGDIR" ~/.emacs.d
}

