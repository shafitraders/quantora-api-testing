# 🚀 Quantora API Testing & Diagnostics Platform

**Live at:** [https://shafitraders.github.io/quantora-api-testing/](https://shafitraders.github.io/quantora-api-testing/)

## 🎯 Quick Start Guide

### 1. **Get Your Google Cloud Identity Token**
```bash
gcloud auth print-identity-token
```

### 2. **Start the Local CORS Proxy Server**
```bash
# Navigate to the quantora-api-testing directory
cd quantora-api-testing

# Install dependencies (if not already done)
npm install

# Start the proxy server
node proxy-server.js
```

### 3. **Use the Working Dashboard**
1. Visit [https://shafitraders.github.io/quantora-api-testing/](https://shafitraders.github.io/quantora-api-testing/)
2. Paste your Google Cloud Identity Token
3. Click "💾 Set Token"
4. Click "🧪 Test Connection" to verify authentication
5. Click "🚀 Load Dashboard" to see all API data

## 🔧 How It Works

The **Working Dashboard** uses a **local CORS proxy** (`http://localhost:3001`) to bypass browser CORS restrictions and authenticate with the production API using Google Cloud Identity Tokens.

### ✅ Why This Works
- **No CORS Issues**: Local proxy handles cross-origin requests
- **Secure Authentication**: Google Cloud Identity Tokens
- **Real-time Data**: Live API testing and monitoring
- **Beautiful UI**: Professional dashboard interface

### 🔄 Token Refresh
Google Cloud Identity Tokens expire every hour. Refresh your token with:
```bash
gcloud auth print-identity-token
```

## 🎨 Features

- **🏥 Health Check**: API connectivity and status
- **📊 System Status**: Complete system metrics
- **🤖 Live Patterns**: Real-time pattern discovery
- **⚡ Performance**: Response time analysis
- **📈 Live Metrics**: Real-time dashboard updates

## 🚀 Production API

**Endpoint:** `https://quantora-production-api-387275137268.us-central1.run.app`

The dashboard automatically connects to the production API through the local proxy server.

## 💡 Troubleshooting

### If you get "Failed to fetch" errors:
1. Make sure the proxy server is running on port 3001
2. Check that your token is fresh (not expired)
3. Verify you're using the working dashboard (not the old index.html)

### If authentication fails:
1. Generate a fresh token: `gcloud auth print-identity-token`
2. Make sure you're logged into gcloud: `gcloud auth login`
3. Check your project: `gcloud config get-value project`

---

**🌟 "Making the impossible possible" - Mr. IR**

*Enterprise-grade infrastructure with Steve Jobs quality standards*