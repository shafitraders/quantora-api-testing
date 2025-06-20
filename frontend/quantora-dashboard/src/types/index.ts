// 🎯 Quantora Type Definitions - Revolutionary AI Architecture
// "Simplicity is the ultimate sophistication" - Steve Jobs

export interface Pattern {
  id: string;
  name: string;
  successRate: number;
  sharpeRatio: number;
  maxDrawdown: number;
  level: 0 | 1 | 2 | 3;
  status: 'LIVE' | 'TESTING' | 'CHAMPION' | 'RETIRED';
  category: string;
  aiCreator: 'Llama-70B' | 'Llama-30B' | 'Claude-3.5' | 'Enhanced-Mistral';
  createdAt: string;
  lastUpdated: string;
  validationScore: number;
  totalTrades: number;
  winStreak: number;
}

export interface AIEngine {
  id: string;
  name: string;
  performance: number;
  patternsGenerated: number;
  successRate: number;
  innovationScore: number;
  status: 'active' | 'training' | 'offline';
  resourceUsage: {
    cpu: number;
    memory: number;
    gpu: number;
  };
}

export interface SystemStatus {
  aiEnginesActive: number;
  patternsLive: number;
  peakSuccessRate: number;
  avgSuccessRate: number;
  totalTrades: number;
  systemUptime: number;
  isConnected: boolean;
  isDemoMode: boolean;
  lastUpdate: string;
}

export interface MetricCard {
  id: string;
  label: string;
  value: string | number;
  trend: string;
  color: string;
  icon?: string;
  changePercent?: number;
}

export interface Alert {
  id: string;
  type: 'success' | 'warning' | 'error' | 'info' | 'discovery';
  title: string;
  message: string;
  timestamp: Date;
  isNew?: boolean;
  priority: 'low' | 'medium' | 'high' | 'critical';
  source: string;
}

export interface TournamentResult {
  rank: number;
  pattern: Pattern;
  battlesWon: number;
  battlesLost: number;
  currentStreak: number;
  championshipPoints: number;
}

export interface EvolutionLevel {
  level: number;
  name: string;
  description: string;
  patternCount: number;
  avgSuccessRate: number;
  requirements: string[];
  status: 'active' | 'complete' | 'pending';
} 