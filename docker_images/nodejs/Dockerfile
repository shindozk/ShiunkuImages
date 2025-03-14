# Utiliza a imagem oficial Node.js LTS
FROM node:lts

# Atualiza e instala dependências do sistema
RUN apt update && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool

# Atualiza o npm para a versão mais recente
RUN npm install npm@latest -g

# Define o diretório de trabalho
WORKDIR /app/data

# Baixa o entrypoint do seu repositório GitHub e o torna executável
# Substitua a URL abaixo pela URL real do seu entrypoint.sh
RUN curl -fsSL "https://raw.githubusercontent.com/shindozk/ShiunkuImages/main/docker_images/nodejs/entrypoint.sh" -o /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Define o comando padrão para o container
CMD ["/bin/bash", "/entrypoint.sh"]
