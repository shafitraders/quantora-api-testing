import React from 'react';
import './Tournament.css';

const Tournament: React.FC = () => {
  const patterns = [
    { rank: 1, name: "Meta Whale Activity Intelligence", success: 88.5, sharpe: 1.89, level: 2, status: "CHAMPION" },
    { rank: 2, name: "Active Network Flow Pattern", success: 86.3, sharpe: 1.67, level: 1, status: "LIVE" },
    { rank: 3, name: "Exchange Flow RSI Confluence", success: 84.9, sharpe: 1.73, level: 1, status: "LIVE" },
    { rank: 4, name: "MVRV Sentiment Fusion", success: 83.1, sharpe: 1.52, level: 1, status: "LIVE" },
    { rank: 5, name: "Whale MVRV Confluence", success: 82.8, sharpe: 1.61, level: 1, status: "LIVE" }
  ];

  return (
    <div className="tournament fade-in">
      <h1 className="page-title gradient-text">
        🏆 Pattern Tournament Arena
      </h1>
      
      <div className="tournament-card glass-effect">
        <h2>Live Competition Leaderboard</h2>
        
        <div className="tournament-table">
          <div className="table-header">
            <div>Rank</div>
            <div>Pattern Name</div>
            <div>Success Rate</div>
            <div>Sharpe Ratio</div>
            <div>Level</div>
            <div>Status</div>
          </div>
          
          {patterns.map((pattern) => (
            <div key={pattern.rank} className="table-row hover-lift">
              <div className="rank">#{pattern.rank}</div>
              <div className="pattern-name">
                <div className="name">{pattern.name}</div>
                <div className="category">Level {pattern.level} • AI Pattern</div>
              </div>
              <div className="success-rate">{pattern.success}%</div>
              <div className="sharpe-ratio">{pattern.sharpe}</div>
              <div className="level">Level {pattern.level}</div>
              <div className="status">
                <span className={`status-badge ${pattern.status.toLowerCase()}`}>
                  {pattern.status}
                </span>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Tournament; 