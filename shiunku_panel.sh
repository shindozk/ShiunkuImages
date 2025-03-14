#!/bin/bash

Shiunku Panel Installer v0.0.5

# Clone the repository and navigate into it
echo "🚀 Cloning the Shiunku Panel repository..."
git clone https://github.com/shindozk/Shiunku.git && cd Shiunku

if [ $? -ne 0 ]; then
  echo "❌ Failed to clone or change directory to Shiunku."
  exit 1
fi

# Install Node.js dependencies
echo "📦 Installing dependencies..."
npm install

# Seed the database
echo "🌱 Seeding the database..."
npm run seed

# Create an administrator user
echo "👤 Creating an administrator user..."
npm run createUser

# Start the Shiunku Panel
echo "🚀 Starting Shiunku Panel..."
node .

echo "✅ Shiunku Panel is now running!"
