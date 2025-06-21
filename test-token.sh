#!/bin/bash

echo "🔍 Quantora Token Test Script"
echo "=============================="

# Get the token from user input
echo "Please paste your Google Cloud Identity Token:"
read -r TOKEN

if [ -z "$TOKEN" ]; then
    echo "❌ No token provided"
    exit 1
fi

echo "✅ Token received (length: ${#TOKEN} characters)"
echo ""

# Test the token with the health endpoint
echo "🧪 Testing token with /health endpoint..."
RESPONSE=$(curl -s -w "\n%{http_code}" \
    -X GET "https://quantora-production-api-387275137268.us-central1.run.app/health" \
    -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json")

# Extract status code and response body
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)
RESPONSE_BODY=$(echo "$RESPONSE" | head -n -1)

echo "📊 Response Status: $HTTP_STATUS"
echo "📄 Response Body: $RESPONSE_BODY"
echo ""

if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ SUCCESS! Token is valid and working"
    echo "🎉 You can now use this token in the web interface"
else
    echo "❌ FAILED! Status code: $HTTP_STATUS"
    echo "🔍 Response: $RESPONSE_BODY"
    echo ""
    echo "Possible issues:"
    echo "• Token expired (regenerate with: gcloud auth print-identity-token)"
    echo "• Wrong project (set with: gcloud config set project quantora-parallel-dev)"
    echo "• Network connectivity issues"
fi

echo ""
echo "🔧 Debug Info:"
echo "• Token length: ${#TOKEN} characters"
echo "• Token preview: ${TOKEN:0:50}..."
echo "• API endpoint: https://quantora-production-api-387275137268.us-central1.run.app" 