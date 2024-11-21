#!/bin/bash

# Nome do repositório no Docker Hub
DOCKER_HUB_USERNAME="shindozk"
REPO_NAME="skyport-shiunku-images"

# Caminho base das imagens
BASE_PATH="./docker_images"

# Função para construir e fazer push de uma imagem
build_and_push() {
    local path="$1"
    local tag="$2"

    echo "📦 Construindo a imagem: $tag a partir de $path"
    docker build -t "$tag" "$path" || exit 1

    echo "🚀 Fazendo push da imagem: $tag"
    docker push "$tag" || exit 1

    echo "✅ Imagem registrada com sucesso: $tag"
}

# Loop pelas pastas e cria tags automaticamente
for language in $(ls "$BASE_PATH"); do
    for version in $(ls "$BASE_PATH/$language"); do
        IMAGE_PATH="$BASE_PATH/$language/$version"
        TAG="$DOCKER_HUB_USERNAME/$REPO_NAME:$language-$version"

        build_and_push "$IMAGE_PATH" "$TAG"
    done
done

echo "🎉 Todas as imagens foram registradas no Docker Hub com sucesso!"
