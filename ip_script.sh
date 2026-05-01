#!/bin/bash

# Hardcoded file path
FILE="/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml"

# Check if file exists
if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

# Get PUBLIC IP (fallback-safe)
CURRENT_IP=$(curl -s ifconfig.me || curl -s https://api.ipify.org)

# Validate IP
if [[ ! $CURRENT_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ Failed to fetch public IP"
  exit 1
fi

# Backup original file
cp "$FILE" "$FILE.bak"

# Replace IP in jenkinsUrl
sed -i -E "s|(http://)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+(:[0-9]+/)|\1${CURRENT_IP}\2|g" "$FILE"

echo "✅ Jenkins URL updated to: http://$CURRENT_IP"
echo "📁 Backup created: $FILE.bak"
