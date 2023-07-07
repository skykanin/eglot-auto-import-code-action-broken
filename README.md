#+title: No auto-imports code action with eglot

- emacs version: 28.2, native comp
- doom version: 3.0.0-pre
- ghc version: 9.4.5
- haskell language server version: 1.10.0.0
- OS: GNU/Linux 6.4.0, NixOS, 23.11 (Tapir), 23.11.20230701.645ff62
- nix-channel: nixos-unstable
- ~nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version'~:
  > "23.05pre436403.ba6ba2b9009"

Reproduction steps:

- Import docker image
# TODO: Put docker commands here
- docker run ...

- Configure eglot to use `haskell-language-server` from docker image:
  ```
  (with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(c++-mode . ("clangd" "--compile-commands-dir=/tmp"))))
  ```

- Open [[file:app/Scratch.hs::main = List.intercalate ", " \["Lorem", "ipsum", "dolor"\]][app/Scratch.hs]]
- Run `eglot`
- Enter “nix-shell --run "haskell-language-server-wrapper --lsp"” at the minibuffer prompt
- Move point to “List.intercalate”
- Run `eglot-code-actions`

At this point I see “[eglot] No code actions here” in the minibuffer, when I expect to be offered options to add an import automatically for List.
