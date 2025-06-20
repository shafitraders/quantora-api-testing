#!/bin/bash
# 🚀 QUANTORA DEVELOPMENT BEAST - ELEGANT STARTUP SYSTEM
# "Innovation distinguishes between a leader and a follower" - Steve Jobs
# Optimized for quantora-development-beast elegant structure

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# ============= ELEGANT STRUCTURE VALIDATION =============

# Ensure we're in the correct directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Validate we're in quantora-development-beast
if [[ ! "$(basename "$PROJECT_ROOT")" == "quantora-development-beast" ]]; then
    echo -e "${RED}❌ This script must be run from quantora-development-beast directory${NC}"
    echo -e "${YELLOW}Current location: $PROJECT_ROOT${NC}"
    echo -e "${YELLOW}Expected: ~/quantora-development-beast${NC}"
    exit 1
fi

cd "$PROJECT_ROOT"

# Detect current Mac (enhanced detection)
CURRENT_MAC_IP=$(ifconfig | grep "inet 192.168.1." | grep -v "127.0.0.1" | awk '{print $2}' | head -1)
if [[ "$CURRENT_MAC_IP" == "192.168.1.1" ]]; then
    MAC_IDENTITY="Mac 1 - Development Beast"
    MAC_ROLE="Frontend + Backend + Integration"
elif [[ "$CURRENT_MAC_IP" == "192.168.1.2" ]]; then
    MAC_IDENTITY="Mac 2 - AI Powerhouse"
    MAC_ROLE="AI Engines + Pattern Discovery"
elif [[ "$CURRENT_MAC_IP" == "192.168.1.3" ]]; then
    MAC_IDENTITY="Mac 3 - Production Mirror"
    MAC_ROLE="Validation + Risk Management"
else
    MAC_IDENTITY="Standalone Development"
    MAC_ROLE="Single Mac Mode"
fi

echo -e "${PURPLE}"
cat << "EOF"
 ██████  ██    ██  █████  ███    ██ ████████  ██████  ██████   █████  
██    ██ ██    ██ ██   ██ ████   ██    ██    ██    ██ ██   ██ ██   ██ 
██    ██ ██    ██ ███████ ██ ██  ██    ██    ██    ██ ██████  ███████ 
██ ▄▄ ██ ██    ██ ██   ██ ██  ██ ██    ██    ██    ██ ██   ██ ██   ██ 
 ██████   ██████  ██   ██ ██   ████    ██     ██████  ██   ██ ██   ██ 
    ▀▀                                                                 
EOF
echo -e "${NC}"

echo -e "${CYAN}🚀 QUANTORA DEVELOPMENT BEAST - ELEGANT ARCHITECTURE${NC}"
echo -e "${CYAN}\"Make the impossible possible\" - Revolutionary AI Trading Intelligence${NC}"
echo -e "${YELLOW}🖥️  Current System: $MAC_IDENTITY${NC}"
echo -e "${YELLOW}⚡ Role: $MAC_ROLE${NC}"
echo -e "${BLUE}📁 Project Root: $PROJECT_ROOT${NC}"
echo "=================================================================="

# ============= ELEGANT STRUCTURE VALIDATION =============

echo -e "\n${BLUE}📁 Step 1: Elegant Structure Validation${NC}"
echo "----------------------------------------"

# Validate our beautiful new structure
STRUCTURE_VALID=true
REQUIRED_DIRS=("frontend" "backend" "database" "scripts" "tools" "documentation" "tests" "infrastructure")

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}✅ $dir${NC} - Present and elegant"
    else
        echo -e "${RED}❌ $dir${NC} - Missing from elegant structure"
        STRUCTURE_VALID=false
    fi
done

if [[ "$STRUCTURE_VALID" == false ]]; then
    echo -e "${RED}❌ Elegant structure validation failed${NC}"
    echo -e "${YELLOW}Please ensure you're in the correct quantora-development-beast directory${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Elegant structure validated successfully${NC}"

# ============= FRONTEND PATH INTELLIGENCE =============

echo -e "\n${BLUE}🎨 Step 2: Frontend Discovery & Validation${NC}"
echo "----------------------------------------"

