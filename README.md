## resetssh.sh
Este script realiza uma reinstalação completa do servidor OpenSSH no sistema Ubuntu. Ele executa as seguintes operações:

1. Atualiza o sistema operacional
2. Remove completamente o OpenSSH e suas configurações
3. Limpa todas as dependências relacionadas
4. Reinstala o OpenSSH do zero
5. Oferece a opção de:
   - Ativar login root via SSH
   - Configurar autenticação por senha
   - Definir senha padrão para o usuário root
   - senha padrão root 1234

### Uso
```bash 
curl -fsSL https://raw.githubusercontent.com/panpandev/linux/refs/heads/main/resetssh.sh | sudo bash
```
---

## monitor.sh

Este script é uma ferramenta de monitoramento em tempo real para sistemas Linux. Ele fornece uma visão completa do sistema, monitorando:
- CPU (uso, processos)
- Memória (RAM e Swap)
- Disco (espaço e alertas)
- Rede (interfaces e conexões)
- Serviços (status de SSH, Apache, MySQL, Nginx)
- Temperatura da CPU
- Logs do sistema
- Usuários logados

### Uso
```bash 
curl -fsSL https://raw.githubusercontent.com/panpandev/linux/refs/heads/main/monitor.sh | sudo bash
```

##  javainstall.sh

instalação java JRE para minecraft

### Uso
```bash 
curl -fsSL https://raw.githubusercontent.com/panpandev/linux/refs/heads/main/javainstall.sh | sudo bash
```

### Observações
- O script requer privilégios de superusuário (sudo)
- Use com cautela em ambientes de produção
- faça backup dos arquivos em que sera editado

