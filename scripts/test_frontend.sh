#!/bin/bash
# Test Frontend
echo "🎨 Testing Frontend..."
cd ~/quantora-development-beast/frontend

if [ -f "package.json" ]; then
    echo "📦 Installing dependencies..."
    npm install
    
    echo "🚀 Starting frontend in background..."
    npm start &
    FRONTEND_PID=$!
    
    echo "⏳ Waiting for frontend to start..."
    sleep 10
    
    # Check if frontend is running
    if curl -s http://localhost:3000 > /dev/null 2>&1; then
        echo "✅ Frontend is running on http://localhost:3000"
    elif curl -s http://localhost:3001 > /dev/null 2>&1; then
        echo "✅ Frontend is running on http://localhost:3001"
    else
        echo "❌ Frontend not responding"
    fi
    
    # Kill the frontend process
    kill $FRONTEND_PID 2>/dev/null
else
    echo "❌ No package.json found in frontend"
fi
