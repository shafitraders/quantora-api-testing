import React, { useState, useEffect } from 'react';
import { PerformanceMetrics } from './PerformanceMetrics';
import { PatternList } from './PatternList';
import { AlertList } from './AlertList';
import { quantoraApi } from '../../utils/apiClient';

interface DashboardProps {
  className?: string;
}

export const Dashboard: React.FC<DashboardProps> = ({ className = '' }) => {
  const [connectionStatus, setConnectionStatus] = useState({
    isConnected: false,
    isDemoMode: true,
  });

  useEffect(() => {
    // Monitor connection status
    const checkConnection = () => {
      const status = quantoraApi.getConnectionStatus();
      setConnectionStatus(status);
    };

    checkConnection();
    const interval = setInterval(checkConnection, 10000);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className={`dashboard-container ${className}`}>
      <div className="dashboard-header">
        <div className="title-section">
          <h1 className="dashboard-title gradient-text">
            🚀 Quantora AI Intelligence Command Center
          </h1>
          <p className="dashboard-subtitle">
            Revolutionary AI that discovers patterns beyond human imagination
          </p>
        </div>
        
        <div className="status-section">
          <div className={`connection-status ${connectionStatus.isConnected ? 'connected' : 'demo'}`}>
            <div className="status-indicator">
              <div className="status-dot"></div>
              <span className="status-text">
                {connectionStatus.isConnected ? 'Live Backend' : 'Demo Mode'}
              </span>
            </div>
            {connectionStatus.isDemoMode && (
              <div className="demo-badge">
                <span>🎯 Full Demo Functionality</span>
              </div>
            )}
          </div>
        </div>
      </div>
      
      <div className="dashboard-quote">
        <blockquote>
          "Innovation distinguishes between a leader and a follower"
        </blockquote>
        <cite>— Steve Jobs</cite>
      </div>
      
      <div className="dashboard-content">
        <PerformanceMetrics />
        
        <div className="dashboard-grid">
          <div className="left-column">
            <PatternList />
          </div>
          
          <div className="right-column">
            <AlertList />
          </div>
        </div>
      </div>
      
      <div className="dashboard-footer">
        <div className="achievement-banner glass-effect">
          <div className="achievement-content">
            <div className="achievement-icon">🏆</div>
            <div className="achievement-text">
              <div className="achievement-title">Historic Achievement Unlocked</div>
              <div className="achievement-description">
                50 patterns with 75-88% success rates • Institutional validation complete
              </div>
            </div>
            <div className="achievement-stats">
              <div className="stat">
                <span className="stat-value">89%</span>
                <span className="stat-label">Approval Rate</span>
              </div>
              <div className="stat">
                <span className="stat-value">90.76%</span>
                <span className="stat-label">Stability Score</span>
              </div>
              <div className="stat">
                <span className="stat-value">∞</span>
                <span className="stat-label">Evolution</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <style>{`
        .dashboard-container {
          max-width: 1400px;
          margin: 0 auto;
          padding: 2rem;
          min-height: 100vh;
        }
        
        .dashboard-header {
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          margin-bottom: 2rem;
          flex-wrap: wrap;
          gap: 1.5rem;
        }
        
        .title-section {
          flex: 1;
        }
        
        .dashboard-title {
          font-size: 2.5rem;
          font-weight: 900;
          margin-bottom: 0.5rem;
          background: var(--primary-gradient);
          -webkit-background-clip: text;
          background-clip: text;
          -webkit-text-fill-color: transparent;
          line-height: 1.2;
        }
        
        .dashboard-subtitle {
          color: var(--text-secondary);
          font-size: 1.1rem;
          max-width: 600px;
          line-height: 1.4;
        }
        
        .status-section {
          display: flex;
          flex-direction: column;
          gap: 0.5rem;
          align-items: flex-end;
        }
        
        .connection-status {
          display: flex;
          flex-direction: column;
          gap: 0.5rem;
          align-items: flex-end;
        }
        
        .status-indicator {
          display: flex;
          align-items: center;
          gap: 0.5rem;
          padding: 0.6rem 1rem;
          background: var(--background-card);
          border: 1px solid var(--border-glass);
          border-radius: 25px;
          backdrop-filter: blur(10px);
        }
        
        .status-dot {
          width: 8px;
          height: 8px;
          border-radius: 50%;
          animation: pulse 2s infinite;
        }
        
        .connection-status.connected .status-dot {
          background: var(--accent-green);
        }
        
        .connection-status.demo .status-dot {
          background: var(--accent-purple);
        }
        
        .status-text {
          font-size: 0.9rem;
          font-weight: 600;
          color: var(--text-primary);
        }
        
        .demo-badge {
          background: linear-gradient(135deg, var(--accent-purple), var(--accent-pink));
          color: white;
          padding: 0.4rem 0.8rem;
          border-radius: 15px;
          font-size: 0.8rem;
          font-weight: 600;
          animation: glow 3s ease-in-out infinite alternate;
        }
        
        .dashboard-quote {
          text-align: center;
          margin-bottom: 3rem;
          padding: 1.5rem;
          background: rgba(255, 255, 255, 0.05);
          border-radius: var(--radius-lg);
          border-left: 4px solid var(--accent-purple);
        }
        
        .dashboard-quote blockquote {
          font-size: 1.2rem;
          font-style: italic;
          color: var(--text-primary);
          margin-bottom: 0.5rem;
          font-weight: 500;
        }
        
        .dashboard-quote cite {
          color: var(--text-secondary);
          font-size: 0.9rem;
        }
        
        .dashboard-content {
          margin-bottom: 3rem;
        }
        
        .dashboard-grid {
          display: grid;
          grid-template-columns: 2fr 1fr;
          gap: 2rem;
        }
        
        .left-column,
        .right-column {
          display: flex;
          flex-direction: column;
        }
        
        .dashboard-footer {
          margin-top: 3rem;
        }
        
        .achievement-banner {
          background: var(--background-card);
          border: 1px solid var(--border-glass);
          border-radius: var(--radius-lg);
          padding: 2rem;
          backdrop-filter: blur(10px);
          position: relative;
          overflow: hidden;
        }
        
        .achievement-banner::before {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          height: 3px;
          background: linear-gradient(90deg, var(--accent-green), var(--accent-blue), var(--accent-purple), var(--accent-pink));
          animation: rainbow 3s linear infinite;
        }
        
        .achievement-content {
          display: flex;
          align-items: center;
          gap: 1.5rem;
        }
        
        .achievement-icon {
          font-size: 3rem;
          animation: bounce 2s ease-in-out infinite;
        }
        
        .achievement-text {
          flex: 1;
        }
        
        .achievement-title {
          font-size: 1.3rem;
          font-weight: 700;
          color: var(--text-primary);
          margin-bottom: 0.5rem;
        }
        
        .achievement-description {
          color: var(--text-secondary);
          font-size: 0.95rem;
          line-height: 1.4;
        }
        
        .achievement-stats {
          display: flex;
          gap: 2rem;
        }
        
        .stat {
          display: flex;
          flex-direction: column;
          align-items: center;
          text-align: center;
        }
        
        .stat-value {
          font-size: 1.5rem;
          font-weight: 900;
          color: var(--accent-green);
          margin-bottom: 0.2rem;
        }
        
        .stat-label {
          font-size: 0.8rem;
          color: var(--text-secondary);
          font-weight: 500;
        }
        
        @keyframes pulse {
          0%, 100% { opacity: 1; transform: scale(1); }
          50% { opacity: 0.7; transform: scale(1.2); }
        }
        
        @keyframes glow {
          0% { box-shadow: 0 0 5px rgba(139, 92, 246, 0.5); }
          100% { box-shadow: 0 0 20px rgba(236, 72, 153, 0.5); }
        }
        
        @keyframes rainbow {
          0% { background-position: 0% 50%; }
          100% { background-position: 100% 50%; }
        }
        
        @keyframes bounce {
          0%, 100% { transform: translateY(0); }
          50% { transform: translateY(-10px); }
        }
        
        @media (max-width: 1024px) {
          .dashboard-grid {
            grid-template-columns: 1fr;
          }
          
          .achievement-content {
            flex-direction: column;
            text-align: center;
          }
          
          .achievement-stats {
            justify-content: center;
          }
        }
        
        @media (max-width: 768px) {
          .dashboard-container {
            padding: 1rem;
          }
          
          .dashboard-header {
            flex-direction: column;
            align-items: flex-start;
          }
          
          .status-section {
            align-items: flex-start;
            width: 100%;
          }
          
          .dashboard-title {
            font-size: 2rem;
          }
          
          .dashboard-subtitle {
            font-size: 1rem;
          }
          
          .dashboard-quote {
            padding: 1rem;
          }
          
          .dashboard-quote blockquote {
            font-size: 1rem;
          }
          
          .achievement-banner {
            padding: 1.5rem;
          }
          
          .achievement-stats {
            gap: 1rem;
          }
        }
      `}</style>
    </div>
  );
};

export default Dashboard;
