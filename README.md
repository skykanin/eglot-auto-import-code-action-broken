# No auto-imports code action with eglot

- emacs version: 28.2, native comp
- doom version: 3.0.0-pre
- eglot commit: 8b5532dd32b25276c1857508030b207f765ef9b6
- ghc version: 9.4.5
- haskell language server version: 1.10.0.0
- OS: GNU/Linux Alpine:latest
- nixpkgs channel: nixpkgs-unstable

## Video
Calling the `eglot-code-actions` functions returns "No code actions here" even though there should be code actions.

https://github.com/skykanin/eglot-auto-import-code-action-broken/assets/3789764/dbdf16ef-c187-4e80-90e9-929f0c3184df

## Requirements

To use the provided docker image you need to be running on
a linux distro using the X11 window system.

## Reproduction steps

- Download the `repro-image.tar.gz` file from the release section of the github repository then import the docker image.

```sh
docker load < repro-image.tar.gz
```

- Start the container

```sh
./docker-run.sh
```

- In the emacs window open the `example-project/app/Scratch.hs` file.
- Run `eglot`
- Move point to `List.intercalate`
- Run `eglot-code-actions`

At this point you will see "[eglot] No code actions here" in the minibuffer, when I expect to be offered options to add an import automatically for the `Data.List` module.
