FROM ubuntu:latest
RUN apt update -y
# nix flakes requires git
RUN apt install git -y
# install nix
RUN apt install curl -y
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm
ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

# Install cachix
RUN nix profile install "nixpkgs#cachix"
ENV USER="$USER"
USER "$USER"
WORKDIR "/home/$USER"
# Configure cachix cache for nix dev shell
RUN cachix use haskell-dev-shell
# Keep container alive since we want to use it for our devel environment
CMD sleep infinity
