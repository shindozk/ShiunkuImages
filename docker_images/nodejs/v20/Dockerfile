# Use a versão slim do Node.js 20, ajustada para a arquitetura de destino
FROM --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

# Atualiza o sistema e instala dependências necessárias
RUN apt update \
    && apt -y install --no-install-recommends \
       ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates \
       dnsutils tzdata zip tar curl build-essential libtool \
    && rm -rf /var/lib/apt/lists/*

# Atualiza o npm para a versão mais recente
RUN npm install npm@latest -g

# Cria o usuário "container" para rodar o bot
RUN useradd -m -d /home/container -s /bin/bash container

# Define o diretório de trabalho
WORKDIR /home/container

# Ajusta permissões do diretório
RUN chown -R container:container /home/container && chmod -R 755 /home/container

# Alterna para o usuário não-root
USER container

# Exibe a versão do Node e prepara o ambiente para executar o comando START
ENTRYPOINT ["/bin/bash", "-c"]

CMD [ \
    "node -v && \
     echo \":/home/container$ ${START}\" && \
     eval ${START}" \
]
