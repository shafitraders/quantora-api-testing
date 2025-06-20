// Configuration
const API_BASE_URL = 'http://localhost:8000';
const WS_BASE_URL = 'ws://localhost:8000/ws/live-discovery';
let ws = null;
let isConnected = false;

// Initialize Application
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
    createParticles();
});

async function initializeApp() {
    console.log('🚀 Initializing Quantora Dashboard');
    
    // Load initial data
    await loadInitialData();
    
    // Connect WebSocket
    connectWebSocket();
    
    // Start periodic updates
    setInterval(updateDashboard, 30000); // Update every 30 seconds
}

function createParticles() {
    const container = document.getElementById('particles');
    if (!container) return;
    
    const particleCount = 50;
    
    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.left = Math.random() * 100 + '%';
        particle.style.top = Math.random() * 100 + '%';
        particle.style.animationDelay = Math.random() * 8 + 's';
        particle.style.animationDuration = (8 + Math.random() * 4) + 's';
        container.appendChild(particle);
    }
}

async function loadInitialData() {
    try {
        updateConnectionStatus('connecting', '🔄 Connecting to Backend...');
        
        // Try to load from backend
        const patternsResponse = await fetch(`${API_BASE_URL}/api/patterns/live`);
        const patternsData = await patternsResponse.json();
        
        // Update UI with real data
        updateDashboardData(patternsData);
        
        updateConnectionStatus('connected', '🟢 Backend Connected');
        console.log('✅ Real data loaded from backend');
        
    } catch (error) {
        console.log('⚠️ Backend not available, using demo data');
        
        // Use demo data
        const demoData = getDemoData();
        updateDashboardData(demoData);
        
        updateConnectionStatus('demo', '🎭 Demo Mode Active');
    }
}

function getDemoData() {
    return {
        total_count: 50,
        patterns: [
            { name: "Meta Whale Activity Intelligence", success_rate: 0.885, sharpe_ratio: 1.89, level: 2 },
            { name: "Active Network Flow Pattern", success_rate: 0.863, sharpe_ratio: 1.67, level: 1 },
            { name: "Exchange Flow RSI Confluence", success_rate: 0.849, sharpe_ratio: 1.73, level: 1 }
        ]
    };
}

function connectWebSocket() {
    try {
        ws = new WebSocket(WS_BASE_URL);
        
        ws.onopen = function() {
            console.log('🔌 WebSocket connected');
            isConnected = true;
            updateConnectionStatus('connected', '🚀 AI Stream Active');
        };
        
        ws.onmessage = function(event) {
            const data = JSON.parse(event.data);
            handleWebSocketMessage(data);
        };
        
        ws.onclose = function() {
            console.log('🔌 WebSocket disconnected');
            isConnected = false;
            updateConnectionStatus('disconnected', '🔌 Disconnected');
            
            // Attempt reconnection
            setTimeout(connectWebSocket, 5000);
        };
        
        ws.onerror = function(error) {
            console.log('🔌 WebSocket error:', error);
            updateConnectionStatus('error', '❌ Connection Error');
        };
        
    } catch (error) {
        console.log('🔌 WebSocket unavailable:', error);
        updateConnectionStatus('error', '❌ Connection Failed');
    }
}

function handleWebSocketMessage(data) {
    console.log('📨 WebSocket message:', data.type);
    
    switch (data.type) {
        case 'connection_established':
            updateConnectionStatus('connected', '🚀 AI Stream Active');
            break;
            
        case 'pattern_discovered':
            addPatternDiscovery(data);
            break;
            
        case 'ai_performance_update':
            updateAIPerformance(data);
            break;
            
        case 'system_health_update':
            updateSystemHealth(data);
            break;
            
        default:
            console.log('📨 Unknown message type:', data.type);
    }
}

function updateDashboardData(data) {
    // Update pattern count
    const totalPatterns = document.getElementById('totalPatterns');
    if (totalPatterns) {
        totalPatterns.textContent = data.total_count || '50';
    }
    
    // Update patterns result
    const patternsResult = document.getElementById('patternsResult');
    if (patternsResult) {
        patternsResult.className = 'mt-2 p-2 rounded bg-green-800';
        patternsResult.innerHTML = `
            <div class="font-semibold mb-2">Live Patterns:</div>
            <div>Total Patterns: ${data.total_count || 0}</div>
            <div>Last Updated: ${new Date().toLocaleString()}</div>
            <div class="mt-2">
                <div class="font-semibold">Recent Patterns:</div>
                ${(data.patterns || []).slice(0, 3).map(pattern => `
                    <div class="mt-1">
                        <div>Name: ${pattern.name}</div>
                        <div>Success: ${(pattern.success_rate * 100).toFixed(1)}%</div>
                        <div>Level: ${pattern.level}</div>
                    </div>
                `).join('')}
            </div>
        `;
        patternsResult.classList.remove('hidden');
    }
}

