#!/bin/bash

# 🛑 QUANTORA GRACEFUL SHUTDOWN - ENHANCED VERSION FOR ELEGANT STRUCTURE
# "Design is not just what it looks like - design is how it works" - Steve Jobs
# Optimized for quantora-development-beast elegant architecture

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============= ELEGANT STRUCTURE VALIDATION =============

# Validate we're in the correct directory structure
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Check if we're in quantora-development-beast
if [[ "$(basename "$PROJECT_ROOT")" == "quantora-development-beast" ]]; then
    echo -e "${GREEN}✅ Running from elegant quantora-development-beast structure${NC}"
    cd "$PROJECT_ROOT"
else
    echo -e "${YELLOW}⚠️  Not in quantora-development-beast directory${NC}"
    echo -e "${BLUE}ℹ️  Current location: $PROJECT_ROOT${NC}"
    echo -e "${BLUE}ℹ️  Continuing with current directory...${NC}"
fi

# Detect current Mac
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

print_mac_info() {
    echo -e "${CYAN}🖥️  $1${NC}"
}

# Function to kill process on port with enhanced detection
kill_port() {
    local port=$1
    local description=$2
    
    PID=$(lsof -ti:$port 2>/dev/null)
    if [ ! -z "$PID" ]; then
        PROCESS=$(ps -p $PID -o comm= 2>/dev/null)
        FULL_COMMAND=$(ps -p $PID -o args= 2>/dev/null | head -c 80)
        print_warning "Stopping $description on port $port"
        print_info "  PID: $PID | Process: $PROCESS"
        print_info "  Command: $FULL_COMMAND"
        
        # Try graceful shutdown first
        kill -15 $PID 2>/dev/null
        sleep 3
        
        # If process is still running, force kill
        if lsof -ti:$port >/dev/null 2>&1; then
            print_warning "  Graceful shutdown failed, force killing..."
            kill -9 $PID 2>/dev/null
            sleep 2
        fi
        
        # Verify it's dead
        if ! lsof -ti:$port >/dev/null 2>&1; then
            print_status "  $description stopped successfully"
        else
            print_error "  Failed to stop $description on port $port"
            return 1
        fi
    else
        print_status "$description port $port is already free"
    fi
    return 0
}

