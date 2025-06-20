import React, { useState, useEffect } from 'react';
import { Pattern } from '../../types';
import { quantoraApi } from '../../utils/apiClient';

interface PatternListProps {
  className?: string;
}

export const PatternList: React.FC<PatternListProps> = ({ className = '' }) => {
  const [patterns, setPatterns] = useState<Pattern[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [selectedPattern, setSelectedPattern] = useState<Pattern | null>(null);

  useEffect(() => {
    const fetchPatterns = async () => {
      setIsLoading(true);
      
      const response = await quantoraApi.getLivePatterns();
      
      if (response.success && response.data) {
        setPatterns(response.data.patterns.slice(0, 5)); // Top 5 patterns
      }
      
      setIsLoading(false);
    };

    fetchPatterns();
    
    // Refresh every 60 seconds
    const interval = setInterval(fetchPatterns, 60000);
    return () => clearInterval(interval);
  }, []);

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'CHAMPION': return 'var(--accent-green)';
      case 'LIVE': return 'var(--accent-blue)';
      case 'TESTING': return 'var(--accent-purple)';
      default: return 'var(--text-secondary)';
    }
  };

  const getLevelColor = (level: number) => {
    switch (level) {
      case 0: return 'var(--text-secondary)';
      case 1: return 'var(--accent-blue)';
      case 2: return 'var(--accent-purple)';
      case 3: return 'var(--accent-pink)';
      default: return 'var(--text-secondary)';
    }
  };

  if (isLoading) {
    return (
      <div className={`pattern-list loading ${className}`}>
        <h2 className="section-title">🏆 Top Performing Patterns</h2>
        <div className="patterns-container glass-effect">
          {[...Array(5)].map((_, i) => (
            <div key={i} className="pattern-row loading-row">
              <div className="loading-shimmer"></div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className={`pattern-list ${className}`}>
      <h2 className="section-title">🏆 Championship Leaderboard</h2>
      
      <div className="patterns-container glass-effect">
        <div className="pattern-header">
          <div>Rank</div>
          <div>Pattern Intelligence</div>
          <div>Success Rate</div>
          <div>Sharpe</div>
          <div>Status</div>
        </div>
        
        {patterns.map((pattern, index) => (
          <div 
            key={pattern.id} 
            className="pattern-row hover-lift"
            onClick={() => setSelectedPattern(pattern)}
          >
            <div className="rank">
              <span className="rank-number">#{index + 1}</span>
              {index === 0 && <span className="crown">👑</span>}
            </div>
            
            <div className="pattern-info">
              <div className="pattern-name">{pattern.name}</div>
              <div className="pattern-details">
                <span className="pattern-category">{pattern.category}</span>
                <span className="pattern-creator">• {pattern.aiCreator}</span>
                <span 
                  className="pattern-level"
                  style={{ color: getLevelColor(pattern.level) }}
                >
                  • Level {pattern.level}
                </span>
              </div>
            </div>
            
            <div className="success-rate">
              <span className="rate-value" style={{ color: 'var(--accent-green)' }}>
                {pattern.successRate}%
              </span>
              <div className="win-streak">🔥 {pattern.winStreak || 0}</div>
            </div>
            
            <div className="sharpe-ratio" style={{ color: 'var(--accent-blue)' }}>
              {pattern.sharpeRatio}
            </div>
            
            <div className="status">
              <span 
                className="status-badge" 
                style={{ 
                  backgroundColor: getStatusColor(pattern.status),
                  color: pattern.status === 'CHAMPION' ? 'black' : 'white'
                }}
              >
                {pattern.status}
              </span>
            </div>
          </div>
        ))}
      </div>
      
      {selectedPattern && (
        <div className="pattern-modal" onClick={() => setSelectedPattern(null)}>
          <div className="modal-content" onClick={(e) => e.stopPropagation()}>
            <div className="modal-header">
              <h3>{selectedPattern.name}</h3>
              <button 
                className="close-btn"
                onClick={() => setSelectedPattern(null)}
              >
                ×
              </button>
            </div>
            
            <div className="modal-body">
              <div className="modal-metrics">
                <div className="modal-metric">
                  <span className="metric-label">Success Rate</span>
                  <span className="metric-value success">{selectedPattern.successRate}%</span>
                </div>
                <div className="modal-metric">
                  <span className="metric-label">Sharpe Ratio</span>
                  <span className="metric-value info">{selectedPattern.sharpeRatio}</span>
                </div>
                <div className="modal-metric">
                  <span className="metric-label">Max Drawdown</span>
                  <span className="metric-value warning">{selectedPattern.maxDrawdown}%</span>
                </div>
                <div className="modal-metric">
                  <span className="metric-label">Total Trades</span>
                  <span className="metric-value accent">{selectedPattern.totalTrades}</span>
                </div>
              </div>
              
              <div className="modal-info">
                <p><strong>AI Creator:</strong> {selectedPattern.aiCreator}</p>
                <p><strong>Evolution Level:</strong> {selectedPattern.level}</p>
                <p><strong>Category:</strong> {selectedPattern.category}</p>
                <p><strong>Validation Score:</strong> {selectedPattern.validationScore}%</p>
                <p><strong>Current Win Streak:</strong> {selectedPattern.winStreak} trades</p>
              </div>
            </div>
          </div>
        </div>
      )}
      
      <style>
        {`
          .pattern-list {
            margin-bottom: 2rem;
          }
          
          .section-title {
            color: var(--text-primary);
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
          }
          
          .patterns-container {
            border-radius: var(--radius-lg);
            overflow: hidden;
            background: var(--background-card);
            border: 1px solid var(--border-glass);
            backdrop-filter: blur(10px);
          }
          
          .pattern-header {
            display: grid;
            grid-template-columns: 80px 2fr 120px 80px 100px;
            gap: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            font-weight: 600;
            color: var(--accent-purple);
            font-size: 0.9rem;
            border-bottom: 1px solid var(--border-glass);
          }
          
          .pattern-row {
            display: grid;
            grid-template-columns: 80px 2fr 120px 80px 100px;
            gap: 1rem;
            padding: 1rem;
            border-bottom: 1px solid var(--border-glass);
            align-items: center;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
          }
          
          .pattern-row:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateX(5px);
          }
          
          .pattern-row:last-child {
            border-bottom: none;
          }
          
          .loading-row {
            height: 60px;
            position: relative;
            overflow: hidden;
          }
          
          .loading-shimmer {
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(
              90deg,
              transparent,
              rgba(255, 255, 255, 0.1),
              transparent
            );
            animation: shimmer 1.5s infinite;
          }
          
          .rank {
            display: flex;
            align-items: center;
            gap: 0.3rem;
          }
          
          .rank-number {
            font-weight: bold;
            color: var(--accent-purple);
            font-size: 1rem;
          }
          
          .crown {
            font-size: 1.2rem;
            animation: glow 2s ease-in-out infinite alternate;
          }
          
          .pattern-info {
            display: flex;
            flex-direction: column;
          }
          
          .pattern-name {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.3rem;
            font-size: 0.95rem;
          }
          
          .pattern-details {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
          }
          
          .pattern-category,
          .pattern-creator,
          .pattern-level {
            font-size: 0.8rem;
            color: var(--text-secondary);
          }
          
          .success-rate {
            display: flex;
            flex-direction: column;
            align-items: center;
          }
          
          .rate-value {
            font-weight: bold;
            font-size: 1rem;
            margin-bottom: 0.2rem;
          }
          
          .win-streak {
            font-size: 0.7rem;
            color: var(--accent-green);
            font-weight: 600;
          }
          
          .sharpe-ratio {
            font-weight: bold;
            font-size: 0.95rem;
            text-align: center;
          }
          
          .status-badge {
            padding: 0.3rem 0.6rem;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
          }
          
          .pattern-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            backdrop-filter: blur(10px);
          }
          
          .modal-content {
            background: var(--background-card);
            border: 1px solid var(--border-glass);
            border-radius: var(--radius-lg);
            width: 90%;
            max-width: 500px;
            max-height: 80vh;
            overflow-y: auto;
            backdrop-filter: blur(20px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
          }
          
          .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-glass);
          }
          
          .modal-header h3 {
            color: var(--text-primary);
            font-weight: 700;
            margin: 0;
          }
          
          .close-btn {
            background: none;
            border: none;
            color: var(--text-secondary);
            font-size: 1.5rem;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.2s ease;
          }
          
          .close-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
          }
          
          .modal-body {
            padding: 1.5rem;
          }
          
          .modal-metrics {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
          }
          
          .modal-metric {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius-md);
          }
          
          .modal-metric .metric-label {
            font-size: 0.8rem;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
          }
          
          .modal-metric .metric-value {
            font-size: 1.2rem;
            font-weight: bold;
          }
          
          .modal-metric .metric-value.success { color: var(--accent-green); }
          .modal-metric .metric-value.info { color: var(--accent-blue); }
          .modal-metric .metric-value.warning { color: var(--accent-pink); }
          .modal-metric .metric-value.accent { color: var(--accent-purple); }
          
          .modal-info {
            background: rgba(255, 255, 255, 0.05);
            padding: 1rem;
            border-radius: var(--radius-md);
          }
          
          .modal-info p {
            margin-bottom: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
          }
          
          .modal-info strong {
            color: var(--text-primary);
          }
          
          @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
          }
          
          @keyframes glow {
            0% { filter: drop-shadow(0 0 5px gold); }
            100% { filter: drop-shadow(0 0 15px gold); }
          }
          
          @media (max-width: 768px) {
            .pattern-header,
            .pattern-row {
              grid-template-columns: 50px 1fr 80px;
              font-size: 0.8rem;
            }
            
            .pattern-header div:nth-child(n+4),
            .pattern-row div:nth-child(n+4) {
              display: none;
            }
            
            .pattern-details {
              flex-direction: column;
              gap: 0.2rem;
            }
            
            .modal-metrics {
              grid-template-columns: 1fr;
            }
            
            .modal-content {
              width: 95%;
              margin: 1rem;
            }
          }
        `}
      </style>
    </div>
  );
};

export default PatternList; 