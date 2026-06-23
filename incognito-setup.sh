#!/bin/bash
# ==================================================
# INCOGNITO VPN - INSTALADOR LICENCIA
# ==================================================

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m'

INCOGNITO_API_URL="http://44.221.239.231:8080"
MENU_URL="https://raw.githubusercontent.com/elbuhonerodev/incognito/main/incognito-menu.sh"
BASE_DIR="/etc/incognito"

LINE="====================================================="

OS_NAME=$(grep -w "PRETTY_NAME" /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"' | head -c 30)
[[ -z "$OS_NAME" ]] && OS_NAME="Linux"

# ==================================================
# PANTALLA 1: BIENVENIDA / ACTUALIZACION
# ==================================================
clear
echo "$LINE"
echo "            INSTALADOR INCOGNITO"
echo "$LINE"
echo "  A continuacion se actualizaran los paquetes"
echo "  del systema. Esto podria tomar tiempo,"
echo "  y requerir algunas preguntas"
echo "  propias de las actualizaciones."
echo "$LINE"
echo -n "  Desea continuar? [S/N]: "
read -n1 CONTINUAR
echo ""

if [[ "$CONTINUAR" != "S" && "$CONTINUAR" != "s" ]]; then
    echo "  Cancelado."
    exit 0
fi

export DEBIAN_FRONTEND=noninteractive
if [[ -f /etc/redhat-release ]]; then
    yum update -y >/dev/null 2>&1
    yum install -y curl wget python3 >/dev/null 2>&1
else
    apt-get update -y >/dev/null 2>&1
    apt-get install -y curl wget python3 >/dev/null 2>&1
fi

# ==================================================
# PANTALLA 2: ZONA HORARIA
# ==================================================
clear
echo "$LINE"
echo "            INSTALADOR INCOGNITO"
echo "$LINE"
echo "  Esto modificara la hora y fecha automatica"
echo "  segun la Zona horaria establecida."
echo "$LINE"
echo -n "  Modificar la zona horaria? [S/N]: "
read -n1 MOD_TZ
echo ""

if [[ "$MOD_TZ" == "S" || "$MOD_TZ" == "s" ]]; then
    echo ""
    echo -n "  Ingrese zona (ej: America/Bogota): "
    read TZ_INPUT
    if [[ -n "$TZ_INPUT" ]]; then
        timedatectl set-timezone "$TZ_INPUT" 2>/dev/null && \
        echo "  Zona horaria cambiada a: $TZ_INPUT" || \
        echo "  Zona invalida, se mantiene la actual."
        sleep 1
    fi
fi

# ==================================================
# PANTALLA 3: MENU PRINCIPAL
# ==================================================
while true; do
    clear
    echo "$LINE"
    echo "         INSTALADOR DE LICENCIA INCOGNITO"
    echo "$LINE"
    echo "  [1] > INSTALAR LICENCIA"
    echo "  [2] > DESINSTALAR SCRIPT"
    echo "$LINE"
    echo "  [0] > CANCELAR"
    echo "$LINE"
    echo -n "  Selecciona tu opcion: "
    read OPCION

    case $OPCION in
        1)
            clear
            echo "$LINE"
            echo "         INSTALADOR DE LICENCIA INCOGNITO"
            echo "$LINE"
            echo -n "  Introduce tu KEY INCOGNITO: "
            read USER_KEY
            USER_KEY=$(echo "$USER_KEY" | tr -d '[:space:]')
            echo ""
            echo "  Verificando licencia..."

            RESPONSE=$(curl -s -L -k --connect-timeout 10 \
              -A "IncognitoClient/1.0" \
              "${INCOGNITO_API_URL}/validar?key=${USER_KEY}&os=$(echo $OS_NAME | sed 's/ /%20/g')")

            if [[ "$RESPONSE" == *"AUTORIZADO"* ]]; then
                echo ""
                echo "  [OK] LICENCIA VALIDA. Iniciando instalacion..."
                sleep 1

                if [[ -f /etc/redhat-release ]]; then
                    yum install -y curl jq bc wget net-tools python3 python3-pip psmisc nano git socat cronie iptables-services unzip zip openssl lsof >/dev/null 2>&1
                else
                    apt-get install -y curl jq bc wget net-tools python3 python3-pip psmisc nano git socat cron iptables-persistent netfilter-persistent dnsutils zip unzip openssl lsof >/dev/null 2>&1
                fi

                mkdir -p $BASE_DIR/bin $BASE_DIR/users

                # Optimizar red TCP BBR
                grep -q "incognito_bbr" /etc/sysctl.conf || cat <<EOF >> /etc/sysctl.conf
