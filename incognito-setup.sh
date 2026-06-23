#!/bin/bash

# ==================================================
# INCOGNITO VPN - SETUP ULTIMATE (BASH ONLY)
# PROTOCOLO SMART FORCE - 101 CUSTOM - MEGA BANNER
# ==================================================

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
NC='\033[0m'

# --- INSTALACIÓN FORZADA DE CURL AL INICIO ---
if ! command -v curl &> /dev/null; then
    echo -e "${YELLOW}[!] Curl no detectado. Instalando...${NC}"
    if [[ -f /etc/redhat-release ]]; then
        yum install -y curl >/dev/null 2>&1
    else
        apt-get update -y >/dev/null 2>&1
        apt-get install -y curl >/dev/null 2>&1
    fi
fi

# CONFIGURACION INCOGNITO
# IMPORTANTE: Reemplazar por la IP de tu VPS maestro donde correrá el Main.go
INCOGNITO_API_URL="http://44.221.239.231:8080"
MENU_URL="https://raw.githubusercontent.com/TU_USUARIO_GITHUB/incognito/main/incognito-menu.sh"
BASE_DIR="/etc/incognito"

# --- FUNCIONES DE SOPORTE ---
conectar_master() {
  local params=$1
  # Llama a nuestro Go Backend a la ruta /validar?key=TU_KEY
  curl -s -L -k --connect-timeout 8 \
  -A "IncognitoClient/1.0" \
  "${INCOGNITO_API_URL}/validar${params}"
}

