# Quantora Trading Dashboard

A revolutionary AI trading intelligence dashboard that provides real-time monitoring of trading patterns, system health, and WebSocket connections.

## Features

- Real-time pattern monitoring
- WebSocket connection status
- System health metrics
- API endpoint testing
- Beautiful particle effects
- Responsive design

## Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)
- Backend server running on port 8000

## Installation

1. Clone the repository:
```bash
git clone https://github.com/your-org/quantora-dashboard.git
cd quantora-dashboard
```

2. Install dependencies:
```bash
npm install
```

3. Start the dashboard:
```bash
node server.js
```

The dashboard will be available at http://localhost:3000

## Usage

### API Testing

The dashboard provides several API testing endpoints:

- Health Check: Monitor system health
- System Status: View system metrics
- Pattern Discovery: View live trading patterns
- WebSocket Status: Monitor WebSocket connections

### WebSocket Testing

1. Click "Connect" to establish a WebSocket connection
2. Send test messages using the message input
3. View connection status and message logs
4. Monitor real-time pattern updates

## Development

### Project Structure

```
quantora-dashboard/
├── index.html          # Main dashboard page
├── styles.css          # Custom styles
├── app.js             # Dashboard functionality
├── server.js          # Express server
└── package.json       # Project configuration
```

### Adding New Features

1. Add new API endpoints in `app.js`
2. Update UI components in `index.html`
3. Add custom styles in `styles.css`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License - see LICENSE file for details 