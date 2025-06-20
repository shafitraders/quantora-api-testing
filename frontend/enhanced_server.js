const express = require('express');
const path = require('path');
const net = require('net');

const app = express();

// Function to check if port is available
const isPortAvailable = (port) => {
    return new Promise((resolve) => {
        const server = net.createServer();
        server.listen(port, () => {
            server.once('close', () => resolve(true));
            server.close();
        });
        server.on('error', () => resolve(false));
    });
};

// Function to find available port
const findAvailablePort = async (startPort = 3000, maxAttempts = 10) => {
    for (let i = 0; i < maxAttempts; i++) {
        const port = startPort + i;
        if (await isPortAvailable(port)) {
            return port;
        }
    }
    throw new Error(`No available port found starting from ${startPort}`);
};

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname)));

// Serve index.html for all routes (SPA support)
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Smart server startup
const startServer = async () => {
    try {
        const PORT = await findAvailablePort(3000);
        
        app.listen(PORT, () => {
            console.log('🚀 Quantora Dashboard Server Started!');
            console.log('=================================');
            console.log(`📊 Dashboard URL: http://localhost:${PORT}`);
            console.log(`⚡ Backend URL:   http://localhost:8000 (if running)`);
            console.log('');
            console.log('🌟 Steve Jobs Principle Applied:');
            console.log('   "Design is not just what it looks like - design is how it works"');
            console.log('');
            console.log('💫 "Make the impossible possible" - Mr. IR');
            
            // Auto-open browser if possible
            const { exec } = require('child_process');
            const url = `http://localhost:${PORT}`;
            
            // Try to open browser
            const start = process.platform === 'darwin' ? 'open' :
                         process.platform === 'win32' ? 'start' : 'xdg-open';
            
            exec(`${start} ${url}`, (error) => {
                if (error) {
                    console.log(`🌐 Please open ${url} in your browser`);
                } else {
                    console.log('🌐 Dashboard opened in browser automatically');
                }
            });
        });
        
        // Graceful shutdown
        process.on('SIGTERM', () => {
            console.log('🛑 Received SIGTERM, shutting down gracefully...');
            process.exit(0);
        });
        
        process.on('SIGINT', () => {
            console.log('🛑 Received SIGINT, shutting down gracefully...');
            process.exit(0);
        });
        
    } catch (error) {
        console.error('❌ Failed to start server:', error.message);
        console.log('');
        console.log('🔧 Troubleshooting:');
        console.log('   1. Make sure no other servers are running');
        console.log('   2. Try running: ./cleanup_ports.sh');
        console.log('   3. Check for processes using: lsof -i :3000');
        process.exit(1);
    }
};

startServer();