msg_center() {
  local text="$1"
  local clean_text=$(echo -e "$text" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
  local len=${#clean_text}
  local cols=53
  local space=$(( ($cols - $len) / 2 ))
  [[ $space -lt 0 ]] && space=0
  printf "%${space}s" " "
  echo -e "$text"
}

fun_save_iptables() {
    if [[ -f /etc/redhat-release ]]; then
        service iptables save >/dev/null 2>&1
    else
        netfilter-persistent save >/dev/null 2>&1
    fi
}

fun_salir_script() {
    clear
    echo ""
    msg_center "${BLUE} ___ _   _  ____ ___   ____ _   _ ___ _____ ___ ${NC}"
    msg_center "${BLUE}|_ _| \ | |/ ___/ _ \ / ___| \ | |_ _|_   _/ _ \ ${NC}"
    msg_center "${BLUE} | ||  \| | |  | | | | |  _|  \| || |  | || | | |${NC}"
    msg_center "${BLUE} | || |\  | |__| |_| | |_| | |\  || |  | || |_| |${NC}"
    msg_center "${BLUE}|___|_| \_|\____\___/ \____|_| \_|___| |_| \___/ ${NC}"
    echo ""
    msg_center "${YELLOW}CREATOR : INCOGNITO ADMIN${NC}"
    echo ""
    msg_center "${CYAN}Para iniciar INCOGNITO MANAGER escriba: incognito${NC}"
    echo ""
    exit 0
}

# ==================================================
# 0. DETECCION DE SO E INSTALACION DE DEPENDENCIAS
# ==================================================
clear
echo -e "${YELLOW}[!] Identificando Sistema Operativo y Preparando Entorno v2...${NC}"

if [[ -f /etc/redhat-release ]]; then
    PM="yum"
    yum install -y epel-release >/dev/null 2>&1
    yum install -y curl jq bc wget net-tools psmisc nano git socat cronie iptables-services unzip zip bind-utils openssl python3 python3-pip lsof >/dev/null 2>&1
    systemctl enable crond >/dev/null 2>&1 && systemctl start crond >/dev/null 2>&1
else
    PM="apt-get"
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y >/dev/null 2>&1
    apt-get install -y curl jq bc wget net-tools python3 python3-pip psmisc nano git socat cron iptables-persistent netfilter-persistent dnsutils zip unzip certbot openssl zram-tools lsof >/dev/null 2>&1
fi

mkdir -p $BASE_DIR/bin $BASE_DIR/users $BASE_DIR/bot

# ==========================================
# OPTIMIZACIÓN DE RED INCOGNITO PRO (TCP BBR)
# ==========================================
echo -e "\n[*] Optimizando Kernel para baja latencia y alta velocidad..."

# 1. Copiar parámetros al archivo de configuración del sistema
cat <<EOF >> /etc/sysctl.conf
# Optimizaciones de Red Incognito
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_slow_start_after_idle = 0
EOF

# 2. Aplicar los cambios inmediatamente sin reiniciar
sysctl -p > /dev/null 2>&1

echo -e "[*] ¡Optimización aplicada exitosamente!"
# ==========================================

# ==================================================
# 1. VALIDACION DE LICENCIA CONTRA GO BACKEND
# ==================================================
echo -e "${YELLOW}[!] Verificando estado de licencia...${NC}"

read -p " Introduce tu LICENCIA (KEY INCOGNITO): " USER_KEY
USER_KEY=$(echo "$USER_KEY" | tr -d '[:space:]')

# Realizamos ping al Master Go
RESPONSE=$(conectar_master "?key=${USER_KEY}")

if [[ "$RESPONSE" == *"AUTORIZADO"* ]]; then
    echo -e "${GREEN}[OK] KEY ACEPTADA POR EL MASTER GO.${NC}"
else
    echo -e "${RED}[ERROR] LICENCIA INVALIDA O EXPIRADA.${NC}"
    echo -e "${YELLOW}Respuesta del Servidor: $RESPONSE${NC}"
    exit 1
fi

# ==========================================================
# 2. SISTEMA DE EMERGENCIA & ANCLAJE PUERTO 80 (FORCE START)
# ==========================================================
echo -e "${YELLOW}[!] Liberando puerto 80 y activando WebSocket Directo...${NC}"

# 1. LIMPIEZA AGRESIVA DE PUERTO 80
systemctl stop nginx apache2 httpd ws-incognito >/dev/null 2>&1
fuser -k 80/tcp >/dev/null 2>&1
pkill -9 nginx >/dev/null 2>&1
pkill -9 httpd >/dev/null 2>&1
sleep 1

# 2. CREACION DEL BINARIO PYTHON (PUERTO 80 -> 22)
mkdir -p $BASE_DIR/bin
cat <<'EOF' > $BASE_DIR/bin/ws-fix.py
import socket, threading, select, sys

BIND, DEST = ('0.0.0.0', 80), ('127.0.0.1', 22)
BUFFER_SIZE = 16384 
MSG_101 = b'HTTP/1.1 101 INCOGNITO VPN PRO\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n\r\n'

def handler(c_sock):
    c_sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    t_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    t_sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    try:
        t_sock.connect(DEST)
        c_sock.send(MSG_101)
        while True:
            r, w, x = select.select([c_sock, t_sock], [], [])
            if c_sock in r:
                d = c_sock.recv(BUFFER_SIZE)
                if not d: break
                t_sock.send(d)
            if t_sock in r:
                d = t_sock.recv(BUFFER_SIZE)
                if not d: break
                c_sock.send(d)
    except: pass
    finally: c_sock.close(); t_sock.close()

def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    try: 
        server.bind(BIND)
        server.listen(200)
    except: sys.exit(1)
    while True:
        try: 
            conn, addr = server.accept()
            threading.Thread(target=handler, args=(conn,), daemon=True).start()
        except: pass

if __name__ == '__main__': main()
EOF

# 3. CONFIGURACION DEL SERVICIO SYSTEMD
cat <<EOF > /etc/systemd/system/ws-incognito.service
[Unit]
Description=Incognito Python WS Auto-Force
After=network.target
[Service]
ExecStart=/usr/bin/python3 $BASE_DIR/bin/ws-fix.py
Restart=always
RestartSec=3
User=root
[Install]
WantedBy=multi-user.target
EOF

# 4. FIREWALL Y ARRANQUE INMEDIATO
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
fun_save_iptables >/dev/null 2>&1

systemctl daemon-reload
systemctl enable ws-incognito >/dev/null 2>&1
systemctl restart ws-incognito

if netstat -tuln | grep -q ":80 "; then
    echo -e "${GREEN}[OK] PUERTO 80 LISTO Y RESPONDIENDO AL 22.${NC}"
else
    echo -e "${RED}[!] ADVERTENCIA: No se pudo anclar el puerto 80 automáticamente.${NC}"
fi

# ==================================================
# 3. INSTALACION DE MENU Y BANNERS UNIFICADOS
# ==================================================
echo -e "${YELLOW}[!] Finalizando Banners y Menú...${NC}"
wget -q -O /usr/local/bin/incognito "$MENU_URL"
chmod +x /usr/local/bin/incognito

# --- BANNER SSH (ISSUE.NET) ---
cat <<'EOF' > /etc/issue.net
<p style="text-align:center"><font color="white">
███████████████████████████<br>
███████▀▀▀░░░░░░░▀▀▀███████<br>
████▀░░░░░░░░░░░░░░░░░▀████<br>
███│░░░░░░░░░░░░░░░░░░░│███<br>
██▌│░░░░░░░░░░░░░░░░░░░│▐██<br>
██░└┐░░░░░░░░░░░░░░░░░┌┘░██<br>
██░░└┐░░░░░░░░░░░░░░░┌┘░░██<br>
██░░┌┘▄▄▄▄▄░░░░░▄▄▄▄▄└┐░░██<br>
██▌░│██████▌░░░▐██████│░▐██<br>
███░│▐███▀▀░░▄░░▀▀███▌│░███<br>
██▀─┘░░░░░░░▐█▌░░░░░░░└─▀██<br>
██▄░░░▄▄▄▓░░▀█▀░░▓▄▄▄░░░▄██<br>
████▄─┘██▌░░░░░░░▐██└─▄████<br>
█████░░▐█─┬┬┬┬┬┬┬─█▌░░█████<br>
████▌░░░▀┬┼┼┼┼┼┼┼┬▀░░░▐████<br>
█████▄░░░└┴┴┴┴┴┴┴┘░░░▄█████<br>
███████▄░░░░░░░░░░░▄███████<br>
██████████▄▄▄▄▄▄▄██████████<br>
███████████████████████████<br>
</font></p>
<h4 style="text-align:center"><font color="red">❢◥ ▬▬▬▬▬▬ ◆ ▬▬▬▬▬▬ ◤❢</font><h1 style="text-align:center"><font color="#338AFF"> INCOGNITO VPN </font><h4 style="text-align:center"><Font color="red">❢◥ ▬▬▬▬▬▬ ◆ ▬▬▬▬▬▬ ◤❢<h4><BR></font><h4 style="text-align:center"></font><h5 style="text-align:center"><font color="blue">---- MÁXIMA SEGURIDAD ----</font> 
EOF

# --- BANNER MOTD (CONSOLA) ---
cat <<'EOF' > /etc/motd
  ___ _   _  ____ ___   ____ _   _ ___ _____ ___ 
 |_ _| \ | |/ ___/ _ \ / ___| \ | |_ _|_   _/ _ \ 
  | ||  \| | |  | | | | |  _|  \| || |  | || | | |
  | || |\  | |__| |_| | |_| | |\  || |  | || |_| |
 |___|_| \_|\____\___/ \____|_| \_|___| |_| \___/ 

EOF

sed -i '/^Banner/d' /etc/ssh/sshd_config
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
systemctl restart ssh >/dev/null 2>&1

# ==================================================
# 4. MENSAJE FINAL
# ==================================================
clear
echo -e "${BLUE}=====================================================${NC}"
msg_center "${GREEN}FELICIDADES TU SISTEMA YA ESTA CONFIGURADO${NC}"
msg_center "${GREEN}INCOGNITO VPN PRO MANAGER FOR VPS${NC}"
echo -e "${BLUE}=====================================================${NC}"
echo ""
msg_center "DENTRO DE UNOS SEGUNDOS TU SISTEMA SE REINICIARA"
msg_center "AL INICIAR, ESCRIBE 'incognito' PARA ENTRAR"
echo ""
echo -e "${BLUE}=====================================================${NC}"

for i in {5..1}; do
  echo -ne "    \r    ${RED}[!]${NC} REINICIANDO VPS EN: ${RED}$i${NC} "
  sleep 1
done
reboot
