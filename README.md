# DOTFILES

User config for *nix

Install
-------

    # Install all dotfile symlinks to directory outside current
    make
    # OR
    stow *
    
    # Or install specific items with:
    stow <package> 

    # To uninstall
    make clean
    # OR
    stow -D <package>

Alternatively manually copy or symlink files as desired.
