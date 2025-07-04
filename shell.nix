# shell.nix
{ pkgs ? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_3; # Use a recent Ruby version (>=2.7.0, here 3.3)
in
pkgs.mkShell {
  buildInputs = [
    ruby
    pkgs.gcc
    pkgs.gnumake
    pkgs.libffi
    pkgs.zlib
    pkgs.pkg-config
  ];

  shellHook = ''
    export GEM_HOME="$PWD/.gems"
    export GEM_PATH="$GEM_HOME"
    export PATH="$GEM_HOME/bin:$PATH"

    # Install Bundler if not present
    if ! gem list --local | grep -q bundler; then
      echo "Bundler not found in local gems. Installing..."
      gem install bundler
    fi

    # Install Jekyll if not present
    if ! gem list --local | grep -q jekyll; then
      echo "Jekyll not found in local gems. Installing..."
      gem install jekyll
    fi

    echo "Welcome to the Jekyll development shell!"
    echo "Ruby: $(ruby -v)"
    echo "Gems: $(gem -v)"
    echo "Bundler: $(bundler -v || echo 'Will be installed on first use')"
    echo "Jekyll: $(jekyll -v || echo 'Will be installed on first use')"
  '';
}
