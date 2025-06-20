#!/bin/bash
# Quantora Development Beast - System Status
echo "🔍 Quantora Development Beast Status Check"
echo "=========================================="

# Check ports
echo "📡 Port Status:"
for port in 3000 3001 8000 8001; do
    if lsof -ti:$port &> /dev/null; then
        echo "  ✅ Port $port: Active"
    else
        echo "  ❌ Port $port: Inactive"
    fi
done

# Check Docker
if command -v docker &> /dev/null && docker info &> /dev/null; then
    echo "🐳 Docker Status: Available"
    if [ -f "infrastructure/docker-compose.yml" ] || [ -f "docker-compose.yml" ]; then
        echo "📊 Docker Services:"
        docker-compose ps 2>/dev/null || echo "  No services running"
    fi
else
    echo "🐳 Docker Status: Not available"
fi

echo "✨ 'When you do something with pure heart, sincerity and dedication, you create magic'"
