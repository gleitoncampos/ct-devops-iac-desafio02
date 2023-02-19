#!/bin/bash
# Aguardando montagem do disco e copia do docker-compose.yml 
sleep 1m
# Atualizando
sudo apt update -y
sudo apt full-upgrade -y 
# Criando o ponto de montagem
sudo mkdir /mnt/wordpress-data
# Montando o volume anexado
sudo mount /dev/xvdw /mnt/wordpress-data
# Prevenindo em caso de restart da instancia 
echo '/dev/xvdw /mnt/wordpress-data  ext3 defaults,noatime 1 2' | sudo tee -a /etc/fstab > /dev/null
# Instalando Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# Enable e restart do Docker
sudo systemctl enable docker.service
sudo systemctl restart docker.service
# Instalando docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# Dando permissão de execução
sudo chmod +x /usr/local/bin/docker-compose
# Criando link simbolico
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
# Adicionando usuario ubuntu ao grupo docker
sudo usermod -aG docker ubuntu
sudo usermod -aG docker ubuntu
# Executando arquivo docker-compose.yml
sudo chmod -R 777 /mnt/wordpress
docker-compose -f /home/ubuntu/docker-compose.yml up -d
#Copiando o log do user-data para debug, caso necessario
sudo cp /var/log/user-data.log /home/ubuntu/user-data.log