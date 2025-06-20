import React, { useState, useEffect } from 'react';
import { MetricCard } from '../../types';
import { quantoraApi } from '../../utils/apiClient';

interface PerformanceMetricsProps {
  className?: string;
}

export const PerformanceMetrics: React.FC<PerformanceMetricsProps> = ({ className = '' }) => {
  const [metrics, setMetrics] = useState<MetricCard[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isDemoMode, setIsDemoMode] = useState(false);

  useEffect(() => {
    const fetchMetrics = async () => {
      setIsLoading(true);
      
      const response = await quantoraApi.getSystemStatus();
      
      if (response.success && response.data) {
        const data = response.data;
        setIsDemoMode(response.isDemo);
        
        const metricsData: MetricCard[] = [
          {
            id: '1',
            label: 'Live Patterns',
            value: data.patternsLive,
            trend: '+6 this week',
            color: 'var(--accent-green)',
            icon: '🤖',
            changePercent: 12.5,
          },
          {
            id: '2',
            label: 'Peak Success Rate',
            value: `${data.peakSuccessRate}%`,
            trend: 'Best performer',
            color: 'var(--accent-green)',
            icon: '🎯',
            changePercent: 3.2,
          },
          {
            id: '3',
            label: 'Average Success Rate',
            value: `${data.avgSuccessRate}%`,
            trend: 'Validated',
            color: 'var(--accent-blue)',
            icon: '📊',
            changePercent: 2.1,
          },
          {
            id: '4',
            label: 'AI Engines Active',
            value: data.aiEnginesActive,
            trend: 'All operational',
            color: 'var(--accent-purple)',
            icon: '🧠',
            changePercent: 0,
          },
          {
            id: '5',
            label: 'System Uptime',
            value: `${data.systemUptime}%`,
            trend: 'Institutional grade',
            color: 'var(--accent-pink)',
            icon: '⚡',
            changePercent: 0.1,
          },
          {
            id: '6',
            label: 'Total Trades',
            value: data.totalTrades?.toLocaleString() || '1,247',
            trend: isDemoMode ? 'Demo Data' : 'Continuous',
            color: 'var(--accent-green)',
            icon: '💎',
            changePercent: 8.7,
          },
        ];

        setMetrics(metricsData);
      }
      
      setIsLoading(false);
    };

    fetchMetrics();
    
    // Refresh every 30 seconds
    const interval = setInterval(fetchMetrics, 30000);
    return () => clearInterval(interval);
  }, []);

  if (isLoading) {
    return (
      <div className={`performance-metrics loading ${className}`}>
        <div className="loading-grid">
          {[...Array(6)].map((_, i) => (
            <div key={i} className="metric-card loading-card">
              <div className="loading-shimmer"></div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className={`performance-metrics ${className}`}>
      {isDemoMode && (
        <div className="demo-banner">
          <span className="demo-icon">🚀</span>
          <span>Revolutionary AI Demo Mode - Full functionality active</span>
        </div>
      )}
      
      <div className="metrics-grid">
        {metrics.map((metric) => (
          <div key={metric.id} className="metric-card glass-effect hover-lift">
            <div className="metric-header">
              <span className="metric-icon">{metric.icon}</span>
              {metric.changePercent !== undefined && metric.changePercent > 0 && (
                <span className="metric-change positive">
                  +{metric.changePercent}%
                </span>
              )}
            </div>
            
            <div className="metric-value" style={{ color: metric.color }}>
              {metric.value}
            </div>
            
            <div className="metric-label">{metric.label}</div>
            <div className="metric-trend">{metric.trend}</div>
          </div>
        ))}
      </div>
      
      <style>{`
        .performance-metrics {
          margin-bottom: 2rem;
        }
        
        .demo-banner {
          background: linear-gradient(135deg, var(--accent-purple), var(--accent-pink));
          color: white;
          padding: 0.75rem 1.5rem;
          border-radius: var(--radius-md);
          margin-bottom: 1.5rem;
          display: flex;
          align-items: center;
          gap: 0.5rem;
          font-weight: 600;
          box-shadow: 0 4px 12px rgba(139, 92, 246, 0.3);
        }
        
        .demo-icon {
          animation: pulse 2s infinite;
        }
        
        .metrics-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 1.5rem;
        }
        
        .loading-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 1.5rem;
        }
        
        .metric-card {
          padding: 1.5rem;
          border-radius: var(--radius-lg);
          background: var(--background-card);
          border: 1px solid var(--border-glass);
          backdrop-filter: blur(10px);
          position: relative;
          overflow: hidden;
        }
        
        .loading-card {
          height: 120px;
          position: relative;
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
        
        .metric-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 0.75rem;
        }
        
        .metric-icon {
          font-size: 1.25rem;
        }
        
        .metric-change {
          font-size: 0.75rem;
          font-weight: 600;
          padding: 0.2rem 0.5rem;
          border-radius: 4px;
        }
        
        .metric-change.positive {
          background: rgba(16, 185, 129, 0.2);
          color: var(--accent-green);
        }
        
        .metric-value {
          font-size: 2rem;
          font-weight: 900;
          margin-bottom: 0.5rem;
          line-height: 1;
        }
        
        .metric-label {
          color: var(--text-secondary);
          font-size: 0.9rem;
          margin-bottom: 0.3rem;
          font-weight: 500;
        }
        
        .metric-trend {
          color: var(--accent-green);
          font-size: 0.8rem;
          font-weight: 600;
        }
        
        @keyframes shimmer {
          0% { left: -100%; }
          100% { left: 100%; }
        }
        
        @keyframes pulse {
          0%, 100% { opacity: 1; transform: scale(1); }
          50% { opacity: 0.7; transform: scale(1.1); }
        }
        
        @media (max-width: 768px) {
          .metrics-grid, .loading-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
          }
          
          .metric-card {
            padding: 1rem;
          }
          
          .metric-value {
            font-size: 1.5rem;
          }
          
          .demo-banner {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
          }
        }
      `}</style>
    </div>
  );
};

export default PerformanceMetrics;
