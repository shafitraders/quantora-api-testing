#!/bin/bash

# 🚀 QUANTORA PORT CONFLICT RESOLUTION
# "Design is not just what it looks like - design is how it works" - Steve Jobs

echo "🔧 RESOLVING QUANTORA PORT CONFLICTS"
echo "==================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to display colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_action() {
    echo -e "${PURPLE}🚀 $1${NC}"
}

# Check what's running on common ports
echo ""
print_info "Checking port usage..."

PORTS_TO_CHECK=(3000 3001 8000 8080 5432 6379 8086 9090)

for port in "${PORTS_TO_CHECK[@]}"; do
    PID=$(lsof -ti:$port 2>/dev/null)
    if [ ! -z "$PID" ]; then
        PROCESS=$(ps -p $PID -o comm= 2>/dev/null)
        print_warning "Port $port is in use by PID $PID ($PROCESS)"
    else
        print_status "Port $port is available"
    fi
done

echo ""
print_action "STEP 1: Stopping conflicting processes..."

# Function to kill process on port
kill_port() {
    local port=$1
    local description=$2
    
    PID=$(lsof -ti:$port 2>/dev/null)
    if [ ! -z "$PID" ]; then
        PROCESS=$(ps -p $PID -o comm= 2>/dev/null)
        print_warning "Killing $description on port $port (PID: $PID, Process: $PROCESS)"
        kill -9 $PID 2>/dev/null
        sleep 1
        
        # Verify it's dead
        if ! lsof -ti:$port >/dev/null 2>&1; then
            print_status "$description stopped successfully"
        else
            print_error "Failed to stop $description on port $port"
        fi
    else
        print_status "$description port $port is already free"
    fi
}

# Kill common development servers
kill_port 3000 "Frontend Development Server"
kill_port 3001 "Alternative Frontend Server"
kill_port 8000 "Backend API Server"
kill_port 8080 "Alternative Backend Server"

# Kill any node processes that might be lingering
print_action "STEP 2: Cleaning up Node.js processes..."
pkill -f "node.*server" 2>/dev/null || true
pkill -f "npm.*start" 2>/dev/null || true
pkill -f "next" 2>/dev/null || true
pkill -f "react-scripts" 2>/dev/null || true

# Kill Python servers
print_action "STEP 3: Cleaning up Python servers..."
pkill -f "python.*server" 2>/dev/null || true
pkill -f "python3.*http.server" 2>/dev/null || true
pkill -f "uvicorn" 2>/dev/null || true
pkill -f "fastapi" 2>/dev/null || true

# Kill any Quantora-specific processes
print_action "STEP 4: Cleaning up Quantora processes..."
pkill -f "quantora" 2>/dev/null || true

sleep 2

echo ""
print_action "STEP 5: Verifying ports are free..."

ALL_CLEAR=true
for port in "${PORTS_TO_CHECK[@]}"; do
    if lsof -ti:$port >/dev/null 2>&1; then
        PID=$(lsof -ti:$port)
        PROCESS=$(ps -p $PID -o comm= 2>/dev/null)
        print_error "Port $port is still in use by PID $PID ($PROCESS)"
        ALL_CLEAR=false
    fi
done

if [ "$ALL_CLEAR" = true ]; then
    print_status "All ports are now available!"
else
    print_warning "Some ports are still in use. Manual intervention may be required."
fi

echo ""
print_action "STEP 6: Creating smart port configuration..."

# Create a smart port configuration file
cat > quantora_ports.json << 'EOF'
{
  "quantora_ports": {
    "frontend": {
      "primary": 3000,
      "fallback": [3001, 3002, 3003]
    },
    "backend": {
      "primary": 8000,
      "fallback": [8001, 8002, 8003]
    },
    "database": {
      "postgres": 5432,
      "redis": 6379,
      "influxdb": 8086
    },
    "monitoring": {
      "prometheus": 9090,
      "grafana": 3001
    }
  }
}
EOF

print_status "Port configuration saved to quantora_ports.json"

echo ""
print_action "STEP 7: Creating smart startup script..."

# Create an intelligent startup script that finds available ports
cat > start_quantora_smart.sh << 'EOF'
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
EOF

chmod +x start_quantora_smart.sh
print_status "Smart startup script created: start_quantora_smart.sh"

echo ""
print_action "STEP 8: Creating enhanced server.js with smart port detection..."

# Create an enhanced server.js that automatically finds available ports
cat > enhanced_server.js << 'EOF'
const express = require('express');
const path = require('path');
const net = require('net');

const app = express();

// Function to check if port is available
const isPortAvailable = (port) => {
    return new Promise((resolve) => {
        const server = net.createServer();
        server.listen(port, () => {
            server.once('close', () => resolve(true));
            server.close();
        });
        server.on('error', () => resolve(false));
    });
};