# Intelligent frontend detection for our elegant structure
REACT_FRONTEND_PATH=""
FRONTEND_FOUND=false

# Priority 1: Check for React dashboard in frontend directory
if [ -d "frontend/quantora-dashboard" ]; then
    REACT_FRONTEND_PATH="frontend/quantora-dashboard"
    if [ -f "$REACT_FRONTEND_PATH/package.json" ] && grep -q "react" "$REACT_FRONTEND_PATH/package.json"; then
        echo -e "${GREEN}✅ Found React frontend: $REACT_FRONTEND_PATH${NC}"
        FRONTEND_FOUND=true
    fi
fi

# Priority 2: Check for any React project in frontend directory
if [[ "$FRONTEND_FOUND" == false ]]; then
    for subdir in frontend/*/; do
        if [ -f "${subdir}package.json" ] && grep -q "react" "${subdir}package.json"; then
            REACT_FRONTEND_PATH="${subdir%/}"
            echo -e "${GREEN}✅ Found React frontend: $REACT_FRONTEND_PATH${NC}"
            FRONTEND_FOUND=true
            break
        fi
    done
fi

# Priority 3: Check for direct frontend in frontend directory
if [[ "$FRONTEND_FOUND" == false ]]; then
    if [ -f "frontend/package.json" ] && grep -q "react" "frontend/package.json"; then
        REACT_FRONTEND_PATH="frontend"
        echo -e "${GREEN}✅ Found React frontend: $REACT_FRONTEND_PATH${NC}"
        FRONTEND_FOUND=true
    fi
fi

if [[ "$FRONTEND_FOUND" == false ]]; then
    echo -e "${RED}❌ No React frontend found in elegant structure${NC}"
    echo -e "${YELLOW}Please ensure React project exists in frontend/ directory${NC}"
    exit 1
fi

# Validate it's actually a React project
cd "$REACT_FRONTEND_PATH"
if [ -f "package.json" ] && grep -q "react" package.json; then
    echo -e "${GREEN}✅ Confirmed: React/TypeScript project detected${NC}"
    
    # Check for key React dependencies
    if grep -q "react-scripts" package.json; then
        echo -e "${GREEN}✅ React Scripts found - CRA project${NC}"
    elif grep -q "next" package.json; then
        echo -e "${GREEN}✅ Next.js found - Next.js project${NC}"
    elif grep -q "vite" package.json; then
        echo -e "${GREEN}✅ Vite found - Vite project${NC}"
    fi
else
    echo -e "${RED}❌ Invalid React project in $REACT_FRONTEND_PATH${NC}"
    exit 1
fi

cd "$PROJECT_ROOT"

# ============= INTELLIGENT PORT CLEANUP =============

echo -e "\n${BLUE}🔧 Step 3: Intelligent Port Management${NC}"
echo "----------------------------------------"

cleanup_port() {
    local port=$1
    local timeout=3
    
    echo -e "${YELLOW}Checking port $port...${NC}"
    
    PID=$(timeout $timeout lsof -ti:$port 2>/dev/null || echo "")
    
    if [ ! -z "$PID" ] && [ "$PID" != "timeout" ]; then
        echo -e "${YELLOW}  Gracefully stopping process on port $port (PID: $PID)${NC}"
        kill -TERM $PID 2>/dev/null || true
        sleep 1
        
        # Force kill if still running
        if kill -0 $PID 2>/dev/null; then
            kill -9 $PID 2>/dev/null || true
        fi
        echo -e "${GREEN}  ✅ Port $port cleaned${NC}"
    else
        echo -e "${GREEN}  ✅ Port $port already available${NC}"
    fi
}

# Clean essential ports for 3-Mac ecosystem
PORTS=(3000 3001 8000 8001 8002 8003 5432 6379)
for port in "${PORTS[@]}"; do
    cleanup_port $port
done

echo -e "${GREEN}✅ Port management complete${NC}"

# ============= BACKEND INTELLIGENCE =============

echo -e "\n${BLUE}⚙️  Step 4: Backend Services Intelligence${NC}"
echo "----------------------------------------"

# Check for backend configuration
BACKEND_PATH=""
BACKEND_TYPE=""

if [ -d "backend" ]; then
    BACKEND_PATH="backend"
    
    # Detect backend type
    if [ -f "backend/main.py" ]; then
        BACKEND_TYPE="FastAPI"
        echo -e "${GREEN}✅ FastAPI backend detected: backend/main.py${NC}"
    elif [ -f "backend/app.py" ]; then
        BACKEND_TYPE="Flask"
        echo -e "${GREEN}✅ Flask backend detected: backend/app.py${NC}"
    elif [ -f "backend/server.py" ]; then
        BACKEND_TYPE="Custom"
        echo -e "${GREEN}✅ Custom backend detected: backend/server.py${NC}"
    else
        echo -e "${YELLOW}⚠️  Backend directory found but no main file detected${NC}"
    fi
fi

# Check for Docker configuration
USE_DOCKER=false
if [ -f "infrastructure/docker-compose.yml" ]; then
    echo -e "${GREEN}✅ Docker Compose found: infrastructure/docker-compose.yml${NC}"
    
    # Check if Docker is available
    if command -v docker &> /dev/null && docker info &> /dev/null; then
        USE_DOCKER=true
        echo -e "${GREEN}✅ Docker is available and running${NC}"
    else
        echo -e "${YELLOW}⚠️  Docker not available, using native mode${NC}"
    fi
elif [ -f "docker-compose.yml" ]; then
    echo -e "${GREEN}✅ Docker Compose found: ./docker-compose.yml${NC}"
    
    if command -v docker &> /dev/null && docker info &> /dev/null; then
        USE_DOCKER=true
        echo -e "${GREEN}✅ Docker is available and running${NC}"
    else
        echo -e "${YELLOW}⚠️  Docker not available, using native mode${NC}"
    fi
else
    echo -e "${BLUE}ℹ️  No Docker configuration found, using native mode${NC}"
fi

# ============= BACKEND STARTUP =============

start_backend_services() {
    if [[ "$USE_DOCKER" == true ]]; then
        echo -e "${YELLOW}Starting Docker-based backend services...${NC}"
        
        # Use infrastructure directory if available
        if [ -f "infrastructure/docker-compose.yml" ]; then
            cd infrastructure
            docker-compose down &> /dev/null || true
            docker-compose up -d
            cd "$PROJECT_ROOT"
        else
            docker-compose down &> /dev/null || true
            docker-compose up -d
        fi
        
        echo -e "${GREEN}✅ Docker services started${NC}"
        
    elif [[ -n "$BACKEND_PATH" && -n "$BACKEND_TYPE" ]]; then
        echo -e "${YELLOW}Starting native backend services...${NC}"
        
        cd "$BACKEND_PATH"
        
        # Setup Python environment
        if [ ! -d "venv" ]; then
            python3 -m venv venv
        fi
        
        source venv/bin/activate
        
        # Install requirements if available
        if [ -f "requirements.txt" ]; then
            pip install -r requirements.txt
        fi
        
        # Start backend based on type
        case "$BACKEND_TYPE" in
            "FastAPI")
                uvicorn main:app --reload --host 0.0.0.0 --port 8000 &
                BACKEND_PID=$!
                ;;
            "Flask")
                python app.py &
                BACKEND_PID=$!
                ;;
            "Custom")
                python server.py &
                BACKEND_PID=$!
                ;;
        esac
        
        cd "$PROJECT_ROOT"
        echo -e "${GREEN}✅ Native backend started (PID: $BACKEND_PID)${NC}"
    else
        echo -e "${BLUE}ℹ️  No backend configuration found, frontend-only mode${NC}"
    fi
}

start_backend_services

# ============= ELEGANT FRONTEND STARTUP =============

echo -e "\n${BLUE}🎨 Step 5: Revolutionary Frontend Startup${NC}"
echo "-----------------------------------"

start_elegant_frontend() {
    echo -e "${YELLOW}Starting revolutionary React frontend...${NC}"
    echo -e "${BLUE}Frontend path: $REACT_FRONTEND_PATH${NC}"
    
    cd "$REACT_FRONTEND_PATH"
    
    # Install dependencies if needed
    if [ ! -d "node_modules" ]; then
        echo -e "${YELLOW}Installing frontend dependencies...${NC}"
        npm install
        if [ $? -ne 0 ]; then
            echo -e "${RED}❌ Failed to install frontend dependencies${NC}"
            cd "$PROJECT_ROOT"
            return 1
        fi
        echo -e "${GREEN}✅ Dependencies installed${NC}"
    fi
    
    # Set elegant environment variables
    export REACT_APP_BACKEND_URL="http://localhost:8000"
    export REACT_APP_MAC_IDENTITY="$MAC_IDENTITY"
    export REACT_APP_MAC_ROLE="$MAC_ROLE"
    export REACT_APP_ECOSYSTEM_MODE="3MAC"
    export REACT_APP_CURRENT_MAC_IP="$CURRENT_MAC_IP"
    export REACT_APP_PROJECT_NAME="Quantora Development Beast"
    
    # 3-Mac ecosystem configuration
    case "$CURRENT_MAC_IP" in
        "192.168.1.1")
            export REACT_APP_MAC1_URL="http://192.168.1.1:3000"
            export REACT_APP_MAC2_URL="http://192.168.1.2:3000"
            export REACT_APP_MAC3_URL="http://192.168.1.3:3000"
            ;;
        "192.168.1.2")
            export REACT_APP_MAC1_URL="http://192.168.1.1:3000"
            export REACT_APP_MAC2_URL="http://192.168.1.2:3000"
            export REACT_APP_MAC3_URL="http://192.168.1.3:3000"
            ;;
        "192.168.1.3")
            export REACT_APP_MAC1_URL="http://192.168.1.1:3000"
            export REACT_APP_MAC2_URL="http://192.168.1.2:3000"
            export REACT_APP_MAC3_URL="http://192.168.1.3:3000"
            ;;
    esac
    
    echo -e "${BLUE}Environment configured for: $MAC_IDENTITY${NC}"
    
    # Detect and start appropriate server
    if grep -q "react-scripts" package.json; then
        echo -e "${YELLOW}Starting Create React App server...${NC}"
        npm start &
    elif grep -q "next" package.json; then
        echo -e "${YELLOW}Starting Next.js server...${NC}"
        npm run dev &
    elif grep -q "vite" package.json; then
        echo -e "${YELLOW}Starting Vite server...${NC}"
        npm run dev &
    else
        echo -e "${YELLOW}Starting with npm start...${NC}"
        npm start &
    fi
    
    FRONTEND_PID=$!
    cd "$PROJECT_ROOT"
    
    echo -e "${GREEN}✅ Frontend started (PID: $FRONTEND_PID)${NC}"
    return 0
}

if start_elegant_frontend; then
    echo -e "${GREEN}✅ Frontend startup successful${NC}"
else
    echo -e "${RED}❌ Frontend startup failed${NC}"
    exit 1
fi

# ============= STARTUP VALIDATION =============

echo -e "\n${BLUE}🔍 Step 6: System Validation${NC}"
echo "-----------------------------------"

echo -e "${YELLOW}Waiting for services to be ready...${NC}"

# Wait for frontend
FRONTEND_READY=false
for i in {1..30}; do
    for port in 3000 3001; do
        if curl -s http://localhost:$port &> /dev/null; then
            echo -e "${GREEN}✅ Frontend responding on port $port${NC}"
            FRONTEND_PORT=$port
            FRONTEND_READY=true
            break 2
        fi
    done
    sleep 2
    if (( i % 5 == 0 )); then
        echo -e "${YELLOW}Waiting for frontend... ($((i*2))/60 seconds)${NC}"
    fi
done

# Wait for backend
BACKEND_READY=false
if [[ -n "$BACKEND_TYPE" ]] || [[ "$USE_DOCKER" == true ]]; then
    for i in {1..20}; do
        for port in 8000 8001; do
            if curl -s http://localhost:$port &> /dev/null; then
                echo -e "${GREEN}✅ Backend responding on port $port${NC}"
                BACKEND_PORT=$port
                BACKEND_READY=true
                break 2
            fi
        done
        sleep 1
    done
fi

# ============= ELEGANT SUCCESS DISPLAY =============

echo -e "\n${GREEN}🎉 QUANTORA DEVELOPMENT BEAST STARTUP COMPLETE!${NC}"
echo "=================================================================="

if [[ "$FRONTEND_READY" == true ]]; then
    echo -e "${GREEN}✅ Frontend Status: RUNNING${NC}"
    echo -e "${YELLOW}   📍 URL: http://localhost:${FRONTEND_PORT}${NC}"
    echo -e "${BLUE}   📁 Path: $REACT_FRONTEND_PATH${NC}"
else
    echo -e "${RED}❌ Frontend Status: NOT RESPONDING${NC}"
fi

if [[ "$BACKEND_READY" == true ]]; then
    echo -e "${GREEN}✅ Backend Status: RUNNING${NC}"
    echo -e "${YELLOW}   📍 URL: http://localhost:${BACKEND_PORT}${NC}"
    echo -e "${BLUE}   🔧 Type: $BACKEND_TYPE${NC}"
elif [[ "$USE_DOCKER" == true ]]; then
    echo -e "${YELLOW}⚡ Backend Status: DOCKER SERVICES${NC}"
    echo -e "${BLUE}   🐳 Check: docker-compose ps${NC}"
else
    echo -e "${BLUE}ℹ️  Backend Status: FRONTEND-ONLY MODE${NC}"
fi

echo -e "\n${CYAN}🌐 3-Mac Ecosystem Integration:${NC}"
case "$CURRENT_MAC_IP" in
    "192.168.1.1")
        echo -e "${YELLOW}   🖥️  This Mac (Development Beast): http://192.168.1.1:${FRONTEND_PORT:-3000}${NC}"
        echo -e "${BLUE}   🧠 Mac 2 (AI Powerhouse): http://192.168.1.2:3000${NC}"
        echo -e "${PURPLE}   🏭 Mac 3 (Production Mirror): http://192.168.1.3:3000${NC}"
        ;;
    "192.168.1.2")
        echo -e "${YELLOW}   🧠 This Mac (AI Powerhouse): http://192.168.1.2:${FRONTEND_PORT:-3000}${NC}"
        echo -e "${BLUE}   🖥️  Mac 1 (Development Beast): http://192.168.1.1:3000${NC}"
        echo -e "${PURPLE}   🏭 Mac 3 (Production Mirror): http://192.168.1.3:3000${NC}"
        ;;
    "192.168.1.3")
        echo -e "${YELLOW}   🏭 This Mac (Production Mirror): http://192.168.1.3:${FRONTEND_PORT:-3000}${NC}"
        echo -e "${BLUE}   🖥️  Mac 1 (Development Beast): http://192.168.1.1:3000${NC}"
        echo -e "${PURPLE}   🧠 Mac 2 (AI Powerhouse): http://192.168.1.2:3000${NC}"
        ;;
    *)
        echo -e "${YELLOW}   🖥️  Standalone Mode: http://localhost:${FRONTEND_PORT:-3000}${NC}"
        ;;
esac

# ============= ELEGANT MANAGEMENT SCRIPTS =============

# Create elegant stop script
cat > scripts/stop_quantora.sh << 'EOF'
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
EOF

chmod +x scripts/stop_quantora.sh

# Create system status script
cat > scripts/status_quantora.sh << 'EOF'
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
EOF

chmod +x scripts/status_quantora.sh

echo -e "\n${GREEN}📜 Management Scripts Created:${NC}"
echo -e "${YELLOW}   🛑 Stop: ./scripts/stop_quantora.sh${NC}"
echo -e "${YELLOW}   📊 Status: ./scripts/status_quantora.sh${NC}"

# Open browser
if [[ "$FRONTEND_READY" == true ]] && command -v open &> /dev/null; then
    sleep 2
    case "$CURRENT_MAC_IP" in
        "192.168.1.1"|"192.168.1.2"|"192.168.1.3")
            open "http://$CURRENT_MAC_IP:${FRONTEND_PORT}"
            ;;
        *)
            open "http://localhost:${FRONTEND_PORT}"
            ;;
    esac
fi

echo -e "\n${PURPLE}🎯 'MAKING THE IMPOSSIBLE POSSIBLE' - STARTUP COMPLETE${NC}"
echo -e "${GREEN}✨ Quantora Development Beast is now running with elegant architecture!${NC}"
echo "=================================================================="
