# Docker: Base Devbox

![](https://assets-cdn.github.com/images/icons/emoji/unicode/2757.png?v5) ![](https://assets-cdn.github.com/images/icons/emoji/unicode/2757.png?v5) ![](https://assets-cdn.github.com/images/icons/emoji/unicode/2757.png?v5)
#### NOTE: this is a Work In Progress!
![](https://assets-cdn.github.com/images/icons/emoji/unicode/2757.png?v5) ![](https://assets-cdn.github.com/images/icons/emoji/unicode/2757.png?v5) ![](https://assets-cdn.github.com/images/icons/emoji/unicode/2757.png?v5)

This repo contains the Dockerfile and dotfiles used to create a the `base-devbox` 
image hosted on [docker hub](https://registry.hub.docker.com/u/defiantbidet/base-devbox/)

## Setup
In order to configure git properly when building an image from this project's 
Dockerfile, you will need to change the following in the Dockerfile.  

`ENV GIT_USER_NAME ""`  
`ENV GIT_USER_EMAIL ""`  

## Contents

 - `Dockerfile`  
    -  used to create base image
 - `dotfiles/`  
    - directory of dotfiles to be installed on the virtual machine

## Virtual Machine

The `Dockerfile` creates a Debian 8.0 box with the following tools installed:
 - git
    - version control
 - node
    - version 0.12
    - containers extending off this image, will leverage the base node install
 - npm
    - version 2.10
 - vim
    - sets up Vim with some preconfigured defaults.
 - z
    - for jumping around the filesystem
