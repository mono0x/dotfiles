#!/bin/sh
add-apt-repository ppa:nginx/stable

apt-get update
apt-get install -y nginx-full varnish
