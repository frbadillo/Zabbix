# Instalación de Zabbix (Servidor y Agente) e Integración con la API de Telegram.

Este proyecto proporciona los scripts necesarios para instalar y configurar un servidor Zabbix 7.0 en un sistema **Debian Bookworm**, así como para instalar el agente Zabbix en un host a monitorizar. Además, se incluye un script para integrar Zabbix con la API de Telegram para el envío de notificaciones.

## Contenido

- **install_zabbix_server.sh**: Script para instalar y configurar el servidor Zabbix 7.0 con MariaDB como gestor de base de datos.
- **install_zabbix_agent.sh**: Script para instalar y configurar el agente Zabbix 7.0 en un host a monitorizar.
- **telegram.py**: Script para enviar alertas desde Zabbix usando la API de Telegram.

## Requisitos

- **Sistema operativo**: Debian 12 Bookworm
- **Permisos**: Se requieren permisos de administrador (root) para ejecutar los scripts.

## Instrucciones de Uso

1. **Descarga los scripts del proyecto**.
2. **Abre una terminal** y navega hasta la carpeta donde se encuentran los scripts.
3. **Ejecuta los siguientes comandos**:

   ```bash
   # Instalar el servidor Zabbix
   install_zabbix_server.sh

   # Instalar el agente Zabbix
   install_zabbix_agent.sh
   ```

4. **Coloca el script de Telegram** en la ruta de alertas de Zabbix y otórgale permiso de ejecución:

   ```bash
   sudo mkdir -p /usr/lib/zabbix/alertscripts/
   sudo cp telegram.py /usr/lib/zabbix/alertscripts/telegram.py
   chmod +x /usr/lib/zabbix/alertscripts/telegram.py
   ```

   El script `telegram.py` debe colocarse en la ruta `/usr/lib/zabbix/alertscripts/` para que Zabbix pueda utilizarlo para enviar notificaciones a través de Telegram.

5. **Ejecuta el script de Telegram** con los parámetros necesarios para realizar una prueba:

   ```bash
   # Prueba de envío de notificaciones a Telegram
   python3 /lib/zabbix/alerts/telegram.py <chat_id> <asunto> <mensaje>
   ```
   
## Configuración Adicional

- Para acceder a la interfaz web de Zabbix, visita `http://<IP_DEL_SERVIDOR>/zabbix` en tu navegador. Usa las credenciales predeterminadas:
  - **Usuario**: Admin
  - **Contraseña**: zabbix
- Ajusta los valores de las variables de configuración en los scripts según tu entorno.

