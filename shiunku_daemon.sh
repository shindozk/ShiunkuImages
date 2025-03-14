#!/bin/bash

# Shiunku Daemon Installer v0.0.5

# Clone the repository and enter the directory
echo "🚀 Cloning the Shiunku Daemon repository..."
git clone https://github.com/shindozk/ShiunkuDaemon.git && cd ShiunkuDaemon

if [ $? -ne 0 ]; then
  echo "❌ Failed to clone or change directory to ShiunkuDaemon."
  exit 1
fi

# Install Node.js dependencies
echo "📦 Installing dependencies..."
npm install

# Prompt the user for the daemon configuration command
echo -e "\n🔧 To configure the daemon, go to the panel, create a Node, and copy the command from the 'Configure' option."
read -rp "📋 Paste the configuration command here and press Enter: " daemon_config_cmd

# Run the configuration command if provided
if [ -n "$daemon_config_cmd" ]; then
  echo "⚙️ Running configuration command..."
  eval "$daemon_config_cmd" || { echo "❌ Failed to configure the daemon."; exit 1; }
else
  echo "⏩ No configuration command provided. Skipping..."
fi

# Start the daemon
echo "🚀 Starting Shiunku Daemon..."
node .

echo "✅ Shiunku Daemon is now running!"
