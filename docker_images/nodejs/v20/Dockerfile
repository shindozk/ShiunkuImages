# Use a imagem slim do Node.js 20, ajustada para a arquitetura de destino
FROM --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

# Atualiza e instala dependências necessárias
RUN apt update \
    && apt -y install --no-install-recommends \
       ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates \
       dnsutils tzdata zip tar curl build-essential libtool \
    && rm -rf /var/lib/apt/lists/*

# Atualiza o npm para a versão mais recente
RUN npm install npm@latest -g

# Define o diretório de trabalho
WORKDIR /home/container

# Adiciona o script de inicialização diretamente no Dockerfile
RUN echo '#!/bin/bash \n\
# Exibe a versão do Node.js \n\
node -v \n\
# Mostra o comando START configurado pelo usuário \n\
echo ":/home/container$ ${START}" \n\
# Substitui e executa o comando START \n\
eval ${START}' > /entrypoint.sh && chmod +x /entrypoint.sh

# Define o comando padrão para o container
CMD ["sh", "/entrypoint.sh"]
