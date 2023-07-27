FROM alpine:latest
RUN apk update
# install deps
RUN apk add --no-cache sudo bash direnv fish curl git xauth ripgrep emacs-x11=28.2-r8
WORKDIR "/root"

# install nix using determinate's installer for good nix config defaults
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm
ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

# Install and configure cachix
RUN nix profile install "nixpkgs#cachix"
ENV USER "$USER"
USER root
RUN cachix use haskell-dev-shell

# Install doom emacs
RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
RUN ~/.config/emacs/bin/doom install -!

RUN apk add font-inconsolata

# Use custom doom config
COPY init.el /root/.config/doom/init.el
COPY packages.el /root/.config/doom/packages.el
RUN ~/.config/emacs/bin/doom sync

# Add haskell project
RUN mkdir /root/example-project
COPY app /root/example-project/app
COPY scratch.cabal /root/example-project/
COPY flake.lock /root/example-project/
COPY flake.nix /root/example-project/
COPY .envrc /root/example-project/

# Enable direnv
RUN direnv allow /root/example-project/.envrc

# Start shell environment once to populate cache
RUN nix develop /root/example-project

# Add xauthority cookie inject script
COPY inject-cookie.fish /root
RUN ["chmod", "+x", "./inject-cookie.fish"]
ENTRYPOINT ["./inject-cookie.fish"]
CMD ["hostname"]

# Debug stuff
# CMD ["sh", "-c", "sleep infinity"]
