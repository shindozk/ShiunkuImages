#!/bin/bash
set -e

# Exibe a versão do Node.js
node -v

# Se não existir package.json, cria um novo
if [ ! -f package.json ]; then
  echo "package.json não encontrado, criando..."
  npm init -y --no-fund --no-audit
fi

# Instala as dependências declaradas no package.json
echo "Instalando dependências declaradas..."
npm install --no-fund --no-audit

# Procura por módulos requeridos em todos os arquivos .js do container
echo "Procurando por dependências nos arquivos .js..."
modules=$(find . -type f -name "*.js" -exec grep -hoE "require\(['\"][^'\"]+['\"]\)" {} \; | sed -E "s/require\(['\"]([^'\"]+)['\"]\)/\1/" | sort -u)
echo "Módulos encontrados: $modules"

# Para cada módulo encontrado, se não for caminho relativo ou módulo nativo, instala-o se não estiver no package.json
for mod in $modules; do
  # Ignora caminhos relativos
  if [[ "$mod" == .* || "$mod" == /* ]]; then
    continue
  fi
  # Ignora módulos nativos
  case "$mod" in
    fs|path|http|https|url|util|os|crypto|buffer|stream|process|events|child_process|net|dns)
      continue
      ;;
  esac
  # Se o módulo não consta no package.json, instala-o
  if ! grep -q "\"$mod\"" package.json; then
    echo "Instalando dependência faltante: $mod"
    npm install "$mod" --no-fund --no-audit
  else
    echo "Módulo $mod já está presente."
  fi
done

# Inicia a aplicação
echo "Iniciando a aplicação..."
node .
