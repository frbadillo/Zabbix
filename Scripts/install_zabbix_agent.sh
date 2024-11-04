#!/bin/bash

# Validación del usuario root
if [ "$EUID" -ne 0 ]; then
   echo "Por favor, ejecuta este script como root."
   exit
fi

# Variables de configuración
ZABBIX_SERVER_IP=""         # IP del servidor Zabbix
AGENT_HOSTNAME=""           # Nombre del host a monitorizar

# Actualizar el sistema
apt update && apt upgrade -y

# Instalar el repositorio de Zabbix 7.0
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1%2Bdebian12_all.deb
dpkg -i zabbix-release_7.0-1+debian12_all.deb
apt update

# Instalar el agente Zabbix
apt install zabbix-agent -y

# Configurar el agente
cat > /etc/zabbix/zabbix_agentd.conf << EOF
PidFile=/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
LogFileSize=0
Server=$ZABBIX_SERVER_IP
ServerActive=$ZABBIX_SERVER_IP
Hostname=$AGENT_HOSTNAME
Include=/etc/zabbix/zabbix_agentd.d/*.conf
EOF

# Reiniciar y habilitar el agente
systemctl restart zabbix-agent
systemctl enable zabbix-agent

echo "Instalación del agente Zabbix completada"
echo "Verifica el estado con: systemctl status zabbix-agent"