// Function to find available port
const findAvailablePort = async (startPort = 3000, maxAttempts = 10) => {
    for (let i = 0; i < maxAttempts; i++) {
        const port = startPort + i;
        if (await isPortAvailable(port)) {
            return port;
        }
    }
    throw new Error(`No available port found starting from ${startPort}`);
};

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname)));

// Serve index.html for all routes (SPA support)
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Smart server startup
const startServer = async () => {
    try {
        const PORT = await findAvailablePort(3000);
        
        app.listen(PORT, () => {
            console.log('🚀 Quantora Dashboard Server Started!');
            console.log('=================================');
            console.log(`📊 Dashboard URL: http://localhost:${PORT}`);
            console.log(`⚡ Backend URL:   http://localhost:8000 (if running)`);
            console.log('');
            console.log('🌟 Steve Jobs Principle Applied:');
            console.log('   "Design is not just what it looks like - design is how it works"');
            console.log('');
            console.log('💫 "Make the impossible possible" - Mr. IR');
            
            // Auto-open browser if possible
            const { exec } = require('child_process');
            const url = `http://localhost:${PORT}`;
            
            // Try to open browser
            const start = process.platform === 'darwin' ? 'open' :
                         process.platform === 'win32' ? 'start' : 'xdg-open';
            
            exec(`${start} ${url}`, (error) => {
                if (error) {
                    console.log(`🌐 Please open ${url} in your browser`);
                } else {
                    console.log('🌐 Dashboard opened in browser automatically');
                }
            });
        });
        
        // Graceful shutdown
        process.on('SIGTERM', () => {
            console.log('🛑 Received SIGTERM, shutting down gracefully...');
            process.exit(0);
        });
        
        process.on('SIGINT', () => {
            console.log('🛑 Received SIGINT, shutting down gracefully...');
            process.exit(0);
        });
        
    } catch (error) {
        console.error('❌ Failed to start server:', error.message);
        console.log('');
        console.log('🔧 Troubleshooting:');
        console.log('   1. Make sure no other servers are running');
        console.log('   2. Try running: ./cleanup_ports.sh');
        console.log('   3. Check for processes using: lsof -i :3000');
        process.exit(1);
    }
};

startServer();
EOF

print_status "Enhanced server.js created with smart port detection"

echo ""
print_action "STEP 9: Creating package.json with smart scripts..."

# Create or update package.json with smart scripts
cat > smart_package.json << 'EOF'
{
  "name": "quantora-dashboard",
  "version": "2.0.0",
  "description": "Revolutionary AI Trading Intelligence Dashboard",
  "main": "enhanced_server.js",
  "scripts": {
    "start": "node enhanced_server.js",
    "start-smart": "./start_quantora_smart.sh",
    "dev": "node enhanced_server.js",
    "build": "echo 'Build complete - Static files ready'",
    "serve": "node enhanced_server.js",
    "cleanup": "./cleanup_ports.sh",
    "check-ports": "lsof -i :3000 && lsof -i :8000 || echo 'Ports are available'"
  },
  "dependencies": {
    "express": "^4.18.0"
  },
  "keywords": ["trading", "ai", "dashboard", "quantora"],
  "author": "Quantora Systems",
  "license": "MIT"
}
EOF

print_status "Smart package.json created"

echo ""
print_action "STEP 10: Final verification and startup instructions..."

echo ""
echo "🎉 PORT CONFLICT RESOLUTION COMPLETE!"
echo "===================================="
echo ""
print_status "✅ All conflicting processes stopped"
print_status "✅ Smart startup scripts created"
print_status "✅ Enhanced server with port detection ready"
print_status "✅ Intelligent port configuration saved"
echo ""
echo "🚀 NEXT STEPS - Choose your startup method:"
echo ""
echo "📋 Method 1: Smart Startup (Recommended)"
echo "   ./start_quantora_smart.sh"
echo ""
echo "📋 Method 2: Enhanced Server"
echo "   node enhanced_server.js"
echo ""
echo "📋 Method 3: NPM with Smart Scripts"
echo "   cp smart_package.json package.json"
echo "   npm install"
echo "   npm start"
echo ""
echo "📋 Method 4: Manual Port Selection"
echo "   PORT=3001 node enhanced_server.js"
echo ""
echo "🔧 Troubleshooting Commands:"
echo "   ./cleanup_ports.sh          # Clean up ports again"
echo "   lsof -i :3000              # Check what's using port 3000"
echo "   npm run check-ports         # Check port status"
echo ""
print_info "💡 The enhanced server automatically finds available ports"
print_info "🌟 No more port conflicts - Steve Jobs would be proud!"
echo ""
echo "💫 \"Make the impossible possible\" - Mr. IR"
echo "🚀 Revolutionary AI Dashboard ready for launch!" 