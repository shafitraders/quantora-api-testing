import React from 'react';
import './Dashboard.css';

const Dashboard: React.FC = () => {
  return (
    <div className="dashboard fade-in">
      <h1 className="page-title gradient-text">
        🚀 Live AI Trading Intelligence
      </h1>
      
      <div className="dashboard-grid">
        <div className="metric-card glass-effect hover-lift">
          <h3>Live Patterns</h3>
          <div className="metric-value">50</div>
          <p>Patterns Currently Trading</p>
        </div>
        
        <div className="metric-card glass-effect hover-lift">
          <h3>Peak Success Rate</h3>
          <div className="metric-value">88.5%</div>
          <p>Best Performing Pattern</p>
        </div>
        
        <div className="metric-card glass-effect hover-lift">
          <h3>Average Performance</h3>
          <div className="metric-value">75.2%</div>
          <p>Portfolio-wide Success Rate</p>
        </div>
        
        <div className="metric-card glass-effect hover-lift">
          <h3>AI Engines Active</h3>
          <div className="metric-value">3</div>
          <p>Competing for Discoveries</p>
        </div>
      </div>
      
      <div className="discovery-feed glass-effect">
        <h2>🔥 Live Pattern Discovery Feed</h2>
        <div className="feed-items">
          <div className="feed-item">
            <div className="feed-header">
              <span className="feed-title">🆕 Meta Whale Activity Pattern</span>
              <span className="feed-time">2 min ago</span>
            </div>
            <p>AI discovered advanced whale sentiment fusion with exceptional predictive power</p>
            <div className="feed-metrics">
              <span className="metric-badge">Success: 88.5%</span>
              <span className="metric-badge">Level: 2</span>
              <span className="metric-badge">AI: Llama-70B</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard; 