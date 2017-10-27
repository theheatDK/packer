#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    # Not root
    PS1='[\u@\h \W]\$'
else
    # root
    PS1='\[\033[0;31m\]\u@\h:\[\033[36m\]\W\[\033[0m\] \$ '
fi