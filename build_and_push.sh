#!/bin/bash

# Docker Hub repository details
DOCKER_HUB_USERNAME="shindozk"
REPO_NAME="shiunku-images"

# Base path for images
BASE_PATH="./docker_images"

# Function to build and push an image
build_and_push() {
    local path="$1"    # This should be a directory containing the Dockerfile
    local tag="$2"

    echo "📦 Building image: $tag from $path"
    # If your Dockerfile is not in the root of the directory, specify its path using -f
    docker build -f "$path/Dockerfile" -t "$tag" "$path" || exit 1

    echo "🚀 Pushing image: $tag"
    docker push "$tag" || exit 1

    echo "✅ Successfully pushed image: $tag"
}

# Loop through folders and create tags automatically
for language in $(ls "$BASE_PATH"); do
    for version in $(ls "$BASE_PATH/$language"); do
        IMAGE_PATH="$BASE_PATH/$language/$version"
        TAG="$DOCKER_HUB_USERNAME/$REPO_NAME:$language-$version"

        build_and_push "$IMAGE_PATH" "$TAG"
    done
done

echo "🎉 All images have been successfully pushed to Docker Hub!"

# docker build -f ./docker_images/nodejs/Dockerfile -t shindozk/shiunku-images:nodejs-lts ./docker_images/nodejs

# docker push yourusername/yourimage:tag
