#!/bin/bash

# Quantora Thunderbolt 5 Network Diagnostics
# "When you do something with pure heart, sincerity and dedication, you create magic" ✨

echo "🔧 Quantora Thunderbolt 5 Network Diagnostics"
echo "═══════════════════════════════════════════════"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() { echo -e "${BLUE}[CHECK]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_magic() { echo -e "${PURPLE}[MAGIC]${NC} $1"; }

# Determine which Mac we're on
get_mac_identity() {
    local ip=$(ifconfig | grep "inet 192.168.1" | head -1 | awk '{print $2}')
    case $ip in
        "192.168.1.1") echo "Mac 1 (Development Beast)" ;;
        "192.168.1.2") echo "Mac 2 (AI Powerhouse)" ;;
        "192.168.1.3") echo "Mac 3 (Production Mirror)" ;;
        *) echo "Unknown Mac (IP: $ip)" ;;
    esac
}

MAC_IDENTITY=$(get_mac_identity)
print_magic "Running diagnostics on: $MAC_IDENTITY"
echo

# Test 1: Basic Network Connectivity
print_status "Testing basic network connectivity..."

test_ping() {
    local target=$1
    local name=$2
    
    if ping -c 3 -W 2000 $target > /dev/null 2>&1; then
        # Measure actual latency
        local latency=$(ping -c 3 $target | tail -1 | awk -F'/' '{print $5}' | cut -d' ' -f1)
        print_success "$name reachable (${latency}ms avg latency)"
        return 0
    else
        print_error "$name unreachable"
        return 1
    fi
}

# Test connectivity to all Macs
mac1_reachable=false
mac2_reachable=false  
mac3_reachable=false

if test_ping "192.168.1.1" "Mac 1 (Development Beast)"; then mac1_reachable=true; fi
if test_ping "192.168.1.2" "Mac 2 (AI Powerhouse)"; then mac2_reachable=true; fi
if test_ping "192.168.1.3" "Mac 3 (Production Mirror)"; then mac3_reachable=true; fi

echo

# Test 2: Thunderbolt Bridge Interface
print_status "Checking Thunderbolt Bridge interface..."

if ifconfig bridge100 > /dev/null 2>&1; then
    bridge_info=$(ifconfig bridge100 | grep "inet 192.168.1")
    if [ ! -z "$bridge_info" ]; then
        local_ip=$(echo $bridge_info | awk '{print $2}')
        print_success "Thunderbolt Bridge active (IP: $local_ip)"
        
        # Check bridge status
        bridge_status=$(ifconfig bridge100 | grep "status:")
        print_status "Bridge status: $bridge_status"
    else
        print_warning "Thunderbolt Bridge exists but no IP assigned"
    fi
else
    print_error "Thunderbolt Bridge (bridge100) not found"
    print_status "Checking alternative bridge interfaces..."
    
    # Check for other bridge interfaces
    bridges=$(ifconfig | grep "^bridge" | cut -d: -f1)
    if [ ! -z "$bridges" ]; then
        for bridge in $bridges; do
            bridge_ip=$(ifconfig $bridge | grep "inet 192.168.1" | awk '{print $2}')
            if [ ! -z "$bridge_ip" ]; then
                print_success "Found active bridge: $bridge (IP: $bridge_ip)"
            fi
        done
    else
        print_error "No bridge interfaces found"
    fi
fi

echo

# Test 3: Service Connectivity
print_status "Testing service connectivity..."

test_service() {
    local url=$1
    local name=$2
    
    # Test with timeout
    local start_time=$(python3 -c "import time; print(int(time.time() * 1000))")
    
    if curl -s --connect-timeout 5 --max-time 10 "$url" > /dev/null 2>&1; then
        local end_time=$(python3 -c "import time; print(int(time.time() * 1000))")
        local response_time=$((end_time - start_time))
        print_success "$name service responding (${response_time}ms)"
        
        # Test actual API response
        local health_response=$(curl -s --connect-timeout 5 --max-time 10 "$url" 2>/dev/null)
        if echo "$health_response" | grep -q "healthy\|operational"; then
            print_success "$name service healthy"
        else
            print_warning "$name service responding but status unclear"
        fi
        return 0
    else
        print_error "$name service not responding"
        return 1
    fi
}

# Test all services
test_service "http://192.168.1.1:8000/health" "Mac 1 Backend"
test_service "http://192.168.1.2:8002/health" "Mac 2 AI Powerhouse"  
test_service "http://192.168.1.3:8003/health" "Mac 3 Production Mirror"

echo

# Test 4: Thunderbolt Hardware Detection
print_status "Checking Thunderbolt hardware..."

# Check for Thunderbolt devices
tb_devices=$(system_profiler SPThunderboltDataType 2>/dev/null | grep -c "Thunderbolt")
if [ $tb_devices -gt 0 ]; then
    print_success "Thunderbolt hardware detected ($tb_devices devices)"
    
    # Show Thunderbolt device details
    print_status "Thunderbolt device details:"
    system_profiler SPThunderboltDataType 2>/dev/null | grep -A 5 -B 5 "Thunderbolt"
else
    print_warning "No Thunderbolt hardware detected"
    print_status "Checking USB-C/Thunderbolt ports..."
    system_profiler SPUSBDataType 2>/dev/null | grep -i "thunderbolt\|usb-c" | head -3
fi

echo

# Test 5: Network Route Analysis  
print_status "Analyzing network routes..."

