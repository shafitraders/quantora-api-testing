#!/bin/bash

# Quantora SSH Setup Launcher
# Simple launcher for the comprehensive SSH setup script

echo "🚀 Quantora SSH Setup Launcher"
echo "═══════════════════════════════"

# Check if we're in the right directory
if [ ! -f "scripts/setup_ssh.sh" ]; then
    echo "❌ Error: setup_ssh.sh not found in scripts/ directory"
    echo "Please run this from the quantora-systems root directory"
    exit 1
fi

# Check if script is executable
if [ ! -x "scripts/setup_ssh.sh" ]; then
    echo "🔧 Making SSH setup script executable..."
    chmod +x scripts/setup_ssh.sh
fi

echo "✅ Starting SSH setup for your 3-Mac ecosystem..."
echo "This will require sudo permissions for SSH configuration."
echo

# Run the SSH setup script
./scripts/setup_ssh.sh

echo
echo "🎯 SSH setup completed!"
echo "Run this script on all 3 Macs in your ecosystem for full connectivity." 