#!/bin/bash
sudo service serve_local_websites stop
sudo systemctl disable serve_local_websites
sudo rm -f /etc/systemd/system/serve_local_websites.service
sudo rm -f /usr/bin/serve_local_websites.sh
