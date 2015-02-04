#!/bin/bash

# gpg agent
gpg-agent --daemon --enable-ssh-support --use-standard-socket 2>/dev/null
