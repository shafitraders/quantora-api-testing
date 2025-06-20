import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import './Header.css';

interface SystemStatus {
  aiEnginesActive: number;
  patternsLive: number;
  peakSuccessRate: number;
  isConnected: boolean;
}

interface HeaderProps {
  systemStatus: SystemStatus;
}

const Header: React.FC<HeaderProps> = ({ systemStatus }) => {
  const location = useLocation();

  const navItems = [
    { path: '/', label: '📊 Dashboard', desc: 'Overview' },
    { path: '/tournament', label: '🏆 Tournament', desc: 'Live Competition' },
    { path: '/performance', label: '📈 Performance', desc: 'Analytics' },
    { path: '/evolution', label: '🔄 Evolution', desc: 'AI Pipeline' },
    { path: '/monitoring', label: '🔬 Monitoring', desc: 'Live Discovery' },
    { path: '/system-validation', label: '🔧 System Health', desc: 'Validation' }
  ];

  return (
    <header className="header">
      <div className="header-content">
        <Link to="/" className="logo">
          QUANTORA SYSTEMS
        </Link>
        
        <nav className="nav-menu">
          {navItems.map((item) => (
            <Link
              key={item.path}
              to={item.path}
              className={`nav-item ${location.pathname === item.path ? 'active' : ''}`}
            >
              <div>{item.label}</div>
              <div className="nav-desc">{item.desc}</div>
            </Link>
          ))}
        </nav>
        
        <div className="system-status">
          <div className="status-indicator">
            <div className={`status-dot ${systemStatus.isConnected ? 'connected' : 'demo'}`}></div>
            <span>AI Evolution: Active</span>
          </div>
          <div className="status-indicator">
            <div className="status-dot connected"></div>
            <span>{systemStatus.patternsLive} Patterns Live</span>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header; 