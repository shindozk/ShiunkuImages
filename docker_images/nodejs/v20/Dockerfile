# Use a imagem slim do Node.js 20, ajustada para a arquitetura de destino
FROM --platform=$TARGETOS/$TARGETARCH node:20-bullseye-slim

# Atualiza e instala dependências necessárias do sistema
RUN apt update \
    && apt -y install ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool

# Atualiza o npm para a versão mais recente
RUN npm install npm@latest -g

# Define o diretório de trabalho
WORKDIR /app/data

# Adiciona o script de inicialização com verificação e instalação de dependências
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Exibe a versão do Node.js\n\
node -v\n\
\n\
# Se package.json não existir, inicializa um novo\n\
if [ ! -f package.json ]; then\n\
    echo "package.json não encontrado, inicializando..."\n\
    npm init -y --no-fund --no-audit\n\
fi\n\
\n\
# Instala dependências declaradas\n\
echo "Instalando dependências declaradas..."\n\
npm install --no-fund --no-audit\n\
\n\
# Procura por módulos requeridos nos arquivos .js e instala os que estiverem faltando\n\
echo "Procurando por dependências faltantes..."\n\
modules=$(grep -rhoP "require\\([\\'\"][^\\'\"]+[\\'\"]\\)" . \\\n\
    | sed -E "s/require\\([\\'\"]([^\\'\"]+)[\\'\"]\\)/\\1/" \\\n\
    | grep -vE "^(\\./|fs|path|http|https|url|util|os|crypto|buffer|stream|process|events)$" \\\n\
    | sort -u)\n\
echo "Módulos detectados: $modules"\n\
\n\
for mod in $modules; do\n\
    if ! grep -q \"\\\"$mod\\\":\" package.json; then\n\
        echo "Instalando dependência faltante: $mod"\n\
        npm install \"$mod\" --no-fund --no-audit\n\
    fi\n\
done\n\
\n\
# Inicia a aplicação\n\
echo "Iniciando a aplicação..."\n\
node .' > /entrypoint.sh && chmod +x /entrypoint.sh

# Define o comando padrão para o container
CMD ["sh", "/entrypoint.sh"]
