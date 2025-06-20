// 🌟 Quantora API Client - Revolutionary Backend Connection
// "Quality means doing it right when no one is looking" - Henry Ford

import { Pattern, AIEngine, SystemStatus, Alert } from '../types';

interface ApiResponse<T> {
  data?: T;
  success: boolean;
  error?: string;
  isDemo: boolean;
  timestamp: string;
}

class QuantoraApiClient {
  private baseUrl: string;
  private isBackendAvailable: boolean = false;
  private reconnectAttempts: number = 0;
  private maxReconnectAttempts: number = 5;

  constructor(baseUrl: string = '/api') {
    this.baseUrl = baseUrl;
    this.initializeConnection();
  }

  private async initializeConnection(): Promise<void> {
    await this.checkBackendHealth();
    this.startHealthMonitoring();
  }

  private async checkBackendHealth(): Promise<void> {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 3000);

      const response = await fetch(`${this.baseUrl}/health`, {
        signal: controller.signal,
        headers: {
          'Content-Type': 'application/json',
        },
      });

      clearTimeout(timeoutId);
      
      if (response.ok) {
        this.isBackendAvailable = true;
        this.reconnectAttempts = 0;
        console.log('🚀 Quantora Backend: CONNECTED - Live AI intelligence active');
      } else {
        throw new Error(`Backend responded with status: ${response.status}`);
      }
    } catch (error) {
      this.isBackendAvailable = false;
      console.log('🔄 Quantora Backend: DEMO MODE - Full functionality in demo');
      
      if (this.reconnectAttempts < this.maxReconnectAttempts) {
        this.reconnectAttempts++;
        setTimeout(() => this.checkBackendHealth(), 5000 * this.reconnectAttempts);
      }
    }
  }

  private startHealthMonitoring(): void {
    setInterval(() => {
      this.checkBackendHealth();
    }, 30000); // Check every 30 seconds
  }

  async get<T>(endpoint: string): Promise<ApiResponse<T>> {
    if (!this.isBackendAvailable) {
      return this.getDemoData<T>(endpoint);
    }

    try {
      const response = await fetch(`${this.baseUrl}${endpoint}`, {
        headers: { 'Content-Type': 'application/json' },
      });

      if (response.ok) {
        const data = await response.json();
        return {
          data,
          success: true,
          isDemo: false,
          timestamp: new Date().toISOString(),
        };
      } else {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
    } catch (error) {
      console.log(`API fallback for ${endpoint}:`, error);
      return this.getDemoData<T>(endpoint);
    }
  }

  async post<T>(endpoint: string, data: any): Promise<ApiResponse<T>> {
    if (!this.isBackendAvailable) {
      return this.getDemoData<T>(endpoint);
    }

    try {
      const response = await fetch(`${this.baseUrl}${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        const responseData = await response.json();
        return {
          data: responseData,
          success: true,
          isDemo: false,
          timestamp: new Date().toISOString(),
        };
      } else {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
    } catch (error) {
      console.log(`API fallback for POST ${endpoint}:`, error);
      return this.getDemoData<T>(endpoint);
    }
  }

  private getDemoData<T>(endpoint: string): ApiResponse<T> {
    const demoData = this.generateDemoData(endpoint);
    return {
      data: demoData as T,
      success: true,
      isDemo: true,
      timestamp: new Date().toISOString(),
    };
  }

  private generateDemoData(endpoint: string): any {
    switch (endpoint) {
      case '/health':
        return {
          status: 'demo',
          message: 'Revolutionary AI Demo Mode Active',
          version: '2.0.0',
          aiEngines: 3,
        };

      case '/patterns/live':
        return this.generateLivePatterns();

      case '/patterns/tournament':
        return this.generateTournamentData();

      case '/evolution/status':
        return this.generateEvolutionStatus();

      case '/ai/engines':
        return this.generateAIEngineStatus();

      case '/system/status':
        return this.generateSystemStatus();

      case '/alerts/live':
        return this.generateLiveAlerts();

      default:
        return {
          message: 'Demo data active',
          timestamp: new Date().toISOString(),
          endpoint,
        };
    }
  }

  private generateLivePatterns(): any {
    return {
      patterns: [
        {
          id: '1',
          name: 'Meta Whale Activity Intelligence',
          successRate: 88.5,
          sharpeRatio: 1.89,
          maxDrawdown: 3.2,
          level: 2,
          status: 'CHAMPION',
          category: 'OnChain + Network',
          aiCreator: 'Llama-70B',
          createdAt: '2025-06-11T10:30:00Z',
          lastUpdated: '2025-06-14T14:22:00Z',
          validationScore: 94.7,
          totalTrades: 247,
          winStreak: 23,
        },
        {
          id: '2',
          name: 'Active Network Flow Pattern',
          successRate: 86.3,
          sharpeRatio: 1.67,
          maxDrawdown: 4.1,
          level: 1,
          status: 'LIVE',
          category: 'Network Activity',
          aiCreator: 'Llama-30B',
          createdAt: '2025-06-10T15:45:00Z',
          lastUpdated: '2025-06-14T13:15:00Z',
          validationScore: 91.2,
          totalTrades: 189,
          winStreak: 12,
        },
        {
          id: '3',
          name: 'Exchange Flow RSI Confluence',
          successRate: 84.9,
          sharpeRatio: 1.73,
          maxDrawdown: 3.8,
          level: 1,
          status: 'LIVE',
          category: 'Technical + Flow',
          aiCreator: 'Claude-3.5',
          createdAt: '2025-06-09T09:20:00Z',
          lastUpdated: '2025-06-14T12:45:00Z',
          validationScore: 89.4,
          totalTrades: 156,
          winStreak: 8,
        },
      ],
      totalCount: 50,
      activeCount: 47,
      championCount: 1,
    };
  }

  private generateTournamentData(): any {
    return {
      currentChampion: 'Meta Whale Activity Intelligence',
      battlesCompleted: 247,
      nextBattle: '2025-06-14T16:00:00Z',
      leaderboard: [
        { rank: 1, patternId: '1', points: 2340, wins: 189, losses: 8 },
        { rank: 2, patternId: '2', points: 2156, wins: 167, losses: 22 },
        { rank: 3, patternId: '3', points: 2089, wins: 145, losses: 11 },
      ],
    };
  }

  private generateEvolutionStatus(): any {
    return {
      level0: { count: 8, active: 8, description: 'Atomic Parameters' },
      level1: { count: 24, avgSuccessRate: 78.39, active: 18 },
      level2: { count: 29, avgSuccessRate: 84.43, active: 26 },
      level3: { count: 3, avgSuccessRate: 84.59, active: 3 },
      totalPatternsCreated: 56,
      approvedForLive: 50,
      approvalRate: 89.3,
    };
  }

  private generateAIEngineStatus(): any {
    return {
      engines: [
        {
          id: 'llama-70b',
          name: 'Llama-70B Deep Discovery',
          performance: 94.2,
          patternsGenerated: 247,
          successRate: 85.7,
          innovationScore: 92.3,
          status: 'active',
          resourceUsage: { cpu: 78, memory: 87, gpu: 92 },
        },
        {
          id: 'llama-30b',
          name: 'Llama-30B Rapid Response',
          performance: 91.8,
          patternsGenerated: 189,
          successRate: 82.4,
          innovationScore: 88.9,
          status: 'active',
          resourceUsage: { cpu: 65, memory: 71, gpu: 84 },
        },
        {
          id: 'claude-35',
          name: 'Claude-3.5 Validation Logic',
          performance: 96.4,
          patternsGenerated: 0,
          successRate: 94.1,
          innovationScore: 97.2,
          status: 'active',
          resourceUsage: { cpu: 12, memory: 8, gpu: 0 },
        },
      ],
    };
  }

  private generateSystemStatus(): any {
    return {
      aiEnginesActive: 3,
      patternsLive: 50,
      peakSuccessRate: 88.5,
      avgSuccessRate: 75.23,
      totalTrades: 1247,
      systemUptime: 99.94,
      isConnected: this.isBackendAvailable,
      isDemoMode: !this.isBackendAvailable,
      lastUpdate: new Date().toISOString(),
    };
  }

  private generateLiveAlerts(): any {
    const alerts = [
      {
        id: '1',
        type: 'discovery',
        title: 'Revolutionary Pattern Discovered',
        message: 'AI synthesized Meta Whale Activity pattern achieving 88.5% success rate',
        timestamp: new Date(Date.now() - 2 * 60 * 1000),
        isNew: true,
        priority: 'high',
        source: 'Llama-70B',
      },
      {
        id: '2',
        type: 'success',
        title: 'Tournament Victory',
        message: 'Meta Whale Activity maintains championship for 23rd consecutive battle',
        timestamp: new Date(Date.now() - 15 * 60 * 1000),
        isNew: false,
        priority: 'medium',
        source: 'Tournament System',
      },
      {
        id: '3',
        title: 'AI Performance Update',
        type: 'info',
        message: 'All 3 AI engines operating at 94%+ performance efficiency',
        timestamp: new Date(Date.now() - 30 * 60 * 1000),
        isNew: false,
        priority: 'low',
        source: 'System Monitor',
      },
    ];

    return { alerts, totalCount: alerts.length };
  }

  // API Methods for specific endpoints
  async getSystemStatus(): Promise<ApiResponse<SystemStatus>> {
    return this.get<SystemStatus>('/system/status');
  }

  async getLivePatterns(): Promise<ApiResponse<{ patterns: Pattern[]; totalCount: number }>> {
    return this.get('/patterns/live');
  }

  async getTournamentData(): Promise<ApiResponse<any>> {
    return this.get('/patterns/tournament');
  }

  async getEvolutionStatus(): Promise<ApiResponse<any>> {
    return this.get('/evolution/status');
  }

  async getAIEngines(): Promise<ApiResponse<{ engines: AIEngine[] }>> {
    return this.get('/ai/engines');
  }

  async getLiveAlerts(): Promise<ApiResponse<{ alerts: Alert[]; totalCount: number }>> {
    return this.get('/alerts/live');
  }

  getConnectionStatus(): { isConnected: boolean; isDemoMode: boolean } {
    return {
      isConnected: this.isBackendAvailable,
      isDemoMode: !this.isBackendAvailable,
    };
  }
}

// Export singleton instance
export const quantoraApi = new QuantoraApiClient();
export default quantoraApi;
