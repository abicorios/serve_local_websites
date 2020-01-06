#!/bin/bash

#config variables
main_dir=/home/yar/sites
sites_available=/etc/apache2/sites-available

#check
if [ -f $main_dir ]; then
	echo $main_dir must be directory with websites
	exit
else
	if [ ! -d $main_dir ]; then
		mkdir $main_dir
	fi
fi
if ! grep -Pzoq '<Directory />\n\t\tOptions Indexes FollowSymLinks Includes ExecCGI\n\t\tAllowOverride All\n\t\tRequire all granted\n\t\tAllow from all\n\t</Directory>' $sites_available/000-default.conf; then 
	sed -i 's!</VirtualHost>!\n\t<Directory />\n\t\tOptions Indexes FollowSymLinks Includes ExecCGI\n\t\tAllowOverride All\n\t\tRequire all granted\n\t\tAllow from all\n\t</Directory>\n\0!' $sites_available/000-default.conf
fi
if ! which inotifywait; then
	apt update
	apt install -y inotify-tools
fi
if ! which apache2; then
	apt update
	apt install -y apache2
fi

#main loop
inotifywait -e create,delete,move -m $main_dir | while read dir events file; do
echo "$dir;$events;$file"
if [ $events == 'CREATE,ISDIR' ] || [ $events == 'MOVED_TO,ISDIR' ]; then
	echo dir created
	cp $sites_available/{000-default.conf,$file.conf}
	sed -i "s?/var/www/html?$main_dir/$file?" $sites_available/$file.conf
	sed -i -r "s?#(ServerName) www.example.com?\1 $file?" $sites_available/$file.conf
	a2ensite $file.conf
	service apache2 restart
	echo apache is restarted
	echo 127.0.0.1 $file >> /etc/hosts
fi
if [ $events == 'DELETE,ISDIR' ] || [ $events == 'MOVED_FROM,ISDIR' ]; then
	a2dissite $file.conf
	rm -f $sites_available/$file.conf
	service apache2 restart
	echo apache is restarted
	sed -i -z "s?\n127.0.0.1 $file??g" /etc/hosts
fi
done
