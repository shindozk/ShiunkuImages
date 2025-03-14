#!/bin/bash
set -e

# Display the Node.js version
echo "Node Version:"
node -v

# If package.json is not found, create a new one
if [ ! -f package.json ]; then
  echo "package.json not found, initializing..."
  npm init -y --no-fund --no-audit
fi

# Install the declared dependencies
echo "Installing declared dependencies..."
npm install --no-fund --no-audit

# Loop to attempt starting the application and handle missing dependency errors
while true; do
  echo "Attempting to start the application..."
  # Run the application and redirect output to a temporary log while displaying it on screen
  node . 2>&1 | tee /tmp/node.log
  status=${PIPESTATUS[0]}

  # If the application exited successfully, break the loop
  if [ $status -eq 0 ]; then
    echo "Application started successfully."
    exit 0
  fi

  # Check if there is an error for a missing module
  if grep -q "Cannot find module" /tmp/node.log; then
    # Extract the name of the missing module (only the first one found)
    missing=$(grep -oP "Cannot find module '\\K[^']+" /tmp/node.log | head -n 1)
    if [ -n "$missing" ]; then
      echo "Missing dependency detected: $missing. Installing..."
      npm install "$missing" --no-fund --no-audit
      echo "Restarting the application..."
    else
      echo "Unidentified module error. Check the logs."
      exit 1
    fi
  else
    echo "Unknown error during startup:"
    cat /tmp/node.log
    exit 1
  fi

  # Wait a moment before restarting
  sleep 2
done
