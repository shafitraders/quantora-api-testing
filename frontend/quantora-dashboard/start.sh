#!/bin/bash

# 🚀 QUANTORA DASHBOARD STARTUP SCRIPT
# "Design is not just what it looks like - design is how it works" - Steve Jobs

echo "🚀 Starting Quantora Dashboard..."

# Function to find available port
find_available_port() {
    local base_port=$1
    local max_attempts=10
    
    for ((i=0; i<$max_attempts; i++)); do
        local test_port=$((base_port + i))
        if ! nc -z localhost $test_port >/dev/null 2>&1; then
            echo $test_port
            return
        fi
    done
    
    echo "No available port found starting from $base_port"
    exit 1
}

# Find available port
PORT=$(find_available_port 3000)
echo "✅ Using port: $PORT"

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Start the development server
echo "🌟 Starting development server on port $PORT..."
PORT=$PORT npm start 