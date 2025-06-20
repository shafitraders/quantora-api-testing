#!/bin/bash

# Quantora 3-Mac SSH Setup Script
# "When you do something with pure heart, sincerity and dedication, you create magic" ✨

echo "🔧 Quantora Revolutionary 3-Mac SSH Setup"
echo "════════════════════════════════════════════"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
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
print_magic "Setting up SSH on: $MAC_IDENTITY"
echo

# Step 1: Enable SSH Service
print_status "Enabling SSH service..."

# Method 1: Your current approach (works)
if sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist 2>/dev/null; then
    print_success "SSH daemon loaded successfully"
else
    print_warning "SSH daemon already loaded or using alternative method"
fi

if sudo launchctl start ssh 2>/dev/null; then
    print_success "SSH service started"
else
    print_warning "SSH service already running or using alternative method"
fi

# Method 2: System preferences approach (more reliable)
print_status "Ensuring SSH is enabled via system preferences..."
if sudo systemsetup -setremotelogin on 2>/dev/null; then
    print_success "Remote Login enabled via systemsetup"
else
    print_warning "Could not set via systemsetup (may need manual intervention)"
fi

# Step 2: Verify SSH is running
print_status "Verifying SSH service status..."

if sudo launchctl list | grep -q "com.openssh.sshd"; then
    print_success "SSH daemon is running (com.openssh.sshd)"
else
    print_error "SSH daemon not found in launchctl list"
fi

# Check system preferences setting
ssh_status=$(sudo systemsetup -getremotelogin 2>/dev/null | grep "Remote Login:")
if echo "$ssh_status" | grep -q "On"; then
    print_success "Remote Login confirmed: ON"
else
    print_warning "Remote Login status: $ssh_status"
fi

# Step 3: Check SSH port and binding
print_status "Checking SSH port configuration..."

if lsof -i :22 | grep -q "LISTEN"; then
    ssh_processes=$(lsof -i :22 | grep "LISTEN")
    print_success "SSH listening on port 22:"
    echo "$ssh_processes" | while read line; do
        print_success "  $line"
    done
else
    print_error "SSH not listening on port 22"
    print_status "Attempting to restart SSH..."
    sudo launchctl stop ssh 2>/dev/null
    sleep 2
    sudo launchctl start ssh 2>/dev/null
    sleep 2
    
    if lsof -i :22 | grep -q "LISTEN"; then
        print_success "SSH now listening after restart"
    else
        print_error "SSH still not listening - manual intervention needed"
    fi
fi

# Step 4: Test SSH configuration
print_status "Testing SSH configuration..."

# Check SSH config file
if [ -f "/etc/ssh/sshd_config" ]; then
    print_success "SSH config file exists: /etc/ssh/sshd_config"
    
    # Check for common configurations
    port_setting=$(grep "^Port" /etc/ssh/sshd_config 2>/dev/null || echo "Port 22 (default)")
    print_status "SSH Port setting: $port_setting"
    
    password_auth=$(grep "^PasswordAuthentication" /etc/ssh/sshd_config 2>/dev/null || echo "PasswordAuthentication yes (default)")
    print_status "Password Authentication: $password_auth"
    
    permit_root=$(grep "^PermitRootLogin" /etc/ssh/sshd_config 2>/dev/null || echo "PermitRootLogin no (default)")
    print_status "Root Login: $permit_root"
else
    print_warning "SSH config file not found at standard location"
fi

# Step 5: Network connectivity test
print_status "Testing network connectivity to other Macs..."

test_ssh_to_mac() {
    local target_ip=$1
    local mac_name=$2
    
    print_status "Testing SSH connectivity to $mac_name ($target_ip)..."
    
    # Test if port 22 is reachable
    if nc -z -w5 "$target_ip" 22 2>/dev/null; then
        print_success "$mac_name: SSH port 22 is reachable"
        
        # Test actual SSH connection (without password)
        if timeout 5 ssh -o ConnectTimeout=3 -o BatchMode=yes "$target_ip" exit 2>/dev/null; then
            print_success "$mac_name: SSH connection successful (key-based)"
        else
            print_warning "$mac_name: SSH port open but authentication needed"
        fi
    else
        print_error "$mac_name: SSH port 22 not reachable"
    fi
}

