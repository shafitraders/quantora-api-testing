#!/bin/bash
# 🚀 Quantora Working Dashboard Setup Script
# "Making the impossible possible" - Mr. IR

echo "🚀 QUANTORA WORKING DASHBOARD SETUP"
echo "===================================="
echo "Setting up your local environment for API testing..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js found: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ npm found: $(npm --version)"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Check if proxy server file exists
if [ ! -f "proxy-server.js" ]; then
    echo "❌ proxy-server.js not found. Please make sure you're in the correct directory."
    exit 1
fi

echo "✅ Dependencies installed successfully!"

# Get Google Cloud Identity Token
echo ""
echo "🔐 Getting Google Cloud Identity Token..."
if command -v gcloud &> /dev/null; then
    echo "✅ gcloud found. Getting token..."
    TOKEN=$(gcloud auth print-identity-token 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "✅ Token generated successfully!"
        echo "🔑 Your token: ${TOKEN:0:20}..."
    else
        echo "⚠️  Could not generate token. You may need to:"
        echo "   1. Run: gcloud auth login"
        echo "   2. Run: gcloud auth print-identity-token"
    fi
else
    echo "⚠️  gcloud not found. Please install Google Cloud SDK:"
    echo "   Visit: https://cloud.google.com/sdk/docs/install"
fi

echo ""
echo "🚀 Starting proxy server..."
echo "📊 Dashboard will be available at: http://localhost:3001"
echo "🌐 GitHub Pages: https://shafitraders.github.io/quantora-api-testing/"
echo ""
echo "💡 Instructions:"
echo "1. Keep this terminal open (proxy server running)"
echo "2. Open https://shafitraders.github.io/quantora-api-testing/"
echo "3. Paste your Google Cloud Identity Token"
echo "4. Click '💾 Set Token' then '🧪 Test Connection'"
echo ""
echo "🛑 Press Ctrl+C to stop the proxy server"
echo ""

# Start the proxy server
node proxy-server.js 