#!/bin/bash
# Quantora Development Beast - Elegant Shutdown
# "Quality over quantity" - Steve Jobs

echo "🛑 Gracefully shutting down Quantora Development Beast..."

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# Stop Docker services if available
if [ -f "infrastructure/docker-compose.yml" ]; then
    echo "Stopping Docker services..."
    cd infrastructure && docker-compose down && cd ..
elif [ -f "docker-compose.yml" ]; then
    echo "Stopping Docker services..."
    docker-compose down
fi

# Stop frontend gracefully
echo "Stopping frontend..."
pkill -f "npm.*start" 2>/dev/null || true
pkill -f "react-scripts" 2>/dev/null || true
pkill -f "next.*dev" 2>/dev/null || true
pkill -f "vite" 2>/dev/null || true

# Stop backend
echo "Stopping backend..."
pkill -f "uvicorn" 2>/dev/null || true
pkill -f "flask" 2>/dev/null || true

# Clean ports
for port in 3000 3001 8000 8001; do
    lsof -ti:$port | xargs kill -9 2>/dev/null || true
done

echo "✅ Quantora Development Beast shutdown complete"
echo "💫 'Innovation distinguishes between a leader and a follower'"
