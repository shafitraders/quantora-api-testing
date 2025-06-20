#!/bin/bash

# 🚀 SMART QUANTORA STARTUP SCRIPT
# Automatically finds available ports and starts services

echo "🚀 Starting Quantora with Smart Port Detection..."

# Function to find available port
find_available_port() {
    local base_port=$1
    local max_attempts=10
    
    for ((i=0; i<$max_attempts; i++)); do
        local test_port=$((base_port + i))
        if ! lsof -ti:$test_port >/dev/null 2>&1; then
            echo $test_port
            return
        fi
    done
    
    echo "No available port found starting from $base_port"
    exit 1
}

# Find available ports
FRONTEND_PORT=$(find_available_port 3000)
BACKEND_PORT=$(find_available_port 8000)

echo "✅ Using Frontend Port: $FRONTEND_PORT"
echo "✅ Using Backend Port: $BACKEND_PORT"

# Export environment variables
export QUANTORA_FRONTEND_PORT=$FRONTEND_PORT
export QUANTORA_BACKEND_PORT=$BACKEND_PORT
export REACT_APP_API_BASE_URL="http://localhost:$BACKEND_PORT"

# Update package.json scripts with dynamic ports
if [ -f "package.json" ]; then
    # Create a temporary package.json with correct ports
    cat package.json | \
    sed "s/3000/$FRONTEND_PORT/g" | \
    sed "s/8000/$BACKEND_PORT/g" > package.json.tmp
    mv package.json.tmp package.json
fi

echo "🌟 Starting Quantora Services..."
echo "   📊 Frontend will be at: http://localhost:$FRONTEND_PORT"
echo "   ⚡ Backend will be at: http://localhost:$BACKEND_PORT"

# Start based on what's available
if [ -f "docker-compose.yml" ]; then
    echo "🐳 Starting with Docker Compose..."
    FRONTEND_PORT=$FRONTEND_PORT BACKEND_PORT=$BACKEND_PORT docker-compose up
elif [ -d "frontend" ] && [ -f "frontend/package.json" ]; then
    echo "📱 Starting Frontend Development Server..."
    cd frontend
    PORT=$FRONTEND_PORT npm start
else
    echo "❌ No valid Quantora project structure found"
    echo "Please run this script from the Quantora project root directory"
    exit 1
fi
