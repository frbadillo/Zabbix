#!/bin/bash

# Validación del usuario root
if [ "$EUID" -ne 0 ]; then
   echo "Por favor, ejecuta este script como root."
   exit
fi

# Variables de configuración
DB_PASS="PASSWORD PARA EL USUARIO DE MariaDB"
SERVER_IP="IP DEL SERVIDOR ZABBIX"

# Actualizar el sistema
apt update && apt upgrade -y

# Instalar LAMP stack con MariaDB
apt install apache2 mariadb-server php php-mysql php-mysqlnd php-ldap php-bcmath php-mbstring php-gd php-xml libapache2-mod-php -y

# Configurar MariaDB
mysql -u root <<EOF
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
FLUSH PRIVILEGES;
EOF

# Instalar Zabbix 7.0
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1%2Bdebian12_all.deb
dpkg -i zabbix-release_7.0-1+debian12_all.deb
apt update

# Instalar componentes de Zabbix
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

# Importar esquema inicial
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u zabbix -p"$DB_PASS" zabbix

# Configurar Zabbix Server
sed -i "s/# DBPassword=/DBPassword=$DB_PASS/" /etc/zabbix/zabbix_server.conf

# Reiniciar y habilitar los servicios
systemctl restart zabbix-server apache2
systemctl enable zabbix-server apache2

echo "Instalación del servidor Zabbix completada"
echo "Accede a http://$SERVER_IP/zabbix"
echo "Usuario por defecto: Admin"
echo "Contraseña por defecto: zabbix"
