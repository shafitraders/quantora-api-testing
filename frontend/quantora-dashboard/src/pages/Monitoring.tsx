import React from 'react';

const Monitoring: React.FC = () => {
  return (
    <div className="monitoring fade-in">
      <div className="container">
        <h1 className="page-title gradient-text">
          🔬 Live AI Monitoring
        </h1>
        <p className="page-subtitle">
          Real-time intelligence monitoring and system performance analytics
        </p>
        
        <div className="monitoring-grid">
          <div className="monitoring-card glass-effect">
            <h2>🤖 AI Engine Status</h2>
            <div className="monitoring-feed">
              <div className="monitor-item">
                <div className="monitor-header">
                  <span className="monitor-title">🧠 Neural Network Activity</span>
                  <span className="monitor-time">Live</span>
                </div>
                <p>All 3 AI engines operating at optimal performance - discovery rate: 2.3 patterns/day</p>
                <div className="monitor-metrics">
                  <span className="metric-tag">CPU: 78%</span>
                  <span className="metric-tag">Memory: 12.4GB</span>
                  <span className="metric-tag">GPU: 89%</span>
                </div>
              </div>
              
              <div className="monitor-item">
                <div className="monitor-header">
                  <span className="monitor-title">📊 Performance Update</span>
                  <span className="monitor-time">1 min ago</span>
                </div>
                <p>API response time: 67ms avg | WebSocket latency: 12ms | System uptime: 99.9%</p>
                <div className="monitor-metrics">
                  <span className="metric-tag success">Response: 67ms</span>
                  <span className="metric-tag info">Uptime: 99.9%</span>
                </div>
              </div>
              
              <div className="monitor-item">
                <div className="monitor-header">
                  <span className="monitor-title">🔬 Pattern Validation</span>
                  <span className="monitor-time">3 min ago</span>
                </div>
                <p>Cross-validation completed on 3 new patterns - 2 approved, 1 requires improvement</p>
                <div className="monitor-metrics">
                  <span className="metric-tag success">Approved: 2</span>
                  <span className="metric-tag warning">Pending: 1</span>
                </div>
              </div>
              
              <div className="monitor-item">
                <div className="monitor-header">
                  <span className="monitor-title">⚡ Real-time Discovery</span>
                  <span className="monitor-time">5 min ago</span>
                </div>
                <p>Llama-70B discovered novel cross-correlation pattern with 87.3% validation score</p>
                <div className="monitor-metrics">
                  <span className="metric-tag accent">Innovation: High</span>
                  <span className="metric-tag success">Score: 87.3%</span>
                </div>
              </div>
            </div>
          </div>
          
          <div className="stats-card glass-effect">
            <h2>📈 System Statistics</h2>
            <div className="stats-grid">
              <div className="stat-item">
                <div className="stat-icon">🔥</div>
                <div className="stat-content">
                  <div className="stat-value">4</div>
                  <div className="stat-label">Discovered Today</div>
                </div>
              </div>
              
              <div className="stat-item">
                <div className="stat-icon">⏳</div>
                <div className="stat-content">
                  <div className="stat-value">3</div>
                  <div className="stat-label">Validation Queue</div>
                </div>
              </div>
              
              <div className="stat-item">
                <div className="stat-icon">📊</div>
                <div className="stat-content">
                  <div className="stat-value">2.3/day</div>
                  <div className="stat-label">Discovery Rate</div>
                </div>
              </div>
              
              <div className="stat-item">
                <div className="stat-icon">🧠</div>
                <div className="stat-content">
                  <div className="stat-value">94.2%</div>
                  <div className="stat-label">AI Efficiency</div>
                </div>
              </div>
              
              <div className="stat-item">
                <div className="stat-icon">⚔️</div>
                <div className="stat-content">
                  <div className="stat-value">247</div>
                  <div className="stat-label">Battles Today</div>
                </div>
              </div>
              
              <div className="stat-item">
                <div className="stat-icon">🚀</div>
                <div className="stat-content">
                  <div className="stat-value">99.9%</div>
                  <div className="stat-label">System Uptime</div>
                </div>
              </div>
            </div>
            
            <div className="system-health">
              <h3>🏥 System Health</h3>
              <div className="health-items">
                <div className="health-item">
                  <span className="health-label">Backend Connection</span>
                  <span className="health-status healthy">🟢 Optimal</span>
                </div>
                <div className="health-item">
                  <span className="health-label">AI Engine Cluster</span>
                  <span className="health-status healthy">🟢 All Active</span>
                </div>
                <div className="health-item">
                  <span className="health-label">Data Pipeline</span>
                  <span className="health-status healthy">🟢 Flowing</span>
                </div>
                <div className="health-item">
                  <span className="health-label">Pattern Database</span>
                  <span className="health-status healthy">🟢 Synchronized</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <style>
        {`
          .monitoring {
            padding: 2rem;
            min-height: calc(100vh - 80px);
          }
          
          .page-title {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            text-align: center;
          }
          
          .page-subtitle {
            font-size: 1.1rem;
            color: var(--text-secondary);
            text-align: center;
            margin-bottom: 3rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
          }
          
          .monitoring-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            max-width: 1400px;
            margin: 0 auto;
          }
          
          .monitoring-card,
          .stats-card {
            padding: 2rem;
            border-radius: var(--radius-lg);
          }
          
          .monitoring-card h2,
          .stats-card h2 {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
          }
          
          .monitoring-feed {
            display: flex;
            flex-direction: column;
            gap: 1rem;
          }
          
          .monitor-item {
            padding: 1.2rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius-md);
            border: 1px solid var(--border-glass);
            transition: all var(--transition-base);
          }
          
          .monitor-item:hover {
            background: rgba(255, 255, 255, 0.08);
            transform: translateX(5px);
          }
          
          .monitor-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.75rem;
          }
          
          .monitor-title {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.95rem;
          }
          
          .monitor-time {
            font-size: 0.8rem;
            color: var(--text-secondary);
            background: rgba(255, 255, 255, 0.1);
            padding: 0.2rem 0.6rem;
            border-radius: 12px;
          }
          
          .monitor-item p {
            color: var(--text-secondary);
            font-size: 0.9rem;
            line-height: 1.4;
            margin-bottom: 0.75rem;
          }
          
          .monitor-metrics {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
          }
          
          .metric-tag {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.3rem 0.6rem;
            border-radius: 4px;
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
          }
          
          .metric-tag.success {
            background: rgba(16, 185, 129, 0.2);
            color: var(--accent-green);
          }
          
          .metric-tag.warning {
            background: rgba(245, 158, 11, 0.2);
            color: var(--accent-orange);
          }
          
          .metric-tag.info {
            background: rgba(6, 182, 212, 0.2);
            color: var(--accent-blue);
          }
          
          .metric-tag.accent {
            background: rgba(139, 92, 246, 0.2);
            color: var(--accent-purple);
          }
          
          .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 2rem;
          }
          
          .stat-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius-md);
            border: 1px solid var(--border-glass);
            transition: all var(--transition-base);
          }
          
          .stat-item:hover {
            background: rgba(255, 255, 255, 0.08);
            transform: translateY(-2px);
          }
          
          .stat-icon {
            font-size: 1.5rem;
            flex-shrink: 0;
          }
          
          .stat-content {
            flex: 1;
          }
          
          .stat-value {
            font-size: 1.2rem;
            font-weight: 900;
            color: var(--accent-green);
            margin-bottom: 0.2rem;
            display: block;
          }
          
          .stat-label {
            font-size: 0.8rem;
            color: var(--text-secondary);
            font-weight: 500;
          }
          
          .system-health {
            margin-top: 1rem;
          }
          
          .system-health h3 {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--text-primary);
          }
          
          .health-items {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
          }
          
          .health-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius-md);
          }
          
          .health-label {
            font-size: 0.85rem;
            color: var(--text-secondary);
          }
          
          .health-status {
            font-size: 0.8rem;
            font-weight: 600;
          }
          
          .health-status.healthy {
            color: var(--accent-green);
          }
          
          @media (max-width: 1024px) {
            .monitoring-grid {
              grid-template-columns: 1fr;
            }
          }
          
          @media (max-width: 768px) {
            .stats-grid {
              grid-template-columns: 1fr;
            }
            
            .stat-item {
              flex-direction: column;
              text-align: center;
              gap: 0.5rem;
            }
          }
        `}
      </style>
    </div>
  );
};

export default Monitoring; 