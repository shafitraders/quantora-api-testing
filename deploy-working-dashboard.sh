#!/bin/bash
# 🚀 Deploy Working Dashboard to Production
# "Make the impossible possible" - Mr. IR

echo "🚀 QUANTORA WORKING DASHBOARD DEPLOYMENT"
echo "=========================================="

# Colors for beautiful output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if we're in the right directory
if [ ! -f "working-dashboard.html" ]; then
    echo -e "${RED}❌ Error: working-dashboard.html not found${NC}"
    echo "Please run this script from the quantora-api-testing directory"
    exit 1
fi

echo -e "${BLUE}📁 Current directory:${NC} $(pwd)"
echo ""

# Create deployment package
echo -e "${YELLOW}📦 Creating deployment package...${NC}"
mkdir -p deploy-package
cp working-dashboard.html deploy-package/
cp proxy-server.js deploy-package/
cp package.json deploy-package/

# Create Dockerfile for deployment
cat > deploy-package/Dockerfile << 'EOL'
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy application files
COPY . .

# Expose port
EXPOSE 3001

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3001/health || exit 1

# Start the application
CMD ["npm", "start"]
EOL

# Create deployment script
cat > deploy-package/deploy.sh << 'EOL'
#!/bin/bash
# Deploy to Google Cloud Run

PROJECT_ID="quantora-production"
SERVICE_NAME="quantora-working-dashboard"
REGION="us-central1"

echo "🚀 Deploying Working Dashboard to Cloud Run..."

# Build and deploy
gcloud run deploy $SERVICE_NAME \
  --source . \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --port 3001 \
  --memory 512Mi \
  --cpu 1 \
  --max-instances 10 \
  --set-env-vars="NODE_ENV=production"

echo "✅ Deployment complete!"
echo "🌐 Dashboard URL: https://$SERVICE_NAME-$PROJECT_ID.$REGION.run.app"
EOL

chmod +x deploy-package/deploy.sh

echo -e "${GREEN}✅ Deployment package created!${NC}"
echo ""
echo -e "${BLUE}📋 Next Steps:${NC}"
echo "1. cd deploy-package"
echo "2. ./deploy.sh"
echo ""
echo -e "${YELLOW}💡 Alternative: Deploy manually${NC}"
echo "gcloud run deploy quantora-working-dashboard --source . --platform managed --region us-central1 --allow-unauthenticated"
echo ""

# Show package contents
echo -e "${BLUE}📦 Package Contents:${NC}"
ls -la deploy-package/
echo ""

echo -e "${GREEN}🎉 Ready for deployment!${NC}"
echo "The working dashboard will be available at:"
echo "https://quantora-working-dashboard-quantora-production.us-central1.run.app" 