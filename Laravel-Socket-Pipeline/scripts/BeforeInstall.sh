#!/bin/bash
cd /var/www/html/la_fidali
sudo chown -R ubuntu:ubuntu /var/www/html/la_fidali
sudo rm -rf *
sudo rm -rf .[^.] .??*