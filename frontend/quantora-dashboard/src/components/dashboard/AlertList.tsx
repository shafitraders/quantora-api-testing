import React, { useState, useEffect } from 'react';
import { Alert } from '../../types';
import { quantoraApi } from '../../utils/apiClient';

interface AlertListProps {
  className?: string;
}

export const AlertList: React.FC<AlertListProps> = ({ className = '' }) => {
  const [alerts, setAlerts] = useState<Alert[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [filter, setFilter] = useState<'all' | 'discovery' | 'success' | 'warning' | 'info'>('all');

  useEffect(() => {
    const fetchAlerts = async () => {
      setIsLoading(true);
      
      const response = await quantoraApi.getLiveAlerts();
      
      if (response.success && response.data) {
        setAlerts(response.data.alerts);
      }
      
      setIsLoading(false);
    };

    fetchAlerts();
    
    // Simulate new alerts in demo mode
    const interval = setInterval(() => {
      if (quantoraApi.getConnectionStatus().isDemoMode) {
        const newAlert: Alert = {
          id: Date.now().toString(),
          type: ['discovery', 'success', 'info'][Math.floor(Math.random() * 3)] as Alert['type'],
          title: 'AI Intelligence Update',
          message: `Pattern synthesis achieved ${(Math.random() * 20 + 75).toFixed(1)}% success rate`,
          timestamp: new Date(),
          isNew: true,
          priority: 'medium',
          source: ['Llama-70B', 'Llama-30B', 'Claude-3.5'][Math.floor(Math.random() * 3)]
        };

        setAlerts(prev => [newAlert, ...prev.slice(0, 9)]);

        // Remove "new" flag after 5 seconds
        setTimeout(() => {
          setAlerts(prev => prev.map(alert => 
            alert.id === newAlert.id ? { ...alert, isNew: false } : alert
          ));
        }, 5000);
      }
    }, 25000);

    return () => clearInterval(interval);
  }, []);

  const getAlertIcon = (type: Alert['type']) => {
    switch (type) {
      case 'discovery': return '🔬';
      case 'success': return '✅';
      case 'warning': return '⚠️';
      case 'error': return '❌';
      case 'info': return 'ℹ️';
      default: return '📢';
    }
  };

  const getAlertColor = (type: Alert['type']) => {
    switch (type) {
      case 'discovery': return 'var(--accent-purple)';
      case 'success': return 'var(--accent-green)';
      case 'warning': return 'var(--accent-blue)';
      case 'error': return 'var(--accent-pink)';
      case 'info': return 'var(--accent-blue)';
      default: return 'var(--text-secondary)';
    }
  };

  const getPriorityColor = (priority: Alert['priority']) => {
    switch (priority) {
      case 'critical': return 'var(--accent-pink)';
      case 'high': return 'var(--accent-purple)';
      case 'medium': return 'var(--accent-blue)';
      case 'low': return 'var(--text-secondary)';
      default: return 'var(--text-secondary)';
    }
  };

  const formatTimeAgo = (timestamp: Date) => {
    const now = new Date();
    const diffMs = now.getTime() - timestamp.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    
    if (diffMins < 1) return 'Just now';
    if (diffMins < 60) return `${diffMins}m ago`;
    if (diffHours < 24) return `${diffHours}h ago`;
    return `${Math.floor(diffHours / 24)}d ago`;
  };

  const filteredAlerts = filter === 'all' 
    ? alerts 
    : alerts.filter(alert => alert.type === filter);

  const alertFilters = [
    { key: 'all', label: 'All', count: alerts.length },
    { key: 'discovery', label: 'Discoveries', count: alerts.filter(a => a.type === 'discovery').length },
    { key: 'success', label: 'Success', count: alerts.filter(a => a.type === 'success').length },
    { key: 'info', label: 'Info', count: alerts.filter(a => a.type === 'info').length },
  ];

  if (isLoading) {
    return (
      <div className={`alert-list loading ${className}`}>
        <h2 className="section-title">🔔 Live Intelligence Feed</h2>
        <div className="alerts-container glass-effect">
          {[...Array(4)].map((_, i) => (
            <div key={i} className="alert-item loading-item">
              <div className="loading-shimmer"></div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className={`alert-list ${className}`}>
      <div className="alert-header">
        <h2 className="section-title">🔔 Live Intelligence Feed</h2>
        <div className="alert-filters">
          {alertFilters.map((filterItem) => (
            <button
              key={filterItem.key}
              className={`filter-btn ${filter === filterItem.key ? 'active' : ''}`}
              onClick={() => setFilter(filterItem.key as any)}
            >
              {filterItem.label} ({filterItem.count})
            </button>
          ))}
        </div>
      </div>
      
      <div className="alerts-container glass-effect">
        {filteredAlerts.length === 0 ? (
          <div className="no-alerts">
            <div className="no-alerts-icon">🔕</div>
            <div className="no-alerts-text">No alerts for selected filter</div>
          </div>
        ) : (
          filteredAlerts.map((alert) => (
            <div 
              key={alert.id} 
              className={`alert-item ${alert.isNew ? 'new-alert' : ''}`}
              style={{ borderLeftColor: getAlertColor(alert.type) }}
            >
              <div className="alert-main">
                <div className="alert-header-row">
                  <div className="alert-icon-title">
                    <span className="alert-icon">{getAlertIcon(alert.type)}</span>
                    <span className="alert-title">{alert.title}</span>
                  </div>
                  <div className="alert-meta">
                    <span 
                      className="alert-priority"
                      style={{ color: getPriorityColor(alert.priority) }}
                    >
                      {alert.priority.toUpperCase()}
                    </span>
                    <span className="alert-time">{formatTimeAgo(alert.timestamp)}</span>
                  </div>
                </div>
                
                <div className="alert-message">{alert.message}</div>
                
                <div className="alert-footer">
                  <span className="alert-source">Source: {alert.source}</span>
                  {alert.isNew && <div className="new-indicator">🔥 NEW</div>}
                </div>
              </div>
            </div>
          ))
        )}
      </div>
      
      <style>
        {`
          .alert-list {
            margin-bottom: 2rem;
          }
          
          .alert-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            gap: 1rem;
          }
          
          .section-title {
            color: var(--text-primary);
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
          }
          
          .alert-filters {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
          }
          
          .filter-btn {
            background: transparent;
            border: 1px solid var(--border-glass);
            color: var(--text-secondary);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
          }
          
          .filter-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
          }
          
          .filter-btn.active {
            background: var(--accent-purple);
            color: white;
            border-color: var(--accent-purple);
          }
          
          .alerts-container {
            border-radius: var(--radius-lg);
            background: var(--background-card);
            border: 1px solid var(--border-glass);
            max-height: 500px;
            overflow-y: auto;
            backdrop-filter: blur(10px);
          }
          
          .no-alerts {
            padding: 3rem 2rem;
            text-align: center;
            color: var(--text-secondary);
          }
          
          .no-alerts-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
          }
          
          .alert-item {
            padding: 1.2rem;
            border-bottom: 1px solid var(--border-glass);
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
            position: relative;
          }
          
          .alert-item:hover {
            background: rgba(255, 255, 255, 0.05);
          }
          
          .alert-item:last-child {
            border-bottom: none;
          }
          
          .alert-item.new-alert {
            background: rgba(255, 255, 255, 0.05);
            animation: slideInAlert 0.5s ease;
          }
          
          .loading-item {
            height: 80px;
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
          
          .alert-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 0.75rem;
          }
          
          .alert-icon-title {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex: 1;
          }
          
          .alert-icon {
            font-size: 1.1rem;
            flex-shrink: 0;
          }
          
          .alert-title {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.95rem;
            line-height: 1.3;
          }
          
          .alert-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 0.2rem;
            flex-shrink: 0;
          }
          
          .alert-priority {
            font-size: 0.7rem;
            font-weight: bold;
            letter-spacing: 0.5px;
          }
          
          .alert-time {
            font-size: 0.8rem;
            color: var(--text-secondary);
          }
          
          .alert-message {
            color: var(--text-secondary);
            font-size: 0.9rem;
            line-height: 1.4;
            margin-bottom: 0.75rem;
          }
          
          .alert-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
          }
          
          .alert-source {
            font-size: 0.8rem;
            color: var(--text-secondary);
            font-style: italic;
          }
          
          .new-indicator {
            background: linear-gradient(135deg, var(--accent-green), var(--accent-blue));
            color: white;
            padding: 0.2rem 0.6rem;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: bold;
            letter-spacing: 0.5px;
            animation: pulse 2s infinite;
          }
          
          @keyframes slideInAlert {
            from {
              opacity: 0;
              transform: translateX(-20px);
            }
            to {
              opacity: 1;
              transform: translateX(0);
            }
          }
          
          @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
          }
          
          @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.05); }
          }
          
          @media (max-width: 768px) {
            .alert-header {
              flex-direction: column;
              align-items: flex-start;
            }
            
            .alert-filters {
              width: 100%;
              justify-content: flex-start;
            }
            
            .filter-btn {
              font-size: 0.75rem;
              padding: 0.3rem 0.6rem;
            }
            
            .alerts-container {
              max-height: 400px;
            }
            
            .alert-item {
              padding: 1rem;
            }
            
            .alert-header-row {
              flex-direction: column;
              gap: 0.5rem;
            }
            
            .alert-meta {
              flex-direction: row;
              gap: 1rem;
            }
            
            .no-alerts {
              padding: 2rem 1rem;
            }
          }
        `}
      </style>
    </div>
  );
};

export default AlertList; 