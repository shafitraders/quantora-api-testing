import React, { useState, useEffect } from 'react';
import { Routes, Route } from 'react-router-dom';
import './App.css';

// Components
import Header from './components/common/Header';
import { Dashboard } from './components/dashboard/Dashboard';
import Tournament from './pages/Tournament';
import Performance from './pages/Performance';
import Evolution from './pages/Evolution';
import Monitoring from './pages/Monitoring';
import SystemValidationPage from './pages/SystemValidation';

// Utils
import { quantoraApi } from './utils/apiClient';
import { SystemStatus } from './types';

const App: React.FC = () => {
  const [systemStatus, setSystemStatus] = useState<SystemStatus>({
    aiEnginesActive: 3,
    patternsLive: 50,
    peakSuccessRate: 88.5,
    avgSuccessRate: 75.23,
    totalTrades: 1247,
    systemUptime: 99.94,
    isConnected: false,
    isDemoMode: true,
    lastUpdate: new Date().toISOString(),
  });

  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const initializeApp = async () => {
      try {
        const response = await quantoraApi.getSystemStatus();
        
        if (response.success && response.data) {
          setSystemStatus(prev => ({
            ...prev,
            ...response.data,
            isConnected: !response.isDemo,
            isDemoMode: response.isDemo,
          }));
        }
      } catch (error) {
        console.log('App initialization: Using demo data');
      } finally {
        setIsLoading(false);
      }
    };

    initializeApp();

    // Update system status every 30 seconds
    const interval = setInterval(async () => {
      try {
        const response = await quantoraApi.getSystemStatus();
        if (response.success && response.data) {
          setSystemStatus(prev => ({
            ...prev,
            ...response.data,
            isConnected: !response.isDemo,
            isDemoMode: response.isDemo,
          }));
        }
      } catch (error) {
        console.log('Status update failed, maintaining current state');
      }
    }, 30000);

    return () => clearInterval(interval);
  }, []);

  if (isLoading) {
    return (
      <div className="app-loading">
        <div className="loading-container">
          <div className="quantora-logo-loading">QUANTORA</div>
          <div className="loading-spinner"></div>
          <div className="loading-message">
            Initializing Revolutionary AI Intelligence...
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="app">
      <Header systemStatus={systemStatus} />
      
      <main className="main-content">
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/tournament" element={<Tournament />} />
          <Route path="/performance" element={<Performance />} />
          <Route path="/evolution" element={<Evolution />} />
          <Route path="/monitoring" element={<Monitoring />} />
          <Route path="/system-validation" element={<SystemValidationPage />} />
        </Routes>
      </main>
      
      <style>
        {`
          .app {
            min-height: 100vh;
            background: var(--background-dark);
            color: var(--text-primary);
          }
          
          .app-loading {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: var(--background-dark);
          }
          
          .loading-container {
            text-align: center;
            padding: 2rem;
          }
          
          .quantora-logo-loading {
            font-size: 3rem;
            font-weight: 900;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 2rem;
            letter-spacing: -2px;
          }
          
          .loading-spinner {
            width: 50px;
            height: 50px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: var(--accent-purple);
            animation: spin 1s ease-in-out infinite;
            margin: 0 auto 2rem;
          }
          
          .loading-message {
            color: var(--text-secondary);
            font-size: 1.1rem;
            font-style: italic;
          }
          
          .main-content {
            padding-top: 80px; /* Account for fixed header */
          }
          
          @keyframes spin {
            to { transform: rotate(360deg); }
          }
          
          @media (max-width: 768px) {
            .quantora-logo-loading {
              font-size: 2rem;
            }
            
            .loading-message {
              font-size: 1rem;
            }
          }
        `}
      </style>
    </div>
  );
};

export default App; 