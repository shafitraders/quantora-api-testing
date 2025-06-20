import React from 'react';
import './Evolution.css';

const Evolution: React.FC = () => {
  return (
    <div className="evolution fade-in">
      <h1 className="page-title gradient-text">
        🔄 AI Evolution Pipeline
      </h1>
      
      <div className="evolution-grid">
        <div className="level-card glass-effect hover-lift level-0">
          <div className="level-header">
            <h3>Level 0: Foundation</h3>
            <div className="level-count">8</div>
          </div>
          <div className="level-description">
            Atomic market parameters extracted from multiple data sources. Foundation for all pattern evolution.
          </div>
          <div className="level-metric">100% Active</div>
        </div>
        
        <div className="level-card glass-effect hover-lift level-1">
          <div className="level-header">
            <h3>Level 1: Simple Patterns</h3>
            <div className="level-count">5</div>
          </div>
          <div className="level-description">
            AI-discovered combinations of 2-3 parameters with validated 65%+ success rates.
          </div>
          <div className="level-metric">82.1% Avg Success</div>
        </div>
        
        <div className="level-card glass-effect hover-lift level-2">
          <div className="level-header">
            <h3>Level 2: Meta-Patterns</h3>
            <div className="level-count">3</div>
          </div>
          <div className="level-description">
            Synthesized combinations of successful Level 1 patterns with 75%+ success rates.
          </div>
          <div className="level-metric">86.7% Avg Success</div>
        </div>
        
        <div className="level-card glass-effect hover-lift level-3">
          <div className="level-header">
            <h3>Level 3: Adaptive Intelligence</h3>
            <div className="level-count">2</div>
          </div>
          <div className="level-description">
            Self-modifying algorithms that adapt to market conditions with 85%+ success rates.
          </div>
          <div className="level-metric">84.8% Avg Success</div>
        </div>
      </div>
      
      <div className="ai-performance glass-effect">
        <h2>AI Engine Performance</h2>
        <div className="ai-grid">
          <div className="ai-engine">
            <h4>Llama-70B</h4>
            <div className="ai-score">85.2%</div>
            <div className="ai-label">Innovation: 94.1%</div>
          </div>
          <div className="ai-engine">
            <h4>Llama-30B</h4>
            <div className="ai-score">83.7%</div>
            <div className="ai-label">Innovation: 89.3%</div>
          </div>
          <div className="ai-engine">
            <h4>Claude-3.5</h4>
            <div className="ai-score">91.4%</div>
            <div className="ai-label">Validation Accuracy</div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Evolution; 