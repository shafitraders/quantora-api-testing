# 🔧 Quantora Thunderbolt 5 Network Diagnostics

## Overview

This directory contains comprehensive network diagnostics scripts for the Quantora 3-Mac AI trading ecosystem. These scripts help diagnose and troubleshoot Thunderbolt 5 network connectivity between your Macs.

## 🚀 Quick Start

### SSH Setup (Required for 3-Mac Management)
```bash
# Run from quantora-systems root directory
./scripts/run_ssh_setup.sh
```

### Network Diagnostics
```bash
# Comprehensive Thunderbolt network diagnostics
./scripts/run_diagnostics.sh
```

## 📋 What the Script Tests

### 1. **Basic Network Connectivity**
- Ping tests to all 3 Macs (192.168.1.1, 192.168.1.2, 192.168.1.3)
- Latency measurements
- Reachability assessment

### 2. **Thunderbolt Bridge Interface**
- Checks for `bridge100` (standard Thunderbolt bridge)
- Falls back to alternative bridge interfaces
- Validates IP assignments

### 3. **Service Connectivity**
- Tests backend services on each Mac:
  - Mac 1: `http://192.168.1.1:8000/health`
  - Mac 2: `http://192.168.1.2:8002/health`
  - Mac 3: `http://192.168.1.3:8003/health`
- Measures response times
- Validates service health

### 4. **Thunderbolt Hardware Detection**
- Detects Thunderbolt devices using `system_profiler`
- Shows device details and port information
- Validates hardware compatibility

### 5. **Network Route Analysis**
- Analyzes routing table for 192.168.1.x network
- Checks for specific routes to each Mac
- Identifies routing issues

### 6. **Firewall Status**
- Checks macOS `pfctl` firewall status
- Validates Application Firewall settings
- Identifies potential blocking rules

### 7. **Performance Benchmark**
- Runs 10-ping latency tests to each Mac
- Calculates average response times
- Categorizes performance (EXCELLENT/GOOD/SLOW)

## 🎯 Expected Results

### ✅ **Perfect Setup**
```
📊 Network Connectivity: 3/3 Macs reachable
✅ All Macs connected - Network topology is correct!
```

### ⚠️ **Partial Issues**
```
📊 Network Connectivity: 2/3 Macs reachable
⚠️  2/3 Macs connected - Check the missing Mac
```

### ❌ **Major Issues**
```
📊 Network Connectivity: 1/3 Macs reachable
❌ Poor connectivity - Check network configuration
```

## 🔧 Quick Fixes

### 1. **Network Fixes**
```bash
sudo ifconfig bridge100 up
sudo route add -net 192.168.1.0/24 -interface bridge100
```

### 2. **Firewall Fixes**
```bash
# Temporarily disable firewall
sudo pfctl -d

# Or allow specific ports
sudo pfctl -f /dev/stdin <<< 'pass in proto tcp to any port {8000,8002,8003}'
```

### 3. **Service Restart**
```bash
# On Mac 2: python3 mac2_ai_service.py
# On Mac 3: python3 mac3_production_service.py
```

### 4. **Thunderbolt Reset**
- Reconnect Thunderbolt cables
- Check System Preferences > Thunderbolt Bridge

## 🎯 Usage Tips

### **Run on Each Mac**
For complete diagnostics, run this script on each Mac in your ecosystem:
- Mac 1 (Development Beast)
- Mac 2 (AI Powerhouse)  
- Mac 3 (Production Mirror)

### **Compare Results**
Compare the results from each Mac to identify:
- One-way connectivity issues
- Performance differences
- Service availability problems

### **Regular Monitoring**
Run diagnostics regularly to:
- Monitor network health
- Detect performance degradation
- Validate service availability

## 🛠️ Troubleshooting

### **Common Issues**

1. **"Thunderbolt Bridge not found"**
   - Check System Preferences > Network > Thunderbolt Bridge
   - Ensure Thunderbolt cables are properly connected

2. **"Service not responding"**
   - Verify services are running on target Macs
   - Check firewall settings
   - Validate port configurations

3. **"High latency"**
   - Check cable quality and connections
   - Verify Thunderbolt bridge configuration
   - Monitor for network congestion

### **Advanced Debugging**

For detailed debugging, run with verbose output:
```bash
bash -x ./scripts/thunderbolt_diagnostics.sh
```

## 📊 Performance Benchmarks

### **Latency Categories**
- **< 10ms**: EXCELLENT - Thunderbolt speed
- **10-50ms**: GOOD - Fast network  
- **> 50ms**: SLOW - Check network

### **Expected Performance**
- **Thunderbolt 5**: < 5ms latency
- **Thunderbolt 4**: < 10ms latency
- **Thunderbolt 3**: < 15ms latency

## 🎯 Integration with SystemValidation

This diagnostics script complements the SystemValidation component in your React dashboard. The dashboard provides real-time monitoring, while this script offers detailed offline diagnostics.

## ✨ Remember

> "When you do something with pure heart, sincerity and dedication, you create magic"

Make the impossible possible! 🚀 