# Test connectivity based on which Mac we're on
case $MAC_IDENTITY in
    *"Mac 1"*)
        test_ssh_to_mac "192.168.1.2" "Mac 2 (AI Powerhouse)"
        test_ssh_to_mac "192.168.1.3" "Mac 3 (Production Mirror)"
        ;;
    *"Mac 2"*)
        test_ssh_to_mac "192.168.1.1" "Mac 1 (Development Beast)"
        test_ssh_to_mac "192.168.1.3" "Mac 3 (Production Mirror)"
        ;;
    *"Mac 3"*)
        test_ssh_to_mac "192.168.1.1" "Mac 1 (Development Beast)"
        test_ssh_to_mac "192.168.1.2" "Mac 2 (AI Powerhouse)"
        ;;
esac

# Step 6: SSH Key setup recommendations
print_status "SSH key setup recommendations..."

if [ -f ~/.ssh/id_rsa ] || [ -f ~/.ssh/id_ed25519 ]; then
    print_success "SSH keys found in ~/.ssh/"
    ls -la ~/.ssh/id_* 2>/dev/null | while read line; do
        print_success "  $line"
    done
else
    print_warning "No SSH keys found - consider setting up key-based authentication"
    echo
    print_status "To set up SSH keys for passwordless login:"
    echo "  1. Generate key: ssh-keygen -t ed25519 -C 'quantora-ecosystem'"
    echo "  2. Copy to other Macs: ssh-copy-id user@192.168.1.X"
    echo "  3. Test: ssh user@192.168.1.X"
fi

# Step 7: Firewall considerations
print_status "Checking firewall configuration..."

# Check Application Firewall
app_firewall_status=$(sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null)
if echo "$app_firewall_status" | grep -q "enabled"; then
    print_warning "Application Firewall is enabled - SSH should be allowed by default"
    
    # Check if SSH is specifically allowed
    ssh_firewall_status=$(sudo /usr/libexec/ApplicationFirewall/socketfilterfw --listapps 2>/dev/null | grep -i ssh || echo "SSH not explicitly listed")
    print_status "SSH in firewall: $ssh_firewall_status"
else
    print_success "Application Firewall is disabled - no SSH blocking"
fi

# Check pfctl (packet filter)
pfctl_status=$(sudo pfctl -s info 2>/dev/null | grep "Status:" | awk '{print $2}' || echo "unknown")
if [ "$pfctl_status" = "Enabled" ]; then
    print_warning "pfctl firewall is enabled - may affect SSH"
    print_status "Current pfctl rules affecting SSH:"
    sudo pfctl -s rules 2>/dev/null | grep -E "ssh|22" || echo "  No specific SSH rules found"
else
    print_success "pfctl firewall disabled - no SSH interference"
fi

echo
print_magic "🎯 SSH SETUP SUMMARY"
echo "════════════════════════════════════════"

# Final status check
ssh_running=$(lsof -i :22 | grep -q "LISTEN" && echo "✅ RUNNING" || echo "❌ NOT RUNNING")
remote_login=$(sudo systemsetup -getremotelogin 2>/dev/null | grep -q "On" && echo "✅ ENABLED" || echo "❌ DISABLED")

echo "📊 SSH Service Status:"
echo "  SSH Daemon: $ssh_running"
echo "  Remote Login: $remote_login"
echo "  Current Mac: $MAC_IDENTITY"

echo
print_magic "🚀 QUICK COMMANDS FOR YOUR REFERENCE:"
echo
echo "# Check SSH status:"
echo "  sudo launchctl list | grep ssh"
echo "  sudo systemsetup -getremotelogin"
echo "  lsof -i :22"
echo
echo "# Restart SSH if needed:"
echo "  sudo launchctl stop ssh && sudo launchctl start ssh"
echo
echo "# Test SSH from other Macs:"
echo "  ssh user@192.168.1.1  # Mac 1"
echo "  ssh user@192.168.1.2  # Mac 2" 
echo "  ssh user@192.168.1.3  # Mac 3"

echo
print_success "🏆 SSH setup complete for $MAC_IDENTITY!"
print_magic "Ready for revolutionary 3-Mac ecosystem management! ✨"

# Create a status file for reference
cat > ~/ssh_setup_status.txt << EOF
Quantora SSH Setup Status - $(date)
=====================================

Mac Identity: $MAC_IDENTITY
SSH Daemon: $ssh_running
Remote Login: $remote_login

Commands used:
- sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
- sudo launchctl start ssh  
- sudo systemsetup -setremotelogin on

Next steps:
1. Run this script on all 3 Macs
2. Set up SSH keys for passwordless access
3. Test cross-Mac connectivity

"When you do something with pure heart, sincerity and dedication, you create magic"
EOF

print_status "Status saved to: ~/ssh_setup_status.txt" 