function updateConnectionStatus(status, message) {
    const statusElement = document.getElementById('wsStatus');
    if (!statusElement) return;
    
    statusElement.textContent = message;
    statusElement.className = 'inline-block px-3 py-1 rounded';
    
    switch (status) {
        case 'connected':
            statusElement.classList.add('bg-green-800');
            break;
        case 'disconnected':
            statusElement.classList.add('bg-gray-700');
            break;
        case 'error':
            statusElement.classList.add('bg-red-800');
            break;
        default:
            statusElement.classList.add('bg-gray-700');
    }
}

function toggleWebSocket() {
    if (ws) {
        ws.close();
        ws = null;
        updateConnectionStatus('disconnected', 'Disconnected');
    } else {
        connectWebSocket();
    }
}

function sendWebSocketMessage() {
    if (!ws) {
        logWebSocketMessage('Error', 'WebSocket not connected');
        return;
    }

    const messageInput = document.getElementById('wsMessage');
    const text = messageInput.value.trim();
    
    if (text) {
        const message = {
            type: 'message',
            content: text,
            timestamp: new Date().toISOString()
        };
        
        try {
            ws.send(JSON.stringify(message));
            logWebSocketMessage('Sent', JSON.stringify(message, null, 2));
            messageInput.value = '';
        } catch (error) {
            logWebSocketMessage('Error', `Failed to send message: ${error.message}`);
        }
    }
}

function logWebSocketMessage(type, message) {
    const logDiv = document.getElementById('wsLog');
    if (!logDiv) return;
    
    const timestamp = new Date().toLocaleTimeString();
    const messageDiv = document.createElement('div');
    messageDiv.className = 'mb-1';
    
    // Clear "No messages yet" if it's the first message
    if (logDiv.firstChild?.textContent === 'No messages yet...') {
        logDiv.innerHTML = '';
    }

    // Style based on message type
    switch (type) {
        case 'System':
            messageDiv.classList.add('text-blue-400');
            break;
        case 'Error':
            messageDiv.classList.add('text-red-400');
            break;
        case 'Sent':
            messageDiv.classList.add('text-green-400');
            break;
        case 'Received':
            messageDiv.classList.add('text-yellow-400');
            break;
    }

    messageDiv.textContent = `[${timestamp}] ${type}: ${message}`;
    logDiv.appendChild(messageDiv);
    logDiv.scrollTop = logDiv.scrollHeight;
}

// API Test Functions
async function testHealthCheck() {
    const resultDiv = document.getElementById('healthResult');
    if (!resultDiv) return;
    
    try {
        const response = await fetch(`${API_BASE_URL}/health`);
        const data = await response.json();
        resultDiv.className = 'mt-2 p-2 rounded bg-green-800';
        resultDiv.innerHTML = `
            <div class="font-semibold mb-2">Health Check Results:</div>
            <div>Status: ${data.status}</div>
            <div>API: ${data.services?.api || 'N/A'}</div>
            <div>Database: ${data.services?.database || 'N/A'}</div>
            <div>Redis: ${data.services?.redis || 'N/A'}</div>
            <div>Timestamp: ${new Date(data.timestamp).toLocaleString()}</div>
        `;
    } catch (error) {
        resultDiv.className = 'mt-2 p-2 rounded bg-red-800';
        resultDiv.textContent = `Error: ${error.message}`;
    }
    resultDiv.classList.remove('hidden');
}

async function testSystemStatus() {
    const resultDiv = document.getElementById('healthResult');
    if (!resultDiv) return;
    
    try {
        const response = await fetch(`${API_BASE_URL}/api/v2/system/status`);
        const data = await response.json();
        resultDiv.className = 'mt-2 p-2 rounded bg-green-800';
        resultDiv.innerHTML = `
            <div class="font-semibold mb-2">System Status:</div>
            <div>Version: ${data.version || 'N/A'}</div>
            <div>Environment: ${data.environment || 'N/A'}</div>
            <div>Uptime: ${data.uptime || 'N/A'}</div>
            <div>Active Connections: ${data.active_connections || 'N/A'}</div>
            <div>Last Updated: ${new Date(data.timestamp).toLocaleString()}</div>
        `;
    } catch (error) {
        resultDiv.className = 'mt-2 p-2 rounded bg-red-800';
        resultDiv.textContent = `Error: ${error.message}`;
    }
    resultDiv.classList.remove('hidden');
}