## 📋 Available Scripts

### SSH Management
- **`setup_ssh.sh`** - Comprehensive SSH setup for 3-Mac ecosystem
- **`run_ssh_setup.sh`** - Simple launcher for SSH setup

### Network Diagnostics
- **`thunderbolt_diagnostics.sh`** - Complete Thunderbolt network analysis
- **`run_diagnostics.sh`** - Launcher for network diagnostics

## 🔧 SSH Setup Script Details

The SSH setup script (`setup_ssh.sh`) provides:

### Features
- ✅ **Automatic Mac Detection** - Identifies which Mac in the ecosystem
- ✅ **SSH Service Management** - Enables and configures SSH daemon
- ✅ **Network Connectivity Testing** - Tests SSH connectivity to other Macs
- ✅ **Firewall Analysis** - Checks for SSH blocking rules
- ✅ **SSH Key Recommendations** - Guides for passwordless authentication
- ✅ **Status Reporting** - Detailed status and troubleshooting info

### What It Does
1. **Enables SSH Service** using multiple methods for reliability
2. **Verifies SSH Status** - checks daemon, port binding, and configuration
3. **Tests Network Connectivity** to other Macs in the ecosystem
4. **Analyzes Firewall Settings** that might block SSH
5. **Provides Setup Recommendations** for SSH keys and authentication
6. **Creates Status Report** saved to `~/ssh_setup_status.txt`

### Usage
```bash
# From quantora-systems root directory
./scripts/run_ssh_setup.sh

# Or run directly (requires sudo)
sudo ./scripts/setup_ssh.sh
```

### Expected Output
```
🔧 Quantora Revolutionary 3-Mac SSH Setup
════════════════════════════════════════════

[MAGIC] Setting up SSH on: Mac 1 (Development Beast)

[INFO] Enabling SSH service...
[SUCCESS] SSH daemon loaded successfully
[SUCCESS] SSH service started
[SUCCESS] Remote Login enabled via systemsetup

[INFO] Verifying SSH service status...
[SUCCESS] SSH daemon is running (com.openssh.sshd)
[SUCCESS] Remote Login confirmed: ON

[INFO] Checking SSH port configuration...
[SUCCESS] SSH listening on port 22:
[SUCCESS]   sshd    1234 root    3u  IPv6 0x12345678      0t0  TCP *:ssh (LISTEN)

[INFO] Testing network connectivity to other Macs...
[SUCCESS] Mac 2 (AI Powerhouse): SSH port 22 is reachable
[WARNING] Mac 2 (AI Powerhouse): SSH port open but authentication needed
[SUCCESS] Mac 3 (Production Mirror): SSH port 22 is reachable
[WARNING] Mac 3 (Production Mirror): SSH port open but authentication needed

🎯 SSH SETUP SUMMARY
════════════════════════════════════════
📊 SSH Service Status:
  SSH Daemon: ✅ RUNNING
  Remote Login: ✅ ENABLED
  Current Mac: Mac 1 (Development Beast)

🏆 SSH setup complete for Mac 1 (Development Beast)!
[MAGIC] Ready for revolutionary 3-Mac ecosystem management! ✨
```

## 🌐 Network Diagnostics Script Details

The Thunderbolt diagnostics script (`thunderbolt_diagnostics.sh`) provides:

### Features
- ✅ **Thunderbolt Interface Detection** - Identifies Thunderbolt bridge interfaces
- ✅ **Network Connectivity Testing** - Tests connectivity between all 3 Macs
- ✅ **Service Health Checks** - Verifies Quantora services on each Mac
- ✅ **Performance Benchmarking** - Measures latency and bandwidth
- ✅ **Hardware Detection** - Identifies Thunderbolt hardware and drivers
- ✅ **Troubleshooting Recommendations** - Provides solutions for common issues

### Usage
```bash
# From quantora-systems root directory
./scripts/run_diagnostics.sh

# Or run directly
./scripts/thunderbolt_diagnostics.sh
```

## 🔄 Integration with SystemValidation

Both scripts integrate with the React SystemValidation component:

- **SSH Status** is reported in the ecosystem integration tests
- **Network Diagnostics** results are displayed in the validation dashboard
- **Service Health** checks verify all 3 Macs are properly connected

## 🛠️ Troubleshooting

### SSH Issues
1. **SSH not starting**: Check if Remote Login is enabled in System Preferences
2. **Connection refused**: Verify firewall settings and port 22 accessibility
3. **Authentication failed**: Set up SSH keys for passwordless access

### Network Issues
1. **Thunderbolt not detected**: Check Thunderbolt cables and system settings
2. **High latency**: Verify Thunderbolt bridge interface configuration
3. **Service unreachable**: Check if services are running on target Macs

## 📞 Support

For issues with these scripts:
1. Check the status files created by the scripts
2. Review the troubleshooting recommendations in the output
3. Verify network configuration and firewall settings
4. Ensure all 3 Macs are properly connected via Thunderbolt

---

*"When you do something with pure heart, sincerity and dedication, you create magic" ✨* 