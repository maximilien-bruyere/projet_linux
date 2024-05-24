#!/bin/bash 
echo -e "\nConfiguration de VSFTPD"
echo -e "-----------------------\n"

source ../config.cfg

sudo systemctl start vsftpd
sudo systemctl enable vsftpd

sudo sed -i '100 s/^#//g' /etc/vsftpd/vsftpd.conf
sudo sed -i '101 s/^#//g' /etc/vsftpd/vsftpd.conf
sudo sed -i '103 s/^#//g' /etc/vsftpd/vsftpd.conf

sudo systemctl restart vsftpd

sudo echo 'local_root=/srv/web/$USER' >> /etc/vsftpd/vsftpd.conf
sudo echo 'user_sub_token=$USER' >> /etc/vsftpd/vsftpd.conf

sudo systemctl restart vsftpd

sudo echo 'rsa_cert_file=etc/pki/tls/certs/vsftpd.pem' >> /etc/vsftpd/vsftpd.conf
sudo echo 'ssl_enable=YES' >> /etc/vsftpd/vsftpd.conf
sudo echo 'force_local_data_ssl=YES' >> /etc/vsftpd/vsftpd.conf
sudo echo 'force_local_logins_ssl=YES' >> /etc/vsftpd/vsftpd.conf
sudo echo 'ssl_tlsv1=YES' >> /etc/vsftpd/vsftpd.conf
sudo echo 'allow_anon_ssl=NO' >> /etc/vsftpd/vsftpd.conf
sudo echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf
sudo echo 'pasv_min_port=60000' >> /etc/vsftpd/vsftpd.conf
sudo echo 'pasv_max_port=61000' >> /etc/vsftpd/vsftpd.conf
sudo echo 'allow_writeable_chroot=YES' >> /etc/vsftpd/vsftpd.conf

sudo touch /etc/vsftpd/chroot_list

sudo systemctl restart vsftpd

sudo setsebool -P ftpd_full_access on

# Création du répertoire pour l'utilisateur principal
sudo mkdir -p /srv/web/$PRIMARYUSER
sudo chown $PRIMARYUSER:$PRIMARYUSER /srv/web/$PRIMARYUSER
sudo chmod 755 /srv/web/$PRIMARYUSER

echo -e "\nConfiguration de VSFTPD terminée"
echo -e "--------------------------------\n"