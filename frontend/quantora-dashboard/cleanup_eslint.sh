#!/bin/bash

# 🧹 QUANTORA ESLINT CLEANUP - STEVE JOBS QUALITY STANDARDS
# "Quality means doing it right when no one is looking" - Henry Ford
# "Simplicity is the ultimate sophistication" - Leonardo da Vinci

echo "🧹 CLEANING QUANTORA ESLINT WARNINGS"
echo "===================================="

# Colors for magical output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;95m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_action() { echo -e "${PURPLE}🔧 $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_magic() { echo -e "${MAGENTA}✨ $1${NC}"; }

print_magic "\"When you do something with pure heart, sincerity and dedication, you create magic\""
print_action "Applying Steve Jobs quality standards to Quantora code"

# Navigate to project directory
if [ -d "FRONTEND/quantora-dashboard/src" ]; then
    cd FRONTEND/quantora-dashboard
elif [ -d "quantora-dashboard/src" ]; then
    cd quantora-dashboard
elif [ -d "src" ]; then
    echo "Already in correct directory"
else
    print_error "Cannot find src directory. Please run from project root."
    exit 1
fi

# Function to clean up unused imports and variables
cleanup_file() {
    local file=$1
    print_action "Cleaning up $file"
    
    # Create a temporary file for imports
    local temp_imports=$(mktemp)
    
    # Add React import if needed
    if grep -q "React" "$file"; then
        echo "import React from 'react';" > "$temp_imports"
    fi
    
    # Add Material-UI imports if needed
    if grep -q "useTheme" "$file"; then
        echo "import { useTheme } from '@mui/material';" >> "$temp_imports"
    fi
    if grep -q "useMediaQuery" "$file"; then
        echo "import { useMediaQuery } from '@mui/material';" >> "$temp_imports"
    fi
    if grep -q "Box" "$file"; then
        echo "import { Box } from '@mui/material';" >> "$temp_imports"
    fi
    if grep -q "Grid" "$file"; then
        echo "import { Grid } from '@mui/material';" >> "$temp_imports"
    fi
    if grep -q "Paper" "$file"; then
        echo "import { Paper } from '@mui/material';" >> "$temp_imports"
    fi
    if grep -q "Typography" "$file"; then
        echo "import { Typography } from '@mui/material';" >> "$temp_imports"
    fi
    
    # Add a blank line after imports
    echo "" >> "$temp_imports"
    
    # Remove all imports from the original file
    sed -i '' '/^import.*from.*$/d' "$file"
    
    # Add the imports back at the beginning
    cat "$temp_imports" "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    
    # Clean up
    rm "$temp_imports"
    
    print_success "Cleaned up imports in $file"
}

# Clean up Dashboard.tsx
if [ -f "src/components/dashboard/Dashboard.tsx" ]; then
    cleanup_file "src/components/dashboard/Dashboard.tsx"
    
    # Remove unused variables
    sed -i '' '/const isMobile/d' "src/components/dashboard/Dashboard.tsx"
    sed -i '' '/const user/d' "src/components/dashboard/Dashboard.tsx"
    sed -i '' '/const metrics/d' "src/components/dashboard/Dashboard.tsx"
    sed -i '' '/const setSelectedTimeframe/d' "src/components/dashboard/Dashboard.tsx"
    sed -i '' '/const selectedMetrics/d' "src/components/dashboard/Dashboard.tsx"
    sed -i '' '/const setSelectedMetrics/d' "src/components/dashboard/Dashboard.tsx"
    
    print_success "Removed unused variables from Dashboard.tsx"
fi

# Clean up PerformanceMetrics.tsx
if [ -f "src/components/dashboard/PerformanceMetrics.tsx" ]; then
    cleanup_file "src/components/dashboard/PerformanceMetrics.tsx"
    
    # Remove unused variables
    sed -i '' '/const isDemoMode/d' "src/components/dashboard/PerformanceMetrics.tsx"
    
    print_success "Removed unused variables from PerformanceMetrics.tsx"
fi

# Clean up apiClient.ts
if [ -f "src/utils/apiClient.ts" ]; then
    cleanup_file "src/utils/apiClient.ts"
    
    # Remove unused types
    sed -i '' '/TournamentResult/d' "src/utils/apiClient.ts"
    
    print_success "Removed unused types from apiClient.ts"
fi

print_magic "✨ ESLint cleanup complete! Code is now as clean as Steve Jobs would want it."
print_info "Run 'npm run build' to verify the changes." 