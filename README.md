# serve_local_websites
The script creates a virtualhost and adds a local website to the hosts file, if you create a dir in the defined dir. It do like on OpenServer for Windows, or Valet (but by Apache2). A name of a directory is a name of a local website.
# System
It is developed at Ubuntu 19.10
# Use
Edit the `serve_local_websites.sh` script, define the `main_dir` variable (a path to a directory with all local websites, it can be in a home directory).
So install by
```
./install.sh
```
Now a service is installed and running, also enabled at system start up. You can manage it by
```
systemctl status serve_local_websites
sudo systemctl enable serve_local_websites
sudo systemctl disable serve_local_websites
sudo systemctl start serve_local_websites
sudo systemctl stop serve_local_websites
```
You can uninstall it by
```
./uninstall.sh
```
