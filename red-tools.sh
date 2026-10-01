#!/bin/bash

# ==========================================
# SUITE DE HERRAMIENTAS DE RED (red-tools)
# ==========================================

# Colores para la interfaz
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

# --- FUNCIONES ---

mostrar_uso() {
    echo -e "${BLUE}Uso:${NC} $0 [opción]"
    echo ""
    echo "Opciones disponibles:"
    echo "  -i, --ip        Muestra la dirección IP local y pública"
    echo "  -p, --puertos   Lista los puertos locales en escucha"
    echo "  -c, --ping      Realiza una prueba rápida de conectividad"
    echo "  -m, --menu      Abre el menú interactivo"
    echo "  -h, --help      Muestra esta ayuda"
}

obtener_ips() {
    echo -e "${GREEN}[+] Dirección IP local:${NC}"
    ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print "    -> " $2}'
    echo ""
    echo -e "${GREEN}[+] Dirección IP pública (vía ipify):${NC}"
    curl -s https://api.ipify.org | awk '{print "    -> " $1}' || echo "    -> No disponible"
    echo ""
}

listar_puertos() {
    echo -e "${GREEN}[+] Puertos locales en escucha (TCP/UDP):${NC}"
    ss -tuln | awk 'NR>1 {print "    -> " $1 " - " $5}' | head -n 12
    echo ""
}

probar_ping() {
    echo -e "${GREEN}[+] Verificando latencia con Google (8.8.8.8)...${NC}"
    ping -c 3 8.8.8.8 | tail -n 2
    echo ""
}

menu_interactivo() {
    local opcion
    while true; do
        echo "=========================================="
        echo "      MENÚ INTERACTIVO - RED TOOLS"
        echo "=========================================="
        echo "1) Consultar IPs (Local y Pública)"
        echo "2) Ver Puertos en escucha"
        echo "3) Probar Conectividad (Ping)"
        echo "4) Salir"
        echo -n "Selecciona una opción [1-4]: "
        read -r opcion
        echo ""

        case "$opcion" in
            1) obtener_ips ;;
            2) listar_puertos ;;
            3) probar_ping ;;
            4) echo -e "${RED}Saliendo...${NC}"; break ;;
            *) echo -e "${RED}Opción no válida.${NC}\n" ;;
        esac
    done
}

# --- LÓGICA PRINCIPAL ---

# Si no se pasa ningún argumento, muestra el menú por defecto
if [ $# -eq 0 ]; then
    menu_interactivo
    exit 0
fi

# Procesamiento de parámetros pasados por consola ($1)
case "$1" in
    -i|--ip)
        obtener_ips
        ;;
    -p|--puertos)
        listar_puertos
        ;;
    -c|--ping)
        probar_ping
        ;;
    -m|--menu)
        menu_interactivo
        ;;
    -h|--help)
        mostrar_uso
        ;;
    *)
        echo -e "${RED}Error: Opción desconocida '$1'${NC}\n"
        mostrar_uso
        exit 1
        ;;
esac