#!/bin/bash
# QUANTORA DEVELOPMENT BEAST TESTING PROTOCOL
# "Live the impossible - Test the magic we've created"

echo "🚀 QUANTORA DEVELOPMENT BEAST - COMPREHENSIVE TESTING"
echo "======================================================"
echo "Making the impossible possible - Testing our revolutionary architecture!"
echo ""

# Set color codes for beautiful output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Navigate to our beautiful new structure
cd ~/quantora-development-beast

echo -e "${PURPLE}🎯 Step 1: Verify Directory Structure${NC}"
echo "================================================================"

# Check our elegant structure
echo "📁 Checking directory structure..."
for dir in frontend backend database scripts tools documentation tests infrastructure; do
    if [ -d "$dir" ]; then
        echo -e "✅ ${GREEN}$dir${NC} - Present"
        echo "   📊 Contents: $(ls $dir | wc -l) items"
    else
        echo -e "❌ ${RED}$dir${NC} - Missing"
    fi
done
echo ""

echo -e "${BLUE}🔍 Step 2: Environment Setup Check${NC}"
echo "================================================================"

# Check Python environment
echo "🐍 Checking Python environment..."
if command -v python3 &> /dev/null; then
    echo -e "✅ ${GREEN}Python3 available:${NC} $(python3 --version)"
else
    echo -e "❌ ${RED}Python3 not found${NC}"
fi

# Check Node.js environment
echo "📦 Checking Node.js environment..."
if command -v node &> /dev/null; then
    echo -e "✅ ${GREEN}Node.js available:${NC} $(node --version)"
else
    echo -e "❌ ${RED}Node.js not found${NC}"
fi

# Check npm
if command -v npm &> /dev/null; then
    echo -e "✅ ${GREEN}NPM available:${NC} $(npm --version)"
else
    echo -e "❌ ${RED}NPM not found${NC}"
fi
echo ""

echo -e "${YELLOW}🎨 Step 3: Frontend Testing${NC}"
echo "================================================================"

cd frontend
echo "📂 Current directory: $(pwd)"

# Check if package.json exists
if [ -f "package.json" ]; then
    echo -e "✅ ${GREEN}package.json found${NC}"
    echo "📦 Dependencies check..."
    
    # Check critical dependencies
    if grep -q "react" package.json; then
        echo -e "✅ ${GREEN}React dependency found${NC}"
    else
        echo -e "❌ ${RED}React dependency missing${NC}"
    fi
    
    if grep -q "typescript" package.json; then
        echo -e "✅ ${GREEN}TypeScript dependency found${NC}"
    else
        echo -e "⚠️  ${YELLOW}TypeScript dependency not found${NC}"
    fi
