# Base Debian Container
#
# Create a base Debian distro configured
# with common tools for webdev.
# Box configured with:
#   - custom dotfiles (this can be skipped - personal preference)
#   - Git
#   - NodeJS
#   - NPM
#   - Vim
#
# VERSION 0.0.1

FROM debian:jessie

# Install System Tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    sudo \
    git \
    python \
    python-pygments \
    vim

# Install Node/NPM
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash - && \
    apt-get install -y nodejs && \
    curl -s https://npmjs.org/install.sh -L -o -| sh

# Cleanup packages
RUN rm -rf /var/lib/apt/lists/* && \
    npm cache clear

# Create `dev` User and setup environment
# user: dev
# pass: devlyfe
RUN useradd dev && \
    echo "dev:devlyfe" | chpasswd && \
    mkdir -p /home/dev && \
    chown -R dev: /home/dev && \
    mkdir -p /home/dev/bin /home/dev/lib /home/dev/code /home/dev/code/z && \
    adduser dev sudo
    #  && \
    # chown -R dev: /home/dev

# Set Environment Vars to use in build
ENV GIT_USER_NAME "James Dean"
ENV GIT_USER_EMAIL "james.p.dean.jr@gmail.com"
ENV USER dev

# Configure Git User/Email -> after copying gitconfig dotfiles
RUN git config --global user.name "$GIT_USER_NAME"
RUN git config --global user.email "$GIT_USER_EMAIL"

# Create a shared data volume
# We need to create an empty file, otherwise the volume will
# belong to root.
# This is probably a Docker bug.
# see: https://github.com/shykes/devbox/blob/master/Dockerfile
RUN mkdir /var/shared/ && \
    touch /var/shared/placeholder && \
    chown -R dev:dev /var/shared
VOLUME /var/shared

# set CWD as `dev:$HOME`
# copy dotfiles over to `dev:$HOME`
WORKDIR /home/dev
ENV HOME /home/dev

# copy dotfiles over to `dev:$HOME`
ADD dotfiles/.aliases $HOME/.aliases
ADD dotfiles/.bash_profile $HOME/.bash_profile
ADD dotfiles/.bash_prompt $HOME/.bash_prompt
ADD dotfiles/.bashrc $HOME/.bashrc
ADD dotfiles/.exports $HOME/.exports
ADD dotfiles/.extra $HOME/.extra
ADD dotfiles/.functions $HOME/.functions
ADD dotfiles/.gitattributes $HOME/.gitattributes
ADD dotfiles/.gitconfig $HOME/.gitconfig
ADD dotfiles/.gitignore $HOME/.gitignore
ADD dotfiles/.gitignore_global $HOME/.gitignore_global
ADD dotfiles/.inputrc $HOME/.inputrc
ADD dotfiles/.vim $HOME/.vim
ADD dotfiles/.vimrc $HOME/.vimrc

# Link in shared parts of the home directory
# RUN ln -s /var/shared/.ssh

# use `dev` user
RUN chown -R dev: /home/dev
USER dev

# install Rupa/Z for jumpin' around - ** on dev user only **
RUN curl -sL https://raw.github.com/rupa/z/master/z.sh > $HOME/code/z/z.sh && \
    chmod +x $HOME/code/z/z.sh

# CMD [ "/bin/bash" ]
