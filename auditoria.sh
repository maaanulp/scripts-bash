#!/bin/bash

# ==========================================
# SCRIPT DE AUDITORÍA DE SISTEMA Y RED V2.0
# ==========================================

GREEN='\033[0;32m'
NC='\033[0m' # Sin color

echo "=========================================="
echo "    INFORME DE SISTEMA Y RED LOCAL V2.0"
echo "=========================================="
echo ""

# 1. Información de usuario y equipo
echo -e "${GREEN}[+] Usuario y Host:${NC}"
echo "    -> Usuario: $(whoami)"
echo "    -> Equipo:  $(hostname)"
echo ""

# 2. IP Local
echo -e "${GREEN}[+] Dirección IP local:${NC}"
ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print "    -> " $2}'
echo ""

# 3. Uso de Memoria RAM
echo -e "${GREEN}[+] Memoria RAM Disponible:${NC}"
free -h | awk 'NR==2{print "    -> Libre: " $4 " de " $2}'
echo ""

# 4. Puertos en escucha (Redes / Seguridad)
echo -e "${GREEN}[+] Puertos locales en escucha (TCP/UDP):${NC}"
ss -tuln | awk 'NR>1 {print "    -> " $1 " - " $5}' | head -n 10
echo ""

# 5. Estado del Cortafuegos (UFW)
echo -e "${GREEN}[+] Estado del Firewall (UFW):${NC}"
if sudo ufw status | grep -q "active"; then
    echo "    -> Estado: ACTIVO"
else
    echo "    -> Estado: INACTIVO (Se recomienda activar)"
fi
echo ""

# 6. Prueba de Conectividad
echo -e "${GREEN}[+] Conectividad a Internet:${NC}"
if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    echo "    -> Estado: CONECTADO"
else
    echo "    -> Estado: SIN CONEXIÓN"
fi

echo ""
echo "=========================================="#!/bin/bash

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
