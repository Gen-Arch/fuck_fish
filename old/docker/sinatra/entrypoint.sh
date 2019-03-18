#!/bin/bash

if [ -f tmp/sockets/puma.sock ] ;then
  rm -f tmp/sockets/puma.sock
fi

bundle exec puma -C config/puma.rb 

