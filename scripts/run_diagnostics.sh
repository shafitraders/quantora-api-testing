#!/bin/bash

# Quantora Thunderbolt Diagnostics Launcher
# Quick launcher for network diagnostics

echo "🚀 Launching Quantora Thunderbolt 5 Network Diagnostics..."
echo "═══════════════════════════════════════════════════════════"
echo

# Check if we're in the right directory
if [ ! -f "scripts/thunderbolt_diagnostics.sh" ]; then
    echo "❌ Error: thunderbolt_diagnostics.sh not found!"
    echo "   Make sure you're running this from the quantora-systems root directory"
    exit 1
fi

# Run the diagnostics
./scripts/thunderbolt_diagnostics.sh

echo
echo "🎯 Diagnostics completed! Check the results above."
echo "💡 Tip: Run this script on each Mac to compare network health." 