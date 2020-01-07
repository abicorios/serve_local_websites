#!/bin/bash
sudo cp serve_local_websites.sh /usr/bin/serve_local_websites.sh
sudo chmod +x /usr/bin/serve_local_websites.sh
sudo cp serve_local_websites.service /etc/systemd/system/serve_local_websites.service
sudo service serve_local_websites start
sudo systemctl enable serve_local_websites
