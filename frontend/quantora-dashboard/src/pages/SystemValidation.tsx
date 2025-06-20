import React from 'react';
import { SystemValidation } from '../components/system_validation';

const SystemValidationPage: React.FC = () => {
  return (
    <div className="system-validation-page">
      <div className="page-header">
        <h1 className="page-title">
          🔧 System Health & Validation
        </h1>
        <p className="page-subtitle">
          Comprehensive system diagnostics and health monitoring
        </p>
      </div>
      
      <SystemValidation />
      
      <style>{`
        .system-validation-page {
          max-width: 1400px;
          margin: 0 auto;
          padding: 2rem;
          min-height: calc(100vh - 80px);
        }
        
        .page-header {
          text-align: center;
          margin-bottom: 2rem;
          padding: 2rem;
          background: rgba(255, 255, 255, 0.05);
          border-radius: var(--radius-lg);
          border-left: 4px solid var(--accent-purple);
        }
        
        .page-title {
          font-size: 2.5rem;
          font-weight: 900;
          margin-bottom: 0.5rem;
          background: var(--primary-gradient);
          -webkit-background-clip: text;
          background-clip: text;
          -webkit-text-fill-color: transparent;
          line-height: 1.2;
        }
        
        .page-subtitle {
          color: var(--text-secondary);
          font-size: 1.1rem;
          max-width: 600px;
          margin: 0 auto;
          line-height: 1.4;
        }
        
        @media (max-width: 768px) {
          .system-validation-page {
            padding: 1rem;
          }
          
          .page-title {
            font-size: 2rem;
          }
          
          .page-subtitle {
            font-size: 1rem;
          }
        }
      `}</style>
    </div>
  );
};

export default SystemValidationPage; 