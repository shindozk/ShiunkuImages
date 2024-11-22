# Use a versão slim do Node.js 20, ajustada para a arquitetura de destino
FROM --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

# Instale dependências e limpe o cache
RUN apt update \
    && apt -y install --no-install-recommends \
       ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates \
       dnsutils tzdata zip tar curl build-essential libtool \
    && rm -rf /var/lib/apt/lists/*

# Atualize o npm para a última versão
RUN npm install npm@latest -g

# Crie o usuário "container" para rodar a aplicação
RUN useradd -m -d /home/container -s /bin/bash container

# Ajuste permissões do diretório de trabalho
WORKDIR /app/data
RUN chown -R container:container /app/data && chmod -R 755 /app/data

# Altere para o usuário "container"
USER container

# Comando padrão para executar o container
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["${START:-echo 'No START command provided!'}"]
