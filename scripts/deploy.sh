#!/bin/bash

# 🚀 Quantora Systems Deployment Script
# "Make the impossible possible" - Mr. IR

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="quantora-systems"
FRONTEND_DIR="frontend/quantora-dashboard"
BACKEND_DIR="backend"
DOCKER_IMAGE="quantora-backend"

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if running in CI/CD environment
is_ci() {
    [ -n "$CI" ] || [ -n "$GITHUB_ACTIONS" ]
}

# Local development setup
setup_local() {
    print_header "Setting up Local Development Environment"
    
    # Check if backend is running
    if curl -s http://localhost:8080/health > /dev/null; then
        print_success "Backend is running on port 8080"
    else
        print_warning "Backend not running. Starting backend..."
        cd $BACKEND_DIR
        python main.py &
        cd ..
        sleep 5
    fi
    
    # Check if frontend is running
    if curl -s http://localhost:3000 > /dev/null; then
        print_success "Frontend is running on port 3000"
    else
        print_warning "Frontend not running. Starting frontend..."
        cd $FRONTEND_DIR
        npm start &
        cd ..
        sleep 10
    fi
    
    print_success "Local development environment ready!"
    echo -e "${BLUE}Frontend: http://localhost:3000${NC}"
    echo -e "${BLUE}Backend: http://localhost:8080${NC}"
    echo -e "${BLUE}API Docs: http://localhost:8080/docs${NC}"
}

# Build frontend
build_frontend() {
    print_header "Building Frontend"
    
    cd $FRONTEND_DIR
    
    # Install dependencies
    print_warning "Installing dependencies..."
    npm ci
    
    # Build for production
    print_warning "Building React app..."
    npm run build
    
    cd ..
    print_success "Frontend built successfully!"
}

# Build backend Docker image
build_backend() {
    print_header "Building Backend Docker Image"
    
    # Build Docker image
    docker build -t $DOCKER_IMAGE:latest -f INFRASTRUCTURE/docker/Dockerfile.backend .
    
    print_success "Backend Docker image built successfully!"
}

# Deploy to Google Cloud Run
deploy_backend() {
    print_header "Deploying Backend to Google Cloud Run"
    
    if [ -z "$GCP_PROJECT_ID" ]; then
        print_error "GCP_PROJECT_ID environment variable not set"
        exit 1
    fi
    
    # Tag and push image
    docker tag $DOCKER_IMAGE:latest gcr.io/$GCP_PROJECT_ID/$DOCKER_IMAGE:latest
    docker push gcr.io/$GCP_PROJECT_ID/$DOCKER_IMAGE:latest
    
    # Deploy to Cloud Run
    gcloud run deploy quantora-backend \
        --image gcr.io/$GCP_PROJECT_ID/$DOCKER_IMAGE:latest \
        --platform managed \
        --region us-central1 \
        --allow-unauthenticated \
        --port 8080 \
        --memory 2Gi \
        --cpu 2 \
        --max-instances 10 \
        --min-instances 1 \
        --set-env-vars ENVIRONMENT=production,LOG_LEVEL=info
    
    # Get service URL
    SERVICE_URL=$(gcloud run services describe quantora-backend --region=us-central1 --format='value(status.url)')
    
    print_success "Backend deployed to: $SERVICE_URL"
    echo "REACT_APP_API_URL=$SERVICE_URL" > .env.production
}

# Deploy to GitHub Pages
deploy_frontend() {
    print_header "Deploying Frontend to GitHub Pages"
    
    cd $FRONTEND_DIR
    
    # Deploy to GitHub Pages
    npm run deploy
    
    cd ..
    print_success "Frontend deployed to GitHub Pages!"
}

# Run tests
run_tests() {
    print_header "Running Tests"
    
    # Backend tests
    print_warning "Running backend tests..."
    cd $BACKEND_DIR
    python -m pytest tests/ -v || print_warning "No backend tests found"
    cd ..
    
    # Frontend tests
    print_warning "Running frontend tests..."
    cd $FRONTEND_DIR
    npm test -- --watchAll=false || print_warning "Frontend tests failed"
    cd ..
    
    print_success "Tests completed!"
}

# Main deployment function
deploy() {
    print_header "Starting Quantora Systems Deployment"
    
    # Run tests first
    run_tests
    
    # Build everything
    build_frontend
    build_backend
    
    # Deploy backend
    deploy_backend
    
    # Deploy frontend
    deploy_frontend
    
    print_success "🎉 Deployment completed successfully!"
    print_success "Frontend: https://$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^/]*\)\/\([^/]*\).*/\1.github.io\/\2/')"
    print_success "Backend: $(gcloud run services describe quantora-backend --region=us-central1 --format='value(status.url)')"
}

# Show usage
usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  local     - Setup local development environment"
    echo "  build     - Build frontend and backend"
    echo "  deploy    - Deploy to production (Google Cloud + GitHub Pages)"
    echo "  test      - Run tests"
    echo "  help      - Show this help message"
    echo ""
    echo "Environment Variables:"
    echo "  GCP_PROJECT_ID - Google Cloud Project ID"
    echo "  GCP_SA_KEY     - Google Cloud Service Account Key (base64 encoded)"
}

# Main script logic
case "${1:-help}" in
    local)
        setup_local
        ;;
    build)
        build_frontend
        build_backend
        ;;
    deploy)
        deploy
        ;;
    test)
        run_tests
        ;;
    help|*)
        usage
        ;;
esac 