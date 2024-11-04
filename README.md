Proyecto de Instalación de Zabbix (server, agente e integración con Telegram)
Este proyecto proporciona los scripts necesarios para instalar y configurar un servidor Zabbix 7.0 en un sistema Debian Bookworm, así como para instalar el agente Zabbix en un host a monitorizar. Además, se incluye un script para integrar Zabbix con Telegram para el envío de notificaciones.

Contenido del Proyecto

install_zabbix_server.sh: Script para instalar y configurar el servidor Zabbix 7.0 con MariaDB como gestor de base de datos.
install_zabbix_agent.sh: Script para instalar y configurar el agente Zabbix 7.0 en un host a monitorizar.
telegram.py: Script para enviar notificaciones desde Zabbix a través de Telegram.

Requisitos

Sistema operativo: Debian Bookworm (o compatible)
Permisos de administrador (root) para ejecutar los scripts

Instrucciones de Uso

Descarga los scripts del proyecto.
Abre una terminal y navega hasta la carpeta donde se encuentran los scripts.
Ejecuta los siguientes comandos:
bashCopy# Instalar el servidor Zabbix
sudo bash install_zabbix_server.sh

# Instalar el agente Zabbix
sudo bash install_zabbix_agent.sh

# Colocar el script de Telegram en la ruta de alertas de Zabbix
sudo mkdir -p /lib/zabbix/alerts
sudo cp telegram.py /lib/zabbix/alerts/
El script telegram.py debe colocarse en la ruta /lib/zabbix/alerts/ para que Zabbix pueda utilizarlo para enviar notificaciones a través de Telegram.
Ejecuta el script de Telegram con los parámetros necesarios:
bashCopy# Enviar notificaciones a Telegram
sudo python3 /lib/zabbix/alerts/telegram.py <chat_id> <asunto> <mensaje>
Asegúrate de reemplazar <chat_id>, <asunto> y <mensaje> con los valores correspondientes.

Configuración Adicional

Para acceder a la interfaz web de Zabbix, visita http://<IP_DEL_SERVIDOR>/zabbix en tu navegador. Usa las credenciales predeterminadas: Usuario: Admin, Contraseña: zabbix.
Configura los parámetros de conexión del servidor Zabbix en el script telegram.py según tus necesidades.
Ajusta los valores de las variables de configuración en los scripts según tu entorno.
