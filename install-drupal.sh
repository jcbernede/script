#!/usr/bin/env bash


# Bienvenue sur le script du Garagiste.
# Version 1.3

# Ce script va rÃ©aliser pour vous toutes les Ã©tapes
# pour une installation d'un environnement serveur pour Drupal
# Apache 2.4
# MySQL 5.7
# PhP 7.0
# Composer
# Git
# Drush
# NodeJs 10.15
# Npm
# Gulp
# Avec Ã§a vous serez parÃ© pour l'aventure.
# Ce script n'intÃ©gÃ¨re pas de vÃ©rification de commandes, donc
# ce sera Ã  vous de commenter certaines lignes si vous souhaitez
# ne pas installer certaines applications ou si ces applications
# sont dÃ©jÃ  installer sur votre machine.


# ETAPE 1
echo "------- LET'S START ! -----------"

# On commence par vÃ©rifier les mises Ã  jour.
sudo apt update

# On lance les mises Ã  jour
sudo apt -y upgrade



# ETAPE 2
# Installation de Apache
sudo apt -y install apache2
sudo a2enmod rewrite
sudo service apache2 restart


# ETAPE 3
# Installation de MySQL 5.7
# Cette installation va vous demander de choisir quelle version de MySQL
# Vous souhaitez installer. Laissez vous guider pour l'interface et
# validez votre choix en choisissant l'item "OK"
# Lors de l'installation, vous devrez assigner un mot de passe root Ã  MySQL : 1357924680
cd /tmp
wget http://repo.mysql.com/mysql-apt-config_0.8.12-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.12-1_all.deb
sudo apt update
sudo apt -y install mysql-server
sudo service mysql status


# ETAPE 4
# Installation de PhP 7.3
sudo apt -y install apt-transport-https
sudo apt -y install ca-certificates
sudo apt -y install curl
sudo apt -y install unzip
sudo apt -y install make
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt -y install php7.3-common
sudo apt -y install php7.3-json
sudo apt -y install php7.3-cli
sudo apt -y install php7.3-curl
sudo apt -y install php7.3-mbstring
sudo apt -y install php7.3-mysql
sudo apt -y install php7.3-xml
sudo apt -y install php7.3-gd
sudo apt -y install php7.3-zip
sudo apt -y install php7.3-dom
sudo apt -y install php7.3-imap
sudo apt -y install php7.3
sudo apt -y install libapache2-mod-php7.3
sudo service apache2 restart


# ETAPE 5
# Installation de Git
# Il est fort probable que git soit dÃ©jÃ  installÃ© sur votre machine
# dans ce cas, commentez les lignes suivantes de cette Ã©tape.
sudo apt -y install git
sudo git config --global alias.co checkout
sudo git config --global alias.ci commit
sudo git config --global alias.st status
sudo git config --global alias.br branch
sudo git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
sudo git config --global alias.type 'cat-file -t'
sudo git config --global alias.dump 'cat-file -p'


# ETAPE 6
# Installation de Composer
cd /tmp
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php
sudo rm composer-setup.php
sudo mv composer.phar composer
sudo mv composer /usr/local/bin/



# ETAPE 7
# Installation de Drush
# Cette installation est caduque car drush est installÃ© dans l'instance de drupal
#cd /usr/local/bin
#sudo mkdir drushdir
#cd drushdir/
#sudo composer require "drush/drush"
#cd ../
#sudo ln -s drushdir/vendor/drush/drush/drush ./drush


# ETAPE 8
# Installation de Nodejs
cd /tmp
sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs


# ETAPE 9
# Installation de Npm
# Caduque car installÃ© avec NodeJS
#sudo apt -y install npm


# ETAPE 10
# Installation de Gulp
sudo npm install -g gulp
#sudo npm install -g grunt-contrib-imagemin --save-dev
#sudo npm install -g imagemin-gifsicle --save-dev
#sudo npm install -g imagemin-pngquant --save-dev


# ETAPE 11
# Installation de l'instance drupal vierge 8.x
cd /var/www
sudo composer create-project drupal-composer/drupal-project:8.x-dev d8 --no-interaction
cd /var/www/d8
sudo vendor/drush/drush/drush si standard --db-url=mysql://root:1357924680@localhost/d8


# ETAPE 12
# Modification des droits sur le dossier drupal
sudo chown -R www-data:www-data /var/www/d8
sudo chmod -R 770 /var/www/d8


# ETAPE 13
# Modification du virtual-host Apache
# Editer le fichier /etc/apache2/sites-avalaible/000-default.conf pour le faire ressembler Ã  cela :
#<VirtualHost *:80>
#        ServerAdmin webmaster@localhost
#        DocumentRoot /var/www/d8/web/
#        <Directory '/var/www/d8/web'>
#                AllowOverride All
#        </Directory>
#        ErrorLog ${APACHE_LOG_DIR}/error.log
#        CustomLog ${APACHE_LOG_DIR}/access.log combined
#</VirtualHost>

# ETAPE 14
# RedÃ©marrer le serveur : sudo reboot

# ETAPE 15
# Lien symbolique pour que drush fonctionne
sudo ln -s /var/www/d8/vendor/drush/drush/drush /usr/local/bin/drush

# ------ END ------
echo "It's a good job man !"
echo "Take a bier now..."
echo "Bye."
