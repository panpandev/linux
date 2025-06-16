#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para mostrar o cabeçalho
show_header() {
    clear
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗"
    echo -e "║                    MONITORAMENTO DO SISTEMA                ║"
    echo -e "╚════════════════════════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}[*] Data/Hora: $(date)${NC}\n"
}

# Função para monitorar CPU
monitor_cpu() {
    echo -e "${GREEN}=== CPU ===${NC}"
    echo -e "Uso de CPU: ${YELLOW}$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%${NC}"
    echo -e "Processos: ${YELLOW}$(ps aux | wc -l)${NC}"
    echo -e "Top 5 processos por CPU:"
    ps aux | sort -nrk 3,3 | head -5 | awk '{print $2,$3"%",$11}'
    echo
}

# Função para monitorar Memória
monitor_memory() {
    echo -e "${GREEN}=== MEMÓRIA ===${NC}"
    free -h | awk 'NR==2{printf "Memória Total: %s\n", $2}'
    free -h | awk 'NR==2{printf "Memória Usada: %s (%.2f%%)\n", $3, $3*100/$2}'
    free -h | awk 'NR==2{printf "Memória Livre: %s\n", $4}'
    echo -e "Swap Usada: ${YELLOW}$(free -h | awk 'NR==3{printf "%s (%.2f%%)\n", $3, $3*100/$2}')${NC}"
    echo
}

# Função para monitorar Disco
monitor_disk() {
    echo -e "${GREEN}=== DISCO ===${NC}"
    df -h | grep -v "tmpfs" | awk 'NR>1{print $5,$6}' | while read usage mount; do
        if [ ${usage%?} -gt 80 ]; then
            echo -e "${RED}ALERTA: $mount está com $usage de uso${NC}"
        else
            echo -e "Uso de $mount: ${YELLOW}$usage${NC}"
        fi
    done
    echo
}

# Função para monitorar Rede
monitor_network() {
    echo -e "${GREEN}=== REDE ===${NC}"
    echo -e "Interfaces de Rede:"
    ip -o addr show | awk '{print $2,$4}'
    echo -e "\nConexões Ativas:"
    netstat -tuln | grep LISTEN
    echo
}

# Função para monitorar Serviços
monitor_services() {
    echo -e "${GREEN}=== SERVIÇOS ===${NC}"
    echo -e "Status dos Serviços Principais:"
    services=("ssh" "apache2" "mysql" "nginx")
    for service in "${services[@]}"; do
        if systemctl is-active --quiet $service; then
            echo -e "$service: ${GREEN}ATIVO${NC}"
        else
            echo -e "$service: ${RED}INATIVO${NC}"
        fi
    done
    echo
}

# Função para monitorar Temperatura
monitor_temperature() {
    echo -e "${GREEN}=== TEMPERATURA ===${NC}"
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp)
        temp_c=$(echo "scale=1; $temp/1000" | bc)
        echo -e "Temperatura CPU: ${YELLOW}${temp_c}°C${NC}"
    fi
    echo
}

# Função para monitorar Logs
monitor_logs() {
    echo -e "${GREEN}=== ÚLTIMOS LOGS ===${NC}"
    echo -e "Últimas 5 linhas do syslog:"
    tail -n 5 /var/log/syslog
    echo
}

# Função para monitorar Usuários
monitor_users() {
    echo -e "${GREEN}=== USUÁRIOS ===${NC}"
    echo -e "Usuários Logados:"
    who
    echo -e "\nÚltimos Logins:"
    last -n 5
    echo
}

# Executa todas as funções de monitoramento
show_header
monitor_cpu
monitor_memory
monitor_disk
monitor_network
monitor_services
monitor_temperature
monitor_logs
monitor_users 