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
