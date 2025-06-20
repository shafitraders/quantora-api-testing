#!/bin/bash

# 🏗️ QUANTORA DASHBOARD BUILD SCRIPT

echo "🏗️ Building Quantora Dashboard for production..."

# Install dependencies
echo "📦 Installing dependencies..."
npm ci

# Build the project
echo "🔨 Building project..."
npm run build

# Create serve script
cat > serve.sh << 'SERVE_EOF'
#!/bin/bash
echo "🌟 Serving Quantora Dashboard..."
echo "📊 Dashboard will be available at: http://localhost:3000"
npx serve -s build -l 3000
SERVE_EOF

chmod +x serve.sh

echo "✅ Build complete!"
echo "🌟 To serve: ./serve.sh" 