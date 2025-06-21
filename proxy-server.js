// Quantora API CORS Proxy Server
// This server bypasses CORS restrictions for local development

const express = require('express');
const cors = require('cors');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const PORT = 3001;

// Enable CORS for all origins
app.use(cors({
    origin: '*',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept']
}));

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({
        status: 'healthy',
        service: 'quantora-cors-proxy',
        message: 'CORS proxy is running'
    });
});

// Proxy all /api requests to the production API
app.use('/api', createProxyMiddleware({
    target: 'https://quantora-production-api-387275137268.us-central1.run.app',
    changeOrigin: true,
    pathRewrite: {
        '^/api': '' // Remove /api prefix when forwarding
    },
    onProxyReq: (proxyReq, req, res) => {
        console.log(`🔄 Proxying: ${req.method} ${req.path} -> ${proxyReq.path}`);
    },
    onProxyRes: (proxyRes, req, res) => {
        console.log(`✅ Response: ${proxyRes.statusCode} for ${req.path}`);
    },
    onError: (err, req, res) => {
        console.error(`❌ Proxy error for ${req.path}:`, err.message);
        res.status(500).json({
            error: 'Proxy error',
            message: err.message
        });
    }
}));

// Start the server
app.listen(PORT, () => {
    console.log('🚀 Quantora CORS Proxy Server Started!');
    console.log('=====================================');
    console.log(`📊 Proxy URL: http://localhost:${PORT}`);
    console.log(`🔗 API Base: http://localhost:${PORT}/api`);
    console.log(`🏥 Health Check: http://localhost:${PORT}/health`);
    console.log('');
    console.log('💡 Usage Examples:');
    console.log(`   Health: http://localhost:${PORT}/api/health`);
    console.log(`   System Status: http://localhost:${PORT}/api/system/status`);
    console.log(`   Live Patterns: http://localhost:${PORT}/api/patterns/live`);
    console.log('');
    console.log('🔐 Authentication: Add your Google Cloud Identity Token to requests');
    console.log('   Headers: { "Authorization": "Bearer YOUR_TOKEN" }');
    console.log('');
    console.log('🛑 Press Ctrl+C to stop the server');
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\n🛑 Shutting down proxy server...');
    process.exit(0);
}); 