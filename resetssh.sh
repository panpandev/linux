#!/bin/bash
echo -e "\e[32m"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║                _                 _                         ║"
echo "║          _   _| |__  _   _ _ __ | |_ _   _                 ║"
echo "║         | | | | '_ \| | | | '_ \| __| | | |                ║"
echo "║         | |_| | |_) | |_| | | | | |_| |_| |                ║"
echo "║          \__,_|_.__/ \__,_|_| |_|\__|\__,_|                ║"
echo "║                                                            ║"
echo "║               RESET DO SERVIDOR SSH                        ║"
echo "║                                                            ║"
echo "║  [*] Iniciando reset do servidor ssh...                    ║"
echo "║  [*] Sistema: Ubuntu $(lsb_release -rs)                                 ║"
echo "║  [*] Data: $(date)                    ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "\e[0m"
sleep 3

# atualizando sistema 
echo -e "\e[32m[*] Atualizando o sistema...\e[0m"
sleep 2
apt update && apt upgrade -y

# parar os serviços ssh
echo -e "\e[32m[*] Parando servicos do sistema...\e[0m"
sleep 3
sudo service ssh stop
sudo service sshd stop

# Remover pacote Openssh 
echo -e "\e[32m[*] Deletendo servidor Openssh...\e[0m"
sleep 3
sudo apt remove --purge openssh-server openssh-client -y

# Deletar pastas ssh 
echo -e "\e[32m[*] Deletando as pastas do Openssh...\e[0m"
sleep 3
sudo rm -rf /etc/ssh
sudo rm -f /etc/init.d/ssh
sudo rm -f /etc/init.d/sshd
sudo rm -f /lib/systemd/system/ssh.service
sudo rm -f /lib/systemd/system/sshd.service

# Limpar dependecias
echo -e "\e[32m[*] Limpando depencias...\e[0m"
sleep 2
sudo apt-get autoremove -y
sudo apt-get clean

# instalando Openssh
echo -e "\e[32m[*] Instalando Openssh...\e[0m"
sleep 2
apt install openssh-server openssh-client -y

    sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
    echo -e "\e[32m[*] Definindo senha root para 1234...\e[0m"
    sleep 5
    echo 'root:1234' | sudo chpasswd
    sudo service ssh restart
    echo -e "\e[32m[*] Servico ssh reiniciado...\e[0m"