print_status "Current routing table for 192.168.1.x:"
netstat -rn | grep "192.168.1" | while read line; do
    echo "  $line"
done

# Check if routes exist for all Macs
for ip in "192.168.1.1" "192.168.1.2" "192.168.1.3"; do
    if netstat -rn | grep -q "$ip"; then
        print_success "Route to $ip exists"
    else
        print_warning "No specific route to $ip (may use default gateway)"
    fi
done

echo

# Test 6: Firewall Status
print_status "Checking firewall configuration..."

# Check macOS firewall
firewall_status=$(sudo pfctl -s info 2>/dev/null | grep "Status:" | awk '{print $2}')
if [ "$firewall_status" = "Enabled" ]; then
    print_warning "pfctl firewall is enabled - may block connections"
    print_status "Firewall rules affecting our ports:"
    sudo pfctl -s rules 2>/dev/null | grep -E "8000|8002|8003" || echo "  No specific rules found for our ports"
else
    print_success "pfctl firewall disabled or not blocking"
fi

# Check Application Firewall
app_firewall=$(sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null)
if echo "$app_firewall" | grep -q "enabled"; then
    print_warning "Application Firewall is enabled"
else
    print_success "Application Firewall disabled"
fi

echo

# Test 7: Performance Benchmark
print_status "Running Thunderbolt performance benchmark..."

benchmark_host() {
    local target=$1
    local name=$2
    
    print_status "Benchmarking connection to $name..."
    
    # Multiple ping test for average latency
    local latencies=()
    for i in {1..10}; do
        local latency=$(ping -c 1 -W 1000 $target 2>/dev/null | grep "time=" | awk -F'time=' '{print $2}' | awk '{print $1}')
        if [ ! -z "$latency" ]; then
            latencies+=($latency)
        fi
    done
    
    if [ ${#latencies[@]} -gt 0 ]; then
        # Calculate average
        local sum=0
        for lat in "${latencies[@]}"; do
            sum=$(echo "$sum + $lat" | bc 2>/dev/null || echo "$sum")
        done
        local avg=$(echo "scale=2; $sum / ${#latencies[@]}" | bc 2>/dev/null || echo "N/A")
        
        if [ "$avg" != "N/A" ] && (( $(echo "$avg < 10" | bc -l 2>/dev/null || echo "0") )); then
            print_success "$name: ${avg}ms avg (EXCELLENT - Thunderbolt speed)"
        elif [ "$avg" != "N/A" ] && (( $(echo "$avg < 50" | bc -l 2>/dev/null || echo "0") )); then
            print_success "$name: ${avg}ms avg (GOOD - Fast network)"
        else
            print_warning "$name: ${avg}ms avg (SLOW - Check network)"
        fi
    else
        print_error "$name: No response for benchmark"
    fi
}

# Benchmark connections to other Macs
case $MAC_IDENTITY in
    *"Mac 1"*) 
        benchmark_host "192.168.1.2" "Mac 2"
        benchmark_host "192.168.1.3" "Mac 3"
        ;;
    *"Mac 2"*)
        benchmark_host "192.168.1.1" "Mac 1" 
        benchmark_host "192.168.1.3" "Mac 3"
        ;;
    *"Mac 3"*)
        benchmark_host "192.168.1.1" "Mac 1"
        benchmark_host "192.168.1.2" "Mac 2"  
        ;;
esac

echo

# Summary and Recommendations
print_magic "🎯 DIAGNOSIS SUMMARY & RECOMMENDATIONS"
echo "═══════════════════════════════════════════════════════"

# Connectivity Summary
connectivity_score=0
if [ "$mac1_reachable" = true ]; then ((connectivity_score++)); fi
if [ "$mac2_reachable" = true ]; then ((connectivity_score++)); fi  
if [ "$mac3_reachable" = true ]; then ((connectivity_score++)); fi

echo "📊 Network Connectivity: $connectivity_score/3 Macs reachable"

if [ $connectivity_score -eq 3 ]; then
    print_success "✅ All Macs connected - Network topology is correct!"
elif [ $connectivity_score -eq 2 ]; then
    print_warning "⚠️  2/3 Macs connected - Check the missing Mac"
else
    print_error "❌ Poor connectivity - Check network configuration"
fi

echo
print_magic "🔧 QUICK FIXES TO TRY:"

echo "1. 🌐 NETWORK FIXES:"
echo "   sudo ifconfig bridge100 up"
echo "   sudo route add -net 192.168.1.0/24 -interface bridge100"

echo
echo "2. 🔥 FIREWALL FIXES:"  
echo "   sudo pfctl -d  # Temporarily disable firewall"
echo "   # Or allow specific ports:"
echo "   sudo pfctl -f /dev/stdin <<< 'pass in proto tcp to any port {8000,8002,8003}'"

echo
echo "3. 🔄 SERVICE RESTART:"
echo "   # On Mac 2: python3 mac2_ai_service.py"
echo "   # On Mac 3: python3 mac3_production_service.py"

echo
echo "4. 🚀 THUNDERBOLT RESET:"
echo "   # Reconnect Thunderbolt cables"
echo "   # Check System Preferences > Thunderbolt Bridge"

echo
print_magic "🎯 FOR DEBUGGING: Run this script on each Mac to compare results!"

echo
print_success "Diagnostics complete. Check the results above and apply recommended fixes."
print_magic "Remember: 'Make the impossible possible!' ✨" 