const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

// Serve static files
app.use(express.static(path.join(__dirname)));

// Serve index.html for the root route
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Start server
app.listen(port, () => {
    console.log(`🚀 Quantora Dashboard running at http://localhost:${port}`);
    console.log('📊 Dashboard features:');
    console.log('  • Real-time pattern monitoring');
    console.log('  • WebSocket connection status');
    console.log('  • System health metrics');
    console.log('  • API endpoint testing');
}); 