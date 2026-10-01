#!/bin/bash

echo "=========================================="
echo "    INFORME DE SISTEMA Y RED LOCAL"
echo "=========================================="
echo ""

# 1. Información de usuario y equipo
echo "[+] Usuario actual: $(whoami)"
echo "[+] Nombre del equipo: $(hostname)"
echo ""

# 2. IP Local (Filtrando con grep y awk)
echo "[+] Dirección IP local:"
ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print "    -> " $2}'
echo ""

# 3. Uso de Memoria RAM
echo "[+] Memoria RAM Disponible:"
free -h | awk 'NR==2{print "    -> " $4}'
echo ""

# 4. Prueba de Conectividad (Ping silencioso)
echo "[+] Comprobando conectividad a Internet..."
ping -c 1 8.8.8.8 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "    -> Estado: CONECTADO"
else
    echo "    -> Estado: SIN CONEXIÓN"
fi

echo ""
echo "=========================================="
