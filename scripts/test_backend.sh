#!/bin/bash
# Test Backend
echo "⚙️  Testing Backend..."
cd ~/quantora-development-beast/backend

# Check for Python virtual environment
if [ -d "venv" ]; then
    echo "🐍 Activating virtual environment..."
    source venv/bin/activate
elif [ -d "../venv" ]; then
    echo "🐍 Activating parent virtual environment..."
    source ../venv/bin/activate
fi

# Install requirements if available
if [ -f "requirements.txt" ]; then
    echo "📦 Installing Python dependencies..."
    pip install -r requirements.txt
fi

# Try to identify and run the main backend file
for main_file in main.py app.py server.py; do
    if [ -f "$main_file" ]; then
        echo "🚀 Starting backend with $main_file..."
        python "$main_file" &
        BACKEND_PID=$!
        
        echo "⏳ Waiting for backend to start..."
        sleep 5
        
        # Check if backend is running
        for port in 8000 8001 5000; do
            if curl -s http://localhost:$port > /dev/null 2>&1; then
                echo "✅ Backend is running on http://localhost:$port"
                break
            fi
        done
        
        # Kill the backend process
        kill $BACKEND_PID 2>/dev/null
        break
    fi
done
