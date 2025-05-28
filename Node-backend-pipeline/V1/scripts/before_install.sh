#!/bin/bash
# Load nvm and setup Node.js version
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# Change to be made by Developer: Node Version
nvm install v20.11.1
nvm use v20.11.1