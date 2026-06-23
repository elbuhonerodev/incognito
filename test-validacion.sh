#!/bin/bash

# ==============================
# TEST VALIDAR.PHP - REAGENS
# ==============================

MASTER_URL="https://over.xzod.cloud/reagens-scritp/validar.php"

echo "========================================="
echo "      TEST DE VALIDACION REAGENS"
echo "========================================="
echo ""

# Obtener IP pública real
IP_PUBLICA=$(curl -s https://api.ipify.org)

echo "[INFO] Tu IP pública detectada: $IP_PUBLICA"
echo ""

echo "-----------------------------------------"
echo "[1] Probando verificación SOLO por IP..."
echo "-----------------------------------------"

RESPUESTA_IP=$(curl -s -L -k -w "\nHTTP_CODE:%{http_code}\n" \
--connect-timeout 10 \
-A "Mozilla/5.0" \
"$MASTER_URL")

echo "$RESPUESTA_IP"
echo ""

echo "-----------------------------------------"
echo "[2] Probar una KEY manualmente"
echo "-----------------------------------------"
read -p "Introduce una KEY para probar (o ENTER para saltar): " TEST_KEY

if [[ ! -z "$TEST_KEY" ]]; then
    echo ""
    echo "[INFO] Enviando key..."
    
    RESPUESTA_KEY=$(curl -s -L -k -w "\nHTTP_CODE:%{http_code}\n" \
    --connect-timeout 10 \
    -A "Mozilla/5.0" \
    "$MASTER_URL?key=$TEST_KEY")

    echo "$RESPUESTA_KEY"
else
    echo "[INFO] Prueba de key omitida."
fi

echo ""
echo "========================================="
echo "        FIN DE PRUEBA"
echo "========================================="