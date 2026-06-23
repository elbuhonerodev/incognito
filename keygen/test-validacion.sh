#!/bin/bash

# ==============================
# TEST VALIDAR.PHP - REAGENS
# MENU INTERACTIVO DEBUG (PRO)
# ==============================

# USO:
# wget -q -O test-validacion.sh "https://over.xzod.cloud/reagens-scritp/keygen/test-validacion.sh" && chmod +x test-validacion.sh && ./test-validacion.sh

MASTER_URL="https://over.xzod.cloud/reagens-scritp/validar.php"
USER_AGENT="Mozilla/5.0"

# COLORES
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[1;34m'
NC='\033[0m'

get_ip() {
    curl -s https://api.ipify.org
}

# ---------------------------------
# MOSTRAR RESPUESTA ADORNADA
# ---------------------------------
mostrar_resultado() {
    local raw="$1"

    HTTP_CODE=$(echo "$raw" | grep -o "HTTP_CODE:[0-9]*" | cut -d: -f2)
    BODY=$(echo "$raw" | sed '/HTTP_CODE:/d')

    echo ""

    if [[ "$HTTP_CODE" != "200" ]]; then
        echo -e "${RED}✖ ERROR DE CONEXIÓN${NC}"
        echo -e "${YELLOW}Servidor no respondió correctamente (HTTP $HTTP_CODE)${NC}"
        return
    fi

    if echo "$BODY" | grep -q "AUTORIZADO"; then
        echo -e "${GREEN}✔ AUTORIZACIÓN EXITOSA${NC}"
        echo -e "${CYAN}Tu IP / KEY está AUTORIZADA.${NC}"
        echo -e "${BLUE}Disfrútalo 😎 — Estado: LIFETIME${NC}"
    else
        echo -e "${RED}✖ ACCESO DENEGADO${NC}"
        echo -e "${YELLOW}Tu IP o KEY NO está autorizada.${NC}"
        echo -e "${RED}Verifica tu licencia.${NC}"
    fi
}

# ---------------------------------
# HEADER
# ---------------------------------
clear
echo -e "${BLUE}=========================================${NC}"
echo -e "${CYAN}      TEST DE VALIDACION REAGENS${NC}"
echo -e "${BLUE}=========================================${NC}"
echo ""

IP_PUBLICA=$(get_ip)
echo -e "${YELLOW}[INFO]${NC} Tu IP pública detectada: ${CYAN}$IP_PUBLICA${NC}"
echo ""

# ---------------------------------
# MENU LOOP
# ---------------------------------
while true; do
    echo -e "${BLUE}-----------------------------------------${NC}"
    echo -e "${CYAN} Selecciona una opción:${NC}"
    echo -e "${BLUE}-----------------------------------------${NC}"
    echo -e " ${GREEN}1)${NC} Verificar SOLO por IP"
    echo -e " ${GREEN}2)${NC} Probar una KEY manualmente"
    echo -e " ${GREEN}3)${NC} Salir"
    echo -e "${BLUE}-----------------------------------------${NC}"
    read -p " Opción: " OPCION
    echo ""

    case "$OPCION" in
        1)
            echo -e "${CYAN}[TEST]${NC} Verificando IP..."
            RAW=$(curl -s -L -k \
                -w "\nHTTP_CODE:%{http_code}\n" \
                --connect-timeout 10 \
                -A "$USER_AGENT" \
                "$MASTER_URL")
            mostrar_resultado "$RAW"
            ;;
        2)
            read -p "Introduce la KEY a probar: " TEST_KEY
            TEST_KEY=$(echo "$TEST_KEY" | tr -d '[:space:]')

            if [[ -z "$TEST_KEY" ]]; then
                echo -e "${YELLOW}[INFO] KEY vacía, cancelado.${NC}"
            else
                echo -e "${CYAN}[TEST]${NC} Enviando KEY..."
                RAW=$(curl -s -L -k \
                    -w "\nHTTP_CODE:%{http_code}\n" \
                    --connect-timeout 10 \
                    -A "$USER_AGENT" \
                    "$MASTER_URL?key=$TEST_KEY")
                mostrar_resultado "$RAW"
            fi
            ;;
        3)
            echo ""
            echo -e "${GREEN}[OK]${NC} Saliendo del test. Hasta luego bro 😎"
            echo ""
            exit 0
            ;;
        *)
            echo -e "${RED}[ERROR] Opción inválida.${NC}"
            ;;
    esac

    echo ""
    read -p "Presiona ENTER para continuar..." _
    clear
    echo -e "${BLUE}=========================================${NC}"
    echo -e "${CYAN}      TEST DE VALIDACION REAGENS${NC}"
    echo -e "${BLUE}=========================================${NC}"
    echo ""
    echo -e "${YELLOW}[INFO]${NC} Tu IP pública detectada: ${CYAN}$IP_PUBLICA${NC}"
    echo ""
done