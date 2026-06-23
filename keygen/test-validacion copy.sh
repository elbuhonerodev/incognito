#!/bin/bash

# ==============================
# TEST VALIDAR.PHP - REAGENS
# MENU INTERACTIVO DEBUG
# ==============================

#uso
#wget -q -O test-validacion.sh "https://over.xzod.cloud/reagens-scritp/keygen/test-validacion.sh" && chmod +x test-validacion.sh && ./test-validacion.sh
MASTER_URL="https://over.xzod.cloud/reagens-scritp/validar.php"
USER_AGENT="Mozilla/5.0"

get_ip() {
    curl -s https://api.ipify.org
}

clear
echo "========================================="
echo "      TEST DE VALIDACION REAGENS"
echo "========================================="
echo ""

IP_PUBLICA=$(get_ip)
echo "[INFO] Tu IP pública detectada: $IP_PUBLICA"
echo ""

while true; do
    echo "-----------------------------------------"
    echo " Selecciona una opción:"
    echo "-----------------------------------------"
    echo " 1) Verificar SOLO por IP"
    echo " 2) Probar una KEY manualmente"
    echo " 3) Salir"
    echo "-----------------------------------------"
    read -p " Opción: " OPCION
    echo ""

    case "$OPCION" in
        1)
            echo "[TEST] Verificando IP..."
            RESPUESTA=$(curl -s -L -k \
                -w "\nHTTP_CODE:%{http_code}\n" \
                --connect-timeout 10 \
                -A "$USER_AGENT" \
                "$MASTER_URL")
            echo "$RESPUESTA"
            ;;
        2)
            read -p "Introduce la KEY a probar: " TEST_KEY
            TEST_KEY=$(echo "$TEST_KEY" | tr -d '[:space:]')

            if [[ -z "$TEST_KEY" ]]; then
                echo "[INFO] KEY vacía, cancelado."
            else
                echo "[TEST] Enviando KEY..."
                RESPUESTA=$(curl -s -L -k \
                    -w "\nHTTP_CODE:%{http_code}\n" \
                    --connect-timeout 10 \
                    -A "$USER_AGENT" \
                    "$MASTER_URL?key=$TEST_KEY")
                echo "$RESPUESTA"
            fi
            ;;
        3)
            echo ""
            echo "[OK] Saliendo del test. Hasta luego bro 😎"
            echo ""
            exit 0
            ;;
        *)
            echo "[ERROR] Opción inválida."
            ;;
    esac

    echo ""
    read -p "Presiona ENTER para continuar..." _
    clear
    echo "========================================="
    echo "      TEST DE VALIDACION REAGENS"
    echo "========================================="
    echo ""
    echo "[INFO] Tu IP pública detectada: $IP_PUBLICA"
    echo ""
done