async function getLivePatterns() {
    const resultDiv = document.getElementById('patternsResult');
    if (!resultDiv) return;
    
    try {
        const response = await fetch(`${API_BASE_URL}/api/v2/patterns/live`);
        const data = await response.json();
        resultDiv.className = 'mt-2 p-2 rounded bg-green-800';
        resultDiv.innerHTML = `
            <div class="font-semibold mb-2">Live Patterns:</div>
            <div>Total Patterns: ${data.total_count || 0}</div>
            <div>Active Patterns: ${data.active_patterns || 0}</div>
            <div>Last Updated: ${new Date(data.timestamp).toLocaleString()}</div>
            <div class="mt-2">
                <div class="font-semibold">Recent Patterns:</div>
                ${(data.patterns || []).slice(0, 3).map(pattern => `
                    <div class="mt-1">
                        <div>Symbol: ${pattern.symbol}</div>
                        <div>Type: ${pattern.type}</div>
                        <div>Confidence: ${pattern.confidence}%</div>
                    </div>
                `).join('')}
            </div>
        `;
    } catch (error) {
        resultDiv.className = 'mt-2 p-2 rounded bg-red-800';
        resultDiv.textContent = `Error: ${error.message}`;
    }
    resultDiv.classList.remove('hidden');
}

async function getPatternStats() {
    const resultDiv = document.getElementById('patternsResult');
    if (!resultDiv) return;
    
    try {
        const response = await fetch(`${API_BASE_URL}/api/v2/patterns/stats`);
        const data = await response.json();
        resultDiv.className = 'mt-2 p-2 rounded bg-green-800';
        resultDiv.innerHTML = `
            <div class="font-semibold mb-2">Pattern Statistics:</div>
            <div>Total Patterns: ${data.total_patterns || 0}</div>
            <div>Success Rate: ${data.success_rate || 0}%</div>
            <div>Average Confidence: ${data.avg_confidence || 0}%</div>
            <div>Last Updated: ${new Date(data.timestamp).toLocaleString()}</div>
        `;
    } catch (error) {
        resultDiv.className = 'mt-2 p-2 rounded bg-red-800';
        resultDiv.textContent = `Error: ${error.message}`;
    }
    resultDiv.classList.remove('hidden');
}

async function getWebSocketStatus() {
    const resultDiv = document.getElementById('wsStatusResult');
    if (!resultDiv) return;
    
    try {
        const response = await fetch(`${API_BASE_URL}/api/v2/system/websocket-status`);
        const data = await response.json();
        resultDiv.className = 'mt-2 p-2 rounded bg-green-800';
        resultDiv.innerHTML = `
            <div class="font-semibold mb-2">WebSocket Status:</div>
            <div>Server Status: ${data.server_status || 'N/A'}</div>
            <div>Active Connections: ${data.active_connections || 0}</div>
            <div>Last Updated: ${new Date(data.timestamp).toLocaleString()}</div>
        `;
    } catch (error) {
        resultDiv.className = 'mt-2 p-2 rounded bg-red-800';
        resultDiv.textContent = `Error: ${error.message}`;
    }
    resultDiv.classList.remove('hidden');
}

async function getSystemMetrics() {
    const resultDiv = document.getElementById('wsStatusResult');
    if (!resultDiv) return;
    
    try {
        const response = await fetch(`${API_BASE_URL}/api/v2/system/metrics`);
        const data = await response.json();
        resultDiv.className = 'mt-2 p-2 rounded bg-green-800';
        resultDiv.innerHTML = `
            <div class="font-semibold mb-2">System Metrics:</div>
            <div>CPU Usage: ${data.cpu_usage || 'N/A'}%</div>
            <div>Memory Usage: ${data.memory_usage || 'N/A'}%</div>
            <div>Active Threads: ${data.active_threads || 'N/A'}</div>
            <div>Last Updated: ${new Date(data.timestamp).toLocaleString()}</div>
        `;
    } catch (error) {
        resultDiv.className = 'mt-2 p-2 rounded bg-red-800';
        resultDiv.textContent = `Error: ${error.message}`;
    }
    resultDiv.classList.remove('hidden');
}

// Error handling
window.addEventListener('error', function(e) {
    console.log('Error handled gracefully:', e.error);
}); 