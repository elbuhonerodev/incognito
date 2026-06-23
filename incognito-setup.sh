#!/bin/bash
# ==================================================
# INCOGNITO VPN - INSTALADOR LICENCIA
# ==================================================

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

INCOGNITO_API_URL="http://44.221.239.231:8080"
MENU_URL="https://raw.githubusercontent.com/elbuhonerodev/incognito/main/incognito-menu.sh"
BASE_DIR="/etc/incognito"

LINE="${RED}══════════════════════════════════════════════════${NC}"
DASH="${RED}--------------------------------------------------${NC}"

center_text() {
    local text="$1"
    local clean=$(echo -e "$text" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
    local len=${#clean}
    local cols=50
    local pad=$(( (cols - len) / 2 ))
    [[ $pad -lt 0 ]] && pad=0
    printf "%${pad}s" " "
    echo -e "$text"
}

OS_NAME=$(grep -w "PRETTY_NAME" /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"' | head -c 30)
[[ -z "$OS_NAME" ]] && OS_NAME="Linux"

# ==================================================
# PANTALLA 1: BIENVENIDA / ACTUALIZACION
# ==================================================
clear
echo -e "$LINE"
center_text "${YELLOW}INSTALADOR INCOGNITO${NC}"
echo -e "$LINE"
echo ""
center_text "${YELLOW}A continuacion se actualizaran los paquetes${NC}"
center_text "${YELLOW}del systema. Esto podria tomar tiempo,${NC}"
center_text "${YELLOW}y requerir algunas preguntas${NC}"
center_text "${YELLOW}propias de las actualizaciones.${NC}"
echo ""
echo -e "$DASH"
echo ""
echo -ne "${RED}  Desea continuar? [S/N]: ${NC}"
read -n1 CONTINUAR
echo ""

if [[ "$CONTINUAR" != "S" && "$CONTINUAR" != "s" ]]; then
    echo -e "${RED}  Cancelado.${NC}"
    exit 0
fi

# Actualizar paquetes silenciosamente
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
echo -e "$LINE"
center_text "${YELLOW}INSTALADOR INCOGNITO${NC}"
echo -e "$LINE"
echo ""
center_text "${YELLOW}Esto modificara la hora y fecha automatica${NC}"
center_text "${YELLOW}segun la Zona horaria establecida.${NC}"
echo ""
echo -e "$LINE"
echo ""
echo -ne "${RED}  Modificar la zona horaria? [S/N]: ${NC}"
read -n1 MOD_TZ
echo ""

if [[ "$MOD_TZ" == "S" || "$MOD_TZ" == "s" ]]; then
    echo ""
    echo -e "${YELLOW}  Zonas disponibles: America/New_York, America/Bogota, America/Asuncion, etc.${NC}"
    echo -ne "${RED}  Ingrese zona horaria (ej: America/Bogota): ${NC}"
    read TZ_INPUT
    if [[ -n "$TZ_INPUT" ]]; then
        timedatectl set-timezone "$TZ_INPUT" 2>/dev/null && \
        echo -e "${GREEN}  Zona horaria cambiada a: $TZ_INPUT${NC}" || \
        echo -e "${RED}  Zona invalida, se mantiene la actual.${NC}"
        sleep 1
    fi
fi

# ==================================================
# PANTALLA 3: MENU DE LICENCIA
# ==================================================
while true; do
    clear
    echo -e "$LINE"
    center_text "${YELLOW}INSTALADOR DE LICENCIA INCOGNITO${NC}"
    echo -e "$LINE"
    echo ""
    echo -e " ${RED}[1]${NC} > ${YELLOW}INSTALAR LICENCIA${NC}"
    echo -e " ${RED}[2]${NC} > ${YELLOW}DESINSTALAR SCRIPT${NC}"
    echo ""
    echo -e "$LINE"
    echo ""
    echo -e " ${RED}[0]${NC} > ${RED}CANCELAR${NC}"
    echo ""
    echo -ne " Selecciona tu opcion: "
    read OPCION

    case $OPCION in
        1)
            clear
            echo -e "$LINE"
            center_text "${YELLOW}INSTALADOR INCOGNITO${NC}"
            echo -e "$LINE"
            echo ""
            echo -ne " Introduce tu KEY INCOGNITO: "
            read USER_KEY
            USER_KEY=$(echo "$USER_KEY" | tr -d '[:space:]')

            echo ""
            echo -e "${YELLOW} Verificando licencia...${NC}"

            RESPONSE=$(curl -s -L -k --connect-timeout 10 \
              -A "IncognitoClient/1.0" \
              "${INCOGNITO_API_URL}/validar?key=${USER_KEY}&os=${OS_NAME// /%20}")

            if [[ "$RESPONSE" == *"AUTORIZADO"* ]]; then
                echo ""
                echo -e "${GREEN} [OK] LICENCIA VALIDA. Iniciando instalacion...${NC}"
                sleep 1

                # Instalar dependencias completas
                if [[ -f /etc/redhat-release ]]; then
                    yum install -y curl jq bc wget net-tools python3 python3-pip psmisc nano git socat cronie iptables-services unzip zip openssl lsof >/dev/null 2>&1
                else
                    apt-get install -y curl jq bc wget net-tools python3 python3-pip psmisc nano git socat cron iptables-persistent netfilter-persistent dnsutils zip unzip openssl lsof >/dev/null 2>&1
                fi

                mkdir -p $BASE_DIR/bin $BASE_DIR/users

                # Optimizar red (TCP BBR)
                cat <<EOF >> /etc/sysctl.conf
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

                # Instalar menú
                wget -q -O /usr/local/bin/incognito "$MENU_URL"
                chmod +x /usr/local/bin/incognito

                # Banner SSH
                cat <<'BEOF' > /etc/motd
  ___ _   _  ____ ___   ___  _   _ ___ _____ ___
 |_ _| \ | |/ ___/ _ \ / _ \| \ | |_ _|_   _/ _ \
  | ||  \| | |  | | | | | | |  \| || |  | || | | |
  | || |\  | |__| |_| | |_| | |\  || |  | || |_| |
 |___|_| \_|\____\___/ \___/|_| \_|___| |_| \___/
BEOF

                clear
                echo -e "$LINE"
                center_text "${GREEN}INSTALACION COMPLETADA${NC}"
                center_text "${GREEN}INCOGNITO VPN MANAGER${NC}"
                echo -e "$LINE"
                echo ""
                center_text "Escribe ${YELLOW}'incognito'${NC} para entrar al panel"
                echo ""
                for i in {5..1}; do
                    echo -ne "    \r    ${RED}[!]${NC} Reiniciando en: ${RED}$i${NC} "
                    sleep 1
                done
                reboot
            else
                echo ""
                echo -e "${RED} [ERROR] LICENCIA INVALIDA O EXPIRADA.${NC}"
                if [[ -n "$RESPONSE" ]]; then
                    echo -e "${YELLOW} Respuesta: $RESPONSE${NC}"
                else
                    echo -e "${RED} No se pudo contactar al servidor. Verifica tu conexion.${NC}"
                fi
                echo ""
                read -p " Presiona Enter para volver..."
            fi
            ;;
        2)
            echo -ne "${RED}  Escriba 'BORRAR' para confirmar la desinstalacion: ${NC}"
            read CONF
            if [[ "$CONF" == "BORRAR" ]]; then
                systemctl stop ws-incognito >/dev/null 2>&1
                systemctl disable ws-incognito >/dev/null 2>&1
                rm -f /etc/systemd/system/ws-incognito.service
                rm -rf $BASE_DIR
                rm -f /usr/local/bin/incognito
                echo -e "${GREEN}  Script desinstalado correctamente.${NC}"
                sleep 2
                exit 0
            fi
            ;;
        0) exit 0 ;;
        *) echo -e "${RED} Opcion invalida${NC}"; sleep 1 ;;
    esac
done
