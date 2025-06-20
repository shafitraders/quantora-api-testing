export interface PerformanceMetrics {
  cpu: {
    usage: number;
    temperature: number;
  };
  memory: {
    total: number;
    used: number;
    free: number;
  };
  network: {
    bytesIn: number;
    bytesOut: number;
    connections: number;
  };
  disk: {
    total: number;
    used: number;
    free: number;
  };
  uptime: number;
  timestamp: string;
} 