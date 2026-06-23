#!/bin/bash

# =========================================
# REAGENS VPN PRO - GENERADOR DE KEYS
# SUPER ADMIN PANEL CONSOLA
# =========================================

BASE_DIR="/etc/reagens"
KEYS_FILE="$BASE_DIR/keys.txt"
ADMIN_CONTROL_URL="https://over.xzod.cloud/reagens-scritp/keygen/admincontrol.txt"

mkdir -p "$BASE_DIR"
touch "$KEYS_FILE"

# COLORES
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
NC='\033[0m'

# DURACIÓN POR DEFECTO DE KEYS (4h)
DURACION_HORAS=4

# FUNCIONES
generar_key() {
    echo "REAGENS-$(openssl rand -hex 5 | tr 'a-z' 'A-Z')"
}

limpiar_expiradas() {
    ahora=$(date +%s)
    tmp=$(mktemp)
    while IFS="|" read -r key exp estado; do
        if [[ -z "$key" ]]; then continue; fi
        if [[ "$ahora" -lt "$exp" ]]; then
            echo "$key|$exp|$estado" >> $tmp
        fi
    done < "$KEYS_FILE"
    mv $tmp $KEYS_FILE
}

crear_key() {
    limpiar_expiradas
    nueva_key=$(generar_key)
    ahora=$(date +%s)
    expira=$((ahora + DURACION_HORAS*3600))
    echo "$nueva_key|$expira|DISPONIBLE" >> "$KEYS_FILE"
    echo ""
    echo -e "${GREEN}✔ KEY GENERADA:${NC} ${CYAN}$nueva_key${NC} | Expira en ${YELLOW}${DURACION_HORAS}h${NC}"
    echo ""
}

listar_keys() {
    limpiar_expiradas
    ahora=$(date +%s)
    echo -e "${BLUE}========= KEYS DISPONIBLES =========${NC}"
    if [[ ! -s $KEYS_FILE ]]; then
        echo -e "${RED}No hay keys registradas.${NC}"
        return
    fi
    while IFS="|" read -r key exp estado; do
        restante=$((exp - ahora))
        horas=$((restante / 3600))
        minutos=$(((restante % 3600) / 60))
        echo -e "${GREEN}$key${NC} | ${YELLOW}${horas}h ${minutos}m restantes${NC} | ${CYAN}$estado${NC}"
    done < "$KEYS_FILE"
    echo ""
}

# =====================================
# VERIFICACION SUPER ADMIN
# =====================================
ip_publica=$(curl -s https://api.ipify.org)
echo "========================================="
echo -e "${CYAN}REAGENS VPN PRO - GENERADOR SUPER ADMIN${NC}"
echo "========================================="
echo "[INFO] Tu IP pública detectada: ${YELLOW}$ip_publica${NC}"
echo ""

# Descargar control
control=$(curl -s "$ADMIN_CONTROL_URL")

# Verificar IP en control
ip_autorizada=$(echo "$control" | grep -E "\|$ip_publica\|" | head -n1)

if [[ -z "$ip_autorizada" ]]; then
    echo -e "${RED}[ERROR] Tu IP no está autorizada en el control.${NC}"
    exit 1
else
    echo -e "${GREEN}[OK] IP autorizada, procede a ingresar tu KEY${NC}"
fi

# Pedir KEY


while true; do
    read -p "Introduce tu KEY de super admin (X para salir): " admin_key
    admin_key=$(echo "$admin_key" | tr -d '[:space:]')

    # Si el usuario pone ENTER sin nada
    if [[ -z "$admin_key" ]]; then
        echo -e "${RED}[ERROR] Debes ingresar una KEY o X para salir.${NC}"
        continue
    fi

    [[ "$admin_key" == "X" || "$admin_key" == "x" ]] && echo "[INFO] Saliendo..." && exit 0

    # Verificar KEY en la misma linea de la IP
    linea=$(echo "$ip_autorizada" | grep "$admin_key")
    if [[ -n "$linea" ]]; then
        # Verificar fecha de expiración
        fecha_exp=$(echo "$linea" | cut -d"|" -f3)
        hoy=$(date +%Y-%m-%d)
        if [[ "$hoy" > "$fecha_exp" ]]; then
            echo -e "${RED}[ERROR] La KEY ha expirado.${NC}"
            continue
        fi
        echo -e "${GREEN}[OK] Acceso autorizado. Bienvenido al generador.${NC}"
        break
    else
        echo -e "${RED}[ERROR] KEY inválida.${NC}"
    fi
done


# =====================================
# MENU SUPER ADMIN
# =====================================
while true; do
    clear
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${CYAN}     GENERADOR DE KEYS - SUPER ADMIN${NC}"
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${GREEN}1)${NC} Generar nueva key"
    echo -e "${GREEN}2)${NC} Ver keys activas"
    echo -e "${GREEN}3)${NC} Limpiar expiradas"
    echo -e "${GREEN}4)${NC} Resetear todas"
    echo -e "${GREEN}X)${NC} Salir"
    echo ""
    read -p "Selecciona opción: " opc

    case $opc in
        1) crear_key ;;
        2) listar_keys ;;
        3) limpiar_expiradas; echo -e "${GREEN}Limpieza completada.${NC}" ;;
        4) > "$KEYS_FILE"; echo -e "${RED}Todas las keys fueron eliminadas.${NC}" ;;
        X|x) echo "[INFO] Saliendo..."; exit 0 ;;
        *) echo -e "${RED}Opción inválida${NC}" ;;
    esac

    echo ""
    read -p "Presiona ENTER para continuar..." _
done