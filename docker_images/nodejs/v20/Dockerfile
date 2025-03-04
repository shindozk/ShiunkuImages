# Use a imagem slim do Node.js 20, ajustada para a arquitetura de destino
FROM --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

# Atualiza e instala dependências do sistema
RUN apt update && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool

# Atualiza o npm para a versão mais recente
RUN npm install npm@latest -g

# Define o diretório de trabalho
WORKDIR /app/data

# Baixa o script de entrypoint do seu repositório GitHub (substitua a URL abaixo pela URL correta)
RUN curl -o /entrypoint.sh https://raw.githubusercontent.com/shindozk/skyport-shiunku-images/main/docker_images/nodejs/v20/entrypoint.sh && chmod +x /entrypoint.sh

# Define o comando padrão para o container
CMD ["/bin/bash", "/entrypoint.sh"]