# Function to stop Docker services - ENHANCED for elegant structure
stop_docker_services() {
    print_action "Checking for Docker services..."
    
    # Check for Docker Compose in elegant structure order
    DOCKER_COMPOSE_PATH=""
    
    if [ -f "infrastructure/docker-compose.yml" ]; then
        DOCKER_COMPOSE_PATH="infrastructure/docker-compose.yml"
        print_info "Found Docker Compose in elegant infrastructure/ directory"
    elif [ -f "infrastructure/docker-compose.yaml" ]; then
        DOCKER_COMPOSE_PATH="infrastructure/docker-compose.yaml"
        print_info "Found Docker Compose in elegant infrastructure/ directory"
    elif [ -f "docker-compose.yml" ]; then
        DOCKER_COMPOSE_PATH="docker-compose.yml"
        print_info "Found Docker Compose in project root"
    elif [ -f "docker-compose.yaml" ]; then
        DOCKER_COMPOSE_PATH="docker-compose.yaml"
        print_info "Found Docker Compose in project root"
    fi
    
    if [[ -n "$DOCKER_COMPOSE_PATH" ]] && command -v docker-compose &> /dev/null; then
        print_action "Stopping Docker Compose services..."
        
        # Navigate to appropriate directory
        if [[ "$DOCKER_COMPOSE_PATH" == infrastructure/* ]]; then
            cd infrastructure
            print_info "Working in infrastructure/ directory"
        fi
        
        # Show current running containers
        print_info "Current Docker containers:"
        docker-compose ps 2>/dev/null || docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
        
        # Stop and remove containers
        print_info "Stopping Docker Compose stack..."
        docker-compose down --remove-orphans 2>/dev/null
        
        # Return to project root
        cd "$PROJECT_ROOT"
        
        # Wait a moment for containers to stop
        sleep 3
        
        # Check if any Quantora containers are still running
        RUNNING_CONTAINERS=$(docker ps --filter "name=quantora" --format "{{.Names}}" 2>/dev/null)
        if [ ! -z "$RUNNING_CONTAINERS" ]; then
            print_warning "Some Quantora containers still running:"
            echo "$RUNNING_CONTAINERS"
            print_info "Force stopping remaining containers..."
            echo "$RUNNING_CONTAINERS" | xargs docker stop 2>/dev/null
            echo "$RUNNING_CONTAINERS" | xargs docker rm -f 2>/dev/null
        fi
        
        print_status "Docker services stopped"
    else
        print_info "No Docker Compose configuration found or Docker not available"
    fi
}

# Function to read and stop processes from PID file
stop_tracked_processes() {
    if [ -f ".quantora_pids" ]; then
        print_action "Stopping tracked processes from .quantora_pids..."
        
        source .quantora_pids
        
        if [[ -n "$FRONTEND_PID" ]]; then
            if ps -p $FRONTEND_PID > /dev/null 2>&1; then
                print_warning "Stopping tracked frontend process (PID: $FRONTEND_PID)"
                kill -15 $FRONTEND_PID 2>/dev/null
                sleep 2
                if ps -p $FRONTEND_PID > /dev/null 2>&1; then
                    kill -9 $FRONTEND_PID 2>/dev/null
                fi
                print_status "Tracked frontend process stopped"
            else
                print_info "Tracked frontend process already stopped"
            fi
        fi
        
        if [[ -n "$BACKEND_PID" ]]; then
            if ps -p $BACKEND_PID > /dev/null 2>&1; then
                print_warning "Stopping tracked backend process (PID: $BACKEND_PID)"
                kill -15 $BACKEND_PID 2>/dev/null
                sleep 2
                if ps -p $BACKEND_PID > /dev/null 2>&1; then
                    kill -9 $BACKEND_PID 2>/dev/null
                fi
                print_status "Tracked backend process stopped"
            else
                print_info "Tracked backend process already stopped"
            fi
        fi
        
        if [[ -n "$FRONTEND_PATH" ]]; then
            print_info "Frontend was running from: $FRONTEND_PATH"
        fi
        
        # Remove PID file
        rm -f .quantora_pids
        print_status "Process tracking file cleaned up"
    else
        print_info "No process tracking file found"
    fi
}

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

echo -e "${BLUE}🛑 QUANTORA DEVELOPMENT BEAST SHUTDOWN${NC}"
echo -e "${CYAN}\"Make the impossible possible\" - Steve Jobs Standard${NC}"
print_mac_info "Current System: $MAC_IDENTITY"
print_mac_info "Role: $MAC_ROLE"
print_info "Project Root: $PROJECT_ROOT"
echo "=================================================================="

# Step 0: Stop tracked processes first
echo ""
stop_tracked_processes

# Step 1: Stop Docker Services (if applicable) - ENHANCED
echo ""
stop_docker_services

# Step 2: Stop Frontend Services
echo ""
print_action "STEP 1: Stopping Frontend Services..."

# Stop React/Node.js servers specifically
print_info "Stopping React/Node.js development servers..."
pkill -f "react-scripts start" 2>/dev/null || true
pkill -f "npm start" 2>/dev/null || true
pkill -f "npm.*start" 2>/dev/null || true
pkill -f "node.*webpack" 2>/dev/null || true
pkill -f "webpack-dev-server" 2>/dev/null || true
pkill -f "next.*dev" 2>/dev/null || true
pkill -f "vite.*dev" 2>/dev/null || true

# Stop any basic frontend servers
print_info "Stopping basic frontend servers..."
pkill -f "node.*(server|dashboard)" 2>/dev/null || true
pkill -f "python3.*http.server.*3000" 2>/dev/null || true
pkill -f "python.*server" 2>/dev/null || true

# Kill frontend ports with enhanced detection
kill_port 3000 "React Frontend Server"
kill_port 3001 "Alternative Frontend Server"

# Step 3: Stop Backend Services
echo ""
print_action "STEP 2: Stopping Backend Services..."

# Stop Python/FastAPI processes
print_info "Stopping Python/FastAPI processes..."
pkill -f "uvicorn.*main:app" 2>/dev/null || true
pkill -f "uvicorn" 2>/dev/null || true
pkill -f "fastapi" 2>/dev/null || true
pkill -f "python.*quantora" 2>/dev/null || true
pkill -f "python.*main.py" 2>/dev/null || true

# Kill backend ports
kill_port 8000 "Backend API Server"
kill_port 8001 "Alternative Backend Server"
kill_port 8080 "Alternative Backend Server"

# Step 4: Stop Mac-Specific Services
echo ""
print_action "STEP 3: Stopping Mac-Specific Services..."

case "$CURRENT_MAC_IP" in
    "192.168.1.1")
        print_mac_info "Mac 1 Development Beast specific cleanup..."
        # Stop databases (only on Mac 1)
        print_info "Stopping databases (Mac 1 responsibility)..."
        kill_port 5432 "PostgreSQL Server"
        kill_port 6379 "Redis Server"
        kill_port 8086 "InfluxDB Server"
        ;;
    "192.168.1.2")
        print_mac_info "Mac 2 AI Powerhouse cleanup..."
        # Stop AI services
        print_info "Stopping AI services..."
        pkill -f "ollama" 2>/dev/null || true
        pkill -f "jupyter" 2>/dev/null || true
        pkill -f "ai.*service" 2>/dev/null || true
        kill_port 8002 "AI Services"
        kill_port 11434 "Ollama Service"
        kill_port 8888 "Jupyter Lab"
        ;;
    "192.168.1.3")
        print_mac_info "Mac 3 Production Mirror cleanup..."
        # Stop production services
        print_info "Stopping production services..."
        pkill -f "validation.*service" 2>/dev/null || true
        pkill -f "risk.*monitor" 2>/dev/null || true
        pkill -f "streamlit" 2>/dev/null || true
        kill_port 8003 "Production Services"
        kill_port 8501 "Validation Dashboard"
        kill_port 8502 "Risk Monitor"
        ;;
    *)
        print_mac_info "Standalone mode cleanup..."
        # Stop all services for standalone
        print_info "Stopping all services (standalone mode)..."
        kill_port 5432 "PostgreSQL Server"
        kill_port 6379 "Redis Server"
        kill_port 8002 "AI Services"
        kill_port 8003 "Production Services"
        ;;
esac

# Step 5: Stop Monitoring Services
echo ""
print_action "STEP 4: Stopping Monitoring Services..."

# Stop Prometheus
print_info "Stopping Prometheus..."
pkill -f "prometheus" 2>/dev/null || true
brew services stop prometheus 2>/dev/null || true
kill_port 9090 "Prometheus Server"

# Stop Grafana
print_info "Stopping Grafana..."
pkill -f "grafana" 2>/dev/null || true
brew services stop grafana 2>/dev/null || true
kill_port 3001 "Grafana Server"

# Step 6: Database Services (for Mac 1 or standalone)
if [[ "$CURRENT_MAC_IP" == "192.168.1.1" ]] || [[ "$CURRENT_MAC_IP" == "" ]]; then
    echo ""
    print_action "STEP 5: Stopping Database Services (Mac 1)..."
    
    # Stop PostgreSQL
    print_info "Stopping PostgreSQL..."
    brew services stop postgresql@14 2>/dev/null || brew services stop postgresql 2>/dev/null || true
    
    # Stop Redis
    print_info "Stopping Redis..."
    brew services stop redis 2>/dev/null || true
    
    # Stop InfluxDB
    print_info "Stopping InfluxDB..."
    brew services stop influxdb 2>/dev/null || true
fi

# Step 7: Final Cleanup
echo ""
print_action "STEP 6: Final Cleanup..."

# Stop any remaining Quantora processes
print_info "Stopping any remaining Quantora processes..."
pkill -f "quantora" 2>/dev/null || true

# Clean up any remaining Python processes that might be related
print_info "Cleaning up remaining Python processes..."
pkill -f "python.*8000" 2>/dev/null || true
pkill -f "python.*8001" 2>/dev/null || true
pkill -f "python.*8002" 2>/dev/null || true
pkill -f "python.*8003" 2>/dev/null || true

# Clean up Node.js processes
print_info "Cleaning up remaining Node.js processes..."
pkill -f "node.*3000" 2>/dev/null || true
pkill -f "node.*3001" 2>/dev/null || true

# Step 8: Port Verification
echo ""
print_action "STEP 7: Port Verification..."

# Define ports to check based on Mac role
case "$CURRENT_MAC_IP" in
    "192.168.1.1")
        PORTS_TO_CHECK=(3000 3001 8000 8001 8080 5432 6379 8086 9090)
        ;;
    "192.168.1.2")
        PORTS_TO_CHECK=(3000 3001 8002 11434 8888)
        ;;
    "192.168.1.3")
        PORTS_TO_CHECK=(3000 3001 8003 8501 8502)
        ;;
    *)
        PORTS_TO_CHECK=(3000 3001 8000 8001 8080 8002 8003 5432 6379 8086 9090)
        ;;
esac

ALL_CLEAR=true
REMAINING_PROCESSES=()

for port in "${PORTS_TO_CHECK[@]}"; do
    if lsof -ti:$port >/dev/null 2>&1; then
        PID=$(lsof -ti:$port)
        PROCESS=$(ps -p $PID -o comm= 2>/dev/null)
        print_error "Port $port is still in use by PID $PID ($PROCESS)"
        REMAINING_PROCESSES+=("Port $port: PID $PID ($PROCESS)")
        ALL_CLEAR=false
    fi
done

if [ "$ALL_CLEAR" = true ]; then
    print_status "All ports are now free!"
else
    print_warning "Some ports are still in use:"
    for process in "${REMAINING_PROCESSES[@]}"; do
        echo "  $process"
    done
    echo ""
    print_info "You can manually kill these with:"
    for port in "${PORTS_TO_CHECK[@]}"; do
        if lsof -ti:$port >/dev/null 2>&1; then
            PID=$(lsof -ti:$port)
            echo "  kill -9 $PID  # Port $port"
        fi
    done
fi

# Step 9: Cleanup temporary files
echo ""
print_action "STEP 8: Cleaning up temporary files..."

# Remove any temporary files
rm -f .quantora_pids 2>/dev/null || true
rm -f backend.log 2>/dev/null || true
rm -f frontend.log 2>/dev/null || true
rm -f .emergency_pids 2>/dev/null || true

print_status "Temporary files cleaned up"

# Final status
echo ""
echo "=================================================================="
print_status "✅ QUANTORA DEVELOPMENT BEAST SHUTDOWN COMPLETE"
print_mac_info "System: $MAC_IDENTITY"
print_mac_info "Project: quantora-development-beast"
print_mac_info "Status: Ready for next startup"
echo ""
echo -e "${PURPLE}💫 \"When you do something with pure heart, sincerity and dedication, you create magic\"${NC}"
echo -e "${CYAN}🚀 Ready to make the impossible possible again!${NC}"
echo "=================================================================="

# Show next steps for elegant structure
echo ""
print_info "Next steps:"
echo "  • To restart: ./scripts/quantora-startup.sh"
echo "  • To check ports: lsof -i :3000 (or other ports)"
echo "  • To see Docker status: docker-compose ps"
if [ -f "infrastructure/docker-compose.yml" ]; then
    echo "  • Infrastructure Docker: cd infrastructure && docker-compose ps"
fi
echo ""
