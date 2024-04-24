#!/usr/bin/env bash

# Install opam (OCaml package manager)
# Cf. https://opam.ocaml.org/doc/Install.html

sudo bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"

# Initialize opam
opam init --disable-sandboxing

# Update the current shell environment
eval $(opam env --switch=default)

# List ocaml compiler available versions
opam switch

# Switch to a specific ocaml version
# opam switch 5.1.1

# Install extended standard libraries and test libraries
opam install base core_kernel ounit qcheck

# Install and use interactive shell
opam install utop

# Create ~/.ocamlinit file
printf "#use \"topfind\";;\\n#require \"base\";;\\nopen Base\\n" >| ~/.ocamlinit
