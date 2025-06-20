import React from 'react';
import './Performance.css';

const Performance: React.FC = () => {
  return (
    <div className="performance fade-in">
      <h1 className="page-title gradient-text">
        📈 Performance Analytics
      </h1>
      
      <div className="performance-grid">
        <div className="performance-card glass-effect hover-lift">
          <h3>Portfolio Performance</h3>
          <div className="metrics-grid">
            <div className="metric">
              <div className="value success">75.2%</div>
              <div className="label">Average Success Rate</div>
            </div>
            <div className="metric">
              <div className="value info">1.55</div>
              <div className="label">Average Sharpe Ratio</div>
            </div>
            <div className="metric">
              <div className="value warning">4.5%</div>
              <div className="label">Average Max Drawdown</div>
            </div>
            <div className="metric">
              <div className="value accent">50</div>
              <div className="label">Live Patterns</div>
            </div>
          </div>
        </div>
        
        <div className="performance-card glass-effect hover-lift">
          <h3>vs Renaissance Technologies</h3>
          <div className="comparison-table">
            <div className="comparison-header">
              <div>Metric</div>
              <div>Renaissance</div>
              <div>Quantora</div>
              <div>Winner</div>
            </div>
            <div className="comparison-row">
              <div>Success Rate</div>
              <div className="renaissance">~35%</div>
              <div className="quantora">88.5%</div>
              <div className="winner quantora-win">✅ QUANTORA</div>
            </div>
            <div className="comparison-row">
              <div>Sharpe Ratio</div>
              <div className="renaissance">~1.5-2.0</div>
              <div className="quantora">1.89</div>
              <div className="winner tie">🤝 TIE</div>
            </div>
            <div className="comparison-row">
              <div>Max Drawdown</div>
              <div className="renaissance">~20%</div>
              <div className="quantora">3.2%</div>
              <div className="winner quantora-win">✅ QUANTORA</div>
            </div>
          </div>
          
          <div className="victory-banner">
            <div className="victory-text">🏆 QUANTORA WINS: 2/3 METRICS</div>
            <div className="victory-quote">"Innovation distinguishes between a leader and a follower"</div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Performance; 