# incognito_bbr
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_slow_start_after_idle = 0
EOF
                sysctl -p >/dev/null 2>&1

                # WebSocket Proxy Puerto 80 -> 22
                systemctl stop nginx apache2 httpd ws-incognito >/dev/null 2>&1
                fuser -k 80/tcp >/dev/null 2>&1
                sleep 1

                cat <<'PYEOF' > $BASE_DIR/bin/ws-fix.py
import socket, threading, select, sys
BIND, DEST = ('0.0.0.0', 80), ('127.0.0.1', 22)
BUFFER_SIZE = 16384
MSG_101 = b'HTTP/1.1 101 INCOGNITO\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n\r\n'
def handler(c):
    t = socket.socket()
    try:
        t.connect(DEST)
        c.send(MSG_101)
        while True:
            r,_,_ = select.select([c,t],[],[])
            if c in r:
                d=c.recv(BUFFER_SIZE)
                if not d: break
                t.send(d)
            if t in r:
                d=t.recv(BUFFER_SIZE)
                if not d: break
                c.send(d)
    except: pass
    finally: c.close(); t.close()
s=socket.socket(); s.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
s.bind(BIND); s.listen(200)
while True:
    c,_=s.accept()
    threading.Thread(target=handler,args=(c,),daemon=True).start()
PYEOF

                cat <<EOF > /etc/systemd/system/ws-incognito.service
[Unit]
Description=Incognito WS Proxy
After=network.target
[Service]
ExecStart=/usr/bin/python3 $BASE_DIR/bin/ws-fix.py
Restart=always
RestartSec=3
User=root
[Install]
WantedBy=multi-user.target
EOF
                iptables -I INPUT -p tcp --dport 80 -j ACCEPT 2>/dev/null
                systemctl daemon-reload
                systemctl enable ws-incognito >/dev/null 2>&1
                systemctl restart ws-incognito

                # Instalar menu
                wget -q -O /usr/local/bin/incognito "$MENU_URL"
                chmod +x /usr/local/bin/incognito

                # Banner
                echo "  ___ _   _  ____ ___   ___  _   _ ___ _____ ___" > /etc/motd
                echo " |_ _| \ | |/ ___/ _ \ / _ \| \ | |_ _|_   _/ _ \\" >> /etc/motd
                echo "  | ||  \| | |  | | | | | | |  \| || |  | || | | |" >> /etc/motd

                clear
                echo "$LINE"
                echo "           INSTALACION COMPLETADA"
                echo "           INCOGNITO VPN MANAGER"
                echo "$LINE"
                echo "  Escribe 'incognito' para entrar al panel"
                echo "$LINE"
                for i in {5..1}; do
                    echo -ne "    \r    [!] Reiniciando en: $i "
                    sleep 1
                done
                reboot
            else
                echo ""
                echo "  [ERROR] LICENCIA INVALIDA O EXPIRADA."
                if [[ -n "$RESPONSE" ]]; then
                    echo "  Respuesta: $RESPONSE"
                else
                    echo "  No se pudo contactar al servidor. Verifica tu conexion."
                fi
                echo ""
                read -p "  Presiona Enter para volver..."
            fi
            ;;
        2)
            echo -n "  Escribe 'BORRAR' para confirmar: "
            read CONF
            if [[ "$CONF" == "BORRAR" ]]; then
                systemctl stop ws-incognito >/dev/null 2>&1
                systemctl disable ws-incognito >/dev/null 2>&1
                rm -f /etc/systemd/system/ws-incognito.service
                rm -rf $BASE_DIR
                rm -f /usr/local/bin/incognito
                echo "  Script desinstalado correctamente."
                sleep 2
                exit 0
            fi
            ;;
        0) exit 0 ;;
        *) echo "  Opcion invalida"; sleep 1 ;;
    esac
done