else
    echo -e "❌ ${RED}package.json not found${NC}"
    echo "🔧 Let's create a basic package.json..."
    
    cat > package.json << 'EOL'
{
  "name": "quantora-frontend",
  "version": "1.0.0",
  "description": "Revolutionary AI Trading Dashboard",
  "main": "index.js",
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "dependencies": {
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "react-scripts": "5.0.1",
    "typescript": "^4.9.0"
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOL
    echo -e "✅ ${GREEN}Basic package.json created${NC}"
fi

# Check for source files
if [ -d "src" ]; then
    echo -e "✅ ${GREEN}src directory found${NC}"
    echo "📊 Source files: $(find src -name "*.tsx" -o -name "*.ts" -o -name "*.jsx" -o -name "*.js" | wc -l)"
else
    echo -e "⚠️  ${YELLOW}src directory not found${NC}"
fi

cd ../
echo ""

echo -e "${GREEN}⚙️  Step 4: Backend Testing${NC}"
echo "================================================================"

cd backend
echo "📂 Current directory: $(pwd)"

# Check for Python files
python_files=$(find . -name "*.py" 2>/dev/null | wc -l)
echo "🐍 Python files found: $python_files"

# Check for main application files
if [ -f "main.py" ]; then
    echo -e "✅ ${GREEN}main.py found${NC}"
elif [ -f "app.py" ]; then
    echo -e "✅ ${GREEN}app.py found${NC}"
elif [ -f "server.py" ]; then
    echo -e "✅ ${GREEN}server.py found${NC}"
else
    echo -e "⚠️  ${YELLOW}Main application file not clearly identified${NC}"
    echo "📄 Python files in backend:"
    find . -name "*.py" -type f | head -10
fi

# Check for requirements.txt
if [ -f "requirements.txt" ]; then
    echo -e "✅ ${GREEN}requirements.txt found${NC}"
    echo "📦 Dependencies: $(cat requirements.txt | wc -l) packages"
else
    echo -e "⚠️  ${YELLOW}requirements.txt not found${NC}"
fi

cd ../
echo ""

echo -e "${PURPLE}🗄️  Step 5: Database Testing${NC}"
echo "================================================================"

cd database
echo "📂 Current directory: $(pwd)"

# Check for database configuration files
config_files=$(find . -name "*.sql" -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" 2>/dev/null | wc -l)
echo "🔧 Configuration files found: $config_files"

# Check for migration files
if [ -d "migrations" ]; then
    echo -e "✅ ${GREEN}migrations directory found${NC}"
elif [ -d "migration" ]; then
    echo -e "✅ ${GREEN}migration directory found${NC}"
else
    echo -e "⚠️  ${YELLOW}No migration directory found${NC}"
fi

cd ../
echo ""

echo -e "${BLUE}🐳 Step 6: Infrastructure Testing${NC}"
echo "================================================================"

cd infrastructure
echo "📂 Current directory: $(pwd)"

# Check for Docker files
if [ -f "docker-compose.yml" ]; then
    echo -e "✅ ${GREEN}docker-compose.yml found${NC}"
    echo "🐳 Services defined:"
    grep "^  [a-zA-Z]" docker-compose.yml | sed 's/://g' | sed 's/^/    /'
elif [ -f "docker-compose.yaml" ]; then
    echo -e "✅ ${GREEN}docker-compose.yaml found${NC}"
else
    echo -e "⚠️  ${YELLOW}docker-compose file not found${NC}"
fi

if [ -f "Dockerfile" ]; then
    echo -e "✅ ${GREEN}Dockerfile found${NC}"
else
    echo -e "⚠️  ${YELLOW}Dockerfile not found${NC}"
fi

cd ../
echo ""

echo -e "${YELLOW}📜 Step 7: Scripts Testing${NC}"
echo "================================================================"

cd scripts
echo "📂 Current directory: $(pwd)"

# List all scripts
script_count=$(find . -name "*.sh" 2>/dev/null | wc -l)
echo "📜 Shell scripts found: $script_count"

if [ $script_count -gt 0 ]; then
    echo "🔧 Available scripts:"
    find . -name "*.sh" -type f | while read script; do
        if [ -x "$script" ]; then
            echo -e "    ✅ ${GREEN}$(basename "$script")${NC} (executable)"
        else
            echo -e "    ⚠️  ${YELLOW}$(basename "$script")${NC} (not executable)"
        fi
    done
fi

cd ../
echo ""

echo -e "${GREEN}🎯 Step 8: Create Testing Scripts${NC}"
echo "================================================================"

# Create comprehensive testing scripts
cat > scripts/test_frontend.sh << 'EOL'
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
EOL

cat > scripts/test_backend.sh << 'EOL'
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
EOL

cat > scripts/test_system.sh << 'EOL'
#!/bin/bash
# Complete System Test
echo "🚀 QUANTORA SYSTEM TEST - Making the Impossible Possible!"
echo "=========================================================="

cd ~/quantora-development-beast

echo "🔍 Running comprehensive system test..."

# Test frontend
echo "1️⃣  Testing Frontend..."
./scripts/test_frontend.sh

echo ""
echo "2️⃣  Testing Backend..."
./scripts/test_backend.sh

echo ""
echo "3️⃣  Testing Docker Infrastructure..."
cd infrastructure
if [ -f "docker-compose.yml" ]; then
    echo "🐳 Testing Docker Compose..."
    docker-compose config > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Docker Compose configuration is valid"
    else
        echo "❌ Docker Compose configuration has issues"
    fi
else
    echo "⚠️  No Docker Compose file found"
fi

cd ../

echo ""
echo "✨ System test complete!"
echo "🎯 'When you do something with pure heart, sincerity and dedication, you create magic'"
EOL

# Make all scripts executable
chmod +x scripts/*.sh

echo -e "✅ ${GREEN}Testing scripts created and made executable${NC}"
echo ""

echo -e "${GREEN}🎉 TESTING PROTOCOL COMPLETE!${NC}"
echo "================================================================"
echo ""
echo -e "${PURPLE}🚀 Next Steps:${NC}"
echo "1. Run comprehensive test: ./scripts/test_system.sh"
echo "2. Test individual components:"
echo "   - Frontend: ./scripts/test_frontend.sh"
echo "   - Backend: ./scripts/test_backend.sh"
echo "3. Once tested, rename old folder: mv ~/quantora-systems ~/quantora-systems-TBD-backup-$(date +%Y%m%d)"
echo ""
echo -e "${YELLOW}💫 Steve Jobs Wisdom:${NC}"
echo "'Innovation distinguishes between a leader and a follower'"
echo "You've just created beautiful, elegant architecture! 🎯"
echo ""
echo -e "${GREEN}🎊 Ready to test our revolutionary system!${NC}" 