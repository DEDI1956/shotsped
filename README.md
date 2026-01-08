# 🚀 VLES Trojan Worker - Advanced Proxy Solution

[![Cloudflare Workers](https://img.shields.io/badge/Cloudflare-Workers-orange.svg)](https://workers.cloudflare.com/)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES2022-yellow.svg)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![Protocols](https://img.shields.io/badge/Protocols-All-4CAF50.svg)](#protocols)
[![AI](https://img.shields.io/badge/AI-Enabled-blue.svg)](#ai-features)

A sophisticated VLES Trojan Worker with comprehensive proxy support, AI-powered error handling, and a luxurious web interface. Built for Cloudflare Workers deployment with enterprise-grade features.

## ✨ Key Features

### 🎯 **Full Protocol Support**
- **HTTP/HTTPS** - Standard web proxy with full header support
- **SOCKS4/SOCKS5** - Socket proxy protocols with authentication  
- **Trojan** - Modern proxy protocol with TLS-like encryption and bidirectional WebSocket support
- **VLESS** - Lightweight proxy protocol with WebSocket and TCP support
- **VMess** - V2Ray proxy protocol with advanced routing
- **Shadowsocks** - Encrypted proxy protocol with AES encryption

### 🤖 **AI-Powered Error Handling**
- **Real-time Analysis**: Instant error detection and classification
- **Protocol-Specific**: Custom error patterns for each protocol (VLESS, Trojan, etc.)
- **Intelligent Solutions**: Context-aware recommendations for each error type
- **Severity Assessment**: Automatic prioritization of critical issues
- **Automated Troubleshooting**: Step-by-step resolution guides

#### AI Error Coverage
- **VLESS Errors**: WebSocket connection failures, protocol mismatches
- **Trojan Errors**: TLS handshake issues, header validation failures
- **Network Errors**: Timeout detection, DNS resolution problems
- **Protocol Errors**: Unsupported operations, version mismatches
- **Authentication Errors**: Credential validation, permission issues

### 💎 **Luxury Web Interface**
- Modern, responsive design with premium aesthetics
- Real-time statistics and monitoring
- Interactive configuration management
- Advanced logging with color-coded entries
- Mobile-friendly responsive layout

### 🔄 **Bidirectional Communication**
- **WebSocket Support**: Full bidirectional communication for VLESS and Trojan protocols
- **Real-time Messaging**: Instant message delivery and response handling
- **Connection Persistence**: Long-lived connections with automatic reconnection
- **Protocol-Specific**: Optimized for each protocol's communication patterns

### 🛡️ **Enterprise Features**
- CORS support for cross-origin requests
- Rate limiting and connection management
- Comprehensive logging and monitoring
- Route management and configuration
- Health checks and uptime monitoring

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Web Browser   │────│  Cloudflare     │────│  VLES Worker    │
│                 │    │  Workers        │    │                 │
│ - Config UI     │    │ - Proxy Router  │    │ - AI Analyzer   │
│ - Real-time     │    │ - Load Balancer │    │ - Protocol      │
│   Stats         │    │ - Rate Limiter  │    │   Handler       │
│ - Log Viewer    │    │ - Error Handler │    │ - Route Manager │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                       ┌──────────────────┐
                       │  Target Servers  │
                       │ - HTTP/HTTPS     │
                       │ - SOCKS          │
                       │ - VLES/VMess     │
                       │ - Trojan         │
                       │ - Shadowsocks    │
                       └──────────────────┘
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [README.md](README.md) | Main documentation (you are here) |
| [QUICKSTART.md](QUICKSTART.md) | Get started in 3 minutes |
| [ACCOUNT_GUIDE.md](ACCOUNT_GUIDE.md) | Complete account creation guide (Indonesian) |
| [API_EXAMPLES.md](API_EXAMPLES.md) | API usage examples (cURL, JS, Python) |
| [CHANGELOG.md](CHANGELOG.md) | Version history and changes |

## 🚀 Quick Start

### Prerequisites
- Cloudflare account with Workers enabled
- Wrangler CLI installed (`npm install -g wrangler`)
- Node.js 18+ installed

### 1. **Clone and Install**
```bash
git clone <repository-url>
cd vles-trojan-worker
npm install -g wrangler
npm install
```

### 2. **Setup KV Namespace (REQUIRED for Account Management)**

⚠️ **IMPORTANT**: Before deploying, you MUST set up a KV namespace for persistent account storage.

Run setup script:
```bash
chmod +x setup-kv.sh
./setup-kv.sh
```

This will create KV namespaces and output IDs. Update `wrangler.toml` with these IDs:

```toml
[[kv_namespaces]]
binding = "ACCOUNTS_KV"
id = "<PRODUCTION_ID_FROM_SETUP>"
preview_id = "<PREVIEW_ID_FROM_SETUP>"
```

For detailed setup instructions, see [SETUP_GUIDE.md](SETUP_GUIDE.md).

### 3. **Development**
```bash
# Start local development server
wrangler dev

# Access web interface at
https://localhost:8787
```

### 3. **Deploy to Cloudflare**
```bash
# Deploy to Cloudflare Workers
wrangler deploy

# Or deploy to a specific environment
wrangler deploy --env production
```

### 4. **VLESS & Trojan Notes (WebSocket)**

WebSocket support is handled by the Worker code itself — Wrangler does not require any special `--websocket` flag or extra `wrangler.toml` sections.

If you expect heavy traffic, you can raise the per-invocation CPU limit:
```toml
[limits]
cpu_ms = 200
```

### 5. **Configure Domain (Optional)**

If you want to bind the Worker to a custom hostname/zone, configure `routes` as an array:
```toml
# wrangler.toml
routes = [
  { pattern = "your-domain.com/*", zone_name = "your-domain.com" }
]
```

## 🎮 Usage Guide

### **Web Interface**

Access the luxurious web interface at your deployed URL:

1. **Dashboard Overview**
   - Real-time connection status
   - Total requests counter
   - Success rate percentage
   - System uptime tracker

2. **Account Creation (V2Ray/Nekobox Compatible)**
   - Create VLESS/Trojan accounts instantly
   - Generate shareable links for V2Ray clients
   - Support for both WS TLS and non-TLS connections
   - One-click copy to clipboard
   - Manage multiple accounts

3. **Proxy Configuration**
   - Select protocol (HTTP, HTTPS, SOCKS5, Trojan, etc.)
   - Enter target URL/IP
   - Configure port numbers
   - Set request methods

4. **Route Management**
   - Add/remove proxy routes
   - View active connections
   - Monitor route performance

5. **AI Error Handler**
   - Automatic error analysis
   - Smart solution suggestions
   - Pattern recognition
   - Severity assessment

### **API Endpoints**

#### Status Check
```http
GET /api/status
```

#### Account Management (NEW)
```http
# Create VLESS/Trojan account
POST /api/accounts
Content-Type: application/json

{
  "protocol": "vless",
  "host": "your-worker.workers.dev",
  "port": "443",
  "path": "/ws",
  "name": "My VLESS Account",
  "security": "tls"
}

Response:
{
  "success": true,
  "message": "Account created successfully",
  "account": {
    "id": "uuid-here",
    "protocol": "vless",
    "uuid": "generated-uuid",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "security": "tls",
    "name": "My VLESS Account",
    "link": "vless://uuid@host:port?type=ws&security=tls&path=/ws&host=host#name",
    "created": "2024-01-01T00:00:00.000Z"
  }
}

# Get all accounts
GET /api/accounts

# Get specific account
GET /api/accounts?id=account-id

# Get accounts by protocol
GET /api/accounts?protocol=vless

# Delete account
DELETE /api/accounts?id=account-id
```

#### Proxy Request
```http
POST /api/proxy
Content-Type: application/json

{
  "protocol": "http",
  "target": "example.com",
  "port": 80,
  "method": "GET"
}
```

#### Route Management
```http
# Add route
POST /api/routes
{
  "protocol": "https",
  "target": "api.example.com",
  "port": 443,
  "config": {}
}

# Remove route
DELETE /api/routes?protocol=https&port=443
```

#### Statistics
```http
GET /api/stats
```

## 📱 V2Ray/Nekobox Client Setup

### **Creating Accounts**

1. **Access the Web Interface**
   - Open your deployed Worker URL
   - Navigate to "Create Account" section

2. **Configure Account**
   - **Protocol**: Choose VLESS or Trojan
   - **Host**: Your Worker domain (auto-filled)
   - **Port**: 443 (for TLS) or 80 (for non-TLS)
   - **Path**: WebSocket path (default: /ws)
   - **Name**: Account identifier
   - **Security**: TLS (recommended) or none

3. **Generate Link**
   - Click "Create Account" button
   - Account link will be generated automatically
   - Click "Copy Link" to copy to clipboard

4. **Import to Client**
   - Open V2Ray/Nekobox/v2rayNG app
   - Click "Add Configuration" or "+"
   - Paste the copied link
   - Save and connect

### **Link Format Examples**

#### VLESS with TLS (Recommended)
```
vless://uuid@your-worker.workers.dev:443?type=ws&security=tls&path=/ws&host=your-worker.workers.dev&sni=your-worker.workers.dev#MyAccount
```

#### VLESS without TLS
```
vless://uuid@your-worker.workers.dev:80?type=ws&security=none&path=/ws&host=your-worker.workers.dev#MyAccount
```

#### Trojan with TLS (Recommended)
```
trojan://password@your-worker.workers.dev:443?type=ws&security=tls&path=/ws&host=your-worker.workers.dev&sni=your-worker.workers.dev#MyAccount
```

#### Trojan without TLS
```
trojan://password@your-worker.workers.dev:80?type=ws&security=none&path=/ws&host=your-worker.workers.dev#MyAccount
```

### **Supported V2Ray Clients**

- ✅ **V2RayNG** (Android)
- ✅ **Nekobox** (Android)
- ✅ **Shadowrocket** (iOS)
- ✅ **V2RayN** (Windows)
- ✅ **V2RayX** (macOS)
- ✅ **v2ray-core** (Linux)
- ✅ **Qv2ray** (Cross-platform)

### **Connection Testing**

1. After importing the link to your client
2. Select the configuration
3. Click "Connect" or "Start"
4. Test your connection with a web browser
5. Check the Worker's web interface for connection stats

### **Troubleshooting V2Ray Connections**

#### Connection Failed
- ✅ Verify Worker is deployed and accessible
- ✅ Check if host/domain is correct
- ✅ Ensure port matches security setting (443 for TLS, 80 for non-TLS)
- ✅ Verify WebSocket path is correct (/ws by default)

#### TLS Handshake Failed
- ✅ Use TLS security for port 443
- ✅ Use none security for port 80
- ✅ Check SNI matches the host domain

#### Authentication Failed
- ✅ Regenerate account if UUID/password changed
- ✅ Verify link was copied completely
- ✅ Check protocol matches (VLESS or Trojan)

## 🔧 Configuration

### **Protocol Support Matrix**

| Protocol | Status | Features | Security |
|----------|--------|----------|----------|
| HTTP     | ✅ Full | Basic proxy, headers | Low |
| HTTPS    | ✅ Full | SSL/TLS proxy, secure | Medium |
| SOCKS5   | ✅ Full | Authentication, UDP | Medium |
| Trojan   | ✅ Ready | SSL/TLS wrapper | High |
| VLESS    | ✅ Ready | Lightweight, fast | High |
| VMess    | ✅ Ready | V2Ray protocol | High |
| Shadowsocks | ✅ Ready | Encryption | High |

### **AI Error Patterns**

The AI system recognizes and handles:

```javascript
{
  "connection_timeout": "Connection timeout detected...",
  "dns_error": "DNS resolution failed...",
  "proxy_error": "Proxy server error...",
  "protocol_error": "Protocol not supported...",
  "network_error": "Network unreachable...",
  "authentication_error": "Authentication failed..."
}
```

## 🎨 Customization

### **Styling**
Modify the luxury CSS in `LUXURY_CSS` constant:

```css
:root {
  --primary-color: #1a1a2e;
  --secondary-color: #16213e;
  --gold-accent: #ffd700;
  /* Customize your theme */
}
```

### **Protocols**
Add new protocols in `VLESRouter`:

```javascript
this.protocols = new Set([
  'http', 'https', 'socks4', 'socks5', 
  'trojan', 'vmess', 'vless', 'shadowsocks',
  'your-custom-protocol'
]);
```

### **AI Patterns**
Extend error patterns in `VLESAI`:

```javascript
this.errorPatterns = {
  // Add custom error patterns
  custom_error: /your.*pattern/i,
  // ...
};
```

## 📊 Monitoring

### **Real-time Metrics**
- Active connections count
- Request success rate
- Error distribution
- Protocol usage statistics
- Response time monitoring

### **VLESS & Trojan Implementation Details**

#### VLESS Protocol
- **WebSocket Mode**: Full bidirectional communication using Cloudflare WebSocket support
- **TCP Mode**: Binary protocol handling with efficient data transfer
- **Header Support**: VLESS protocol headers and metadata preservation
- **Connection Management**: Automatic connection tracking and cleanup

#### Trojan Protocol
- **TLS-like Encryption**: Protocol-level security with encrypted headers
- **WebSocket Support**: Real-time bidirectional communication
- **TCP Fallback**: Standard TCP connections for compatibility
- **Header Injection**: Trojan-specific headers for protocol identification

## 🔧 Protocol Configuration

### VLESS Configuration Example
```json
{
  "protocol": "vless",
  "target": "your-server.com",
  "port": 443,
  "method": "POST",
  "websocket": true,
  "headers": {
    "X-VLESS-Protocol": "vless",
    "X-VLESS-Version": "1.0"
  }
}
```

### Trojan Configuration Example
```json
{
  "protocol": "trojan",
  "target": "your-server.com",
  "port": 443,
  "method": "POST",
  "websocket": true,
  "headers": {
    "X-Trojan-Protocol": "trojan",
    "X-Trojan-Version": "1.0"
  }
}
```

### **Health Checks**
Automated health checks every 5 minutes:

```javascript
// Health check endpoint
GET /api/status
```

### **Logging**
Comprehensive logging with:
- Error categorization
- AI analysis results
- Performance metrics
- Security events

## 🛡️ Security

### **Features**
- CORS protection
- Input validation
- Rate limiting
- Error sanitization
- Secure headers

### **Best Practices**
- Use HTTPS endpoints
- Implement authentication
- Monitor access logs
- Regular security updates

## 🔍 Troubleshooting

### **Common Issues**

1. **Connection Timeouts**
   - Check network connectivity
   - Verify proxy settings
   - AI suggests timeout solutions

2. **DNS Errors**
   - Validate domain names
   - Check DNS configuration
   - AI provides DNS troubleshooting

3. **Protocol Errors**
   - Verify supported protocols
   - Check configuration syntax
   - AI analyzes protocol compatibility

## 🚀 Performance

### **Optimizations**
- Efficient routing algorithms
- Connection pooling
- Memory management
- Cache optimization

### **Scaling**
- Horizontal scaling via Cloudflare
- Load balancing
- Geographic distribution
- Auto-scaling capabilities

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

### **Development Guidelines**
- Follow ES2022+ standards
- Maintain test coverage
- Document new features
- Follow security best practices

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Cloudflare Workers platform
- VLES/VLESS protocol developers
- AI error handling patterns
- Modern web UI frameworks

## 📞 Support

- 📧 Email: support@vles-worker.com
- 💬 Discord: [VLES Community](https://discord.gg/vles)
- 📖 Documentation: [Wiki](https://github.com/vles/worker/wiki)
- 🐛 Issues: [GitHub Issues](https://github.com/vles/worker/issues)

---

<div align="center">

**🚀 VLES Trojan Worker - Where Advanced Proxy Meets AI Intelligence**

[Deploy Now](https://dash.cloudflare.com/) • [Documentation](https://github.com/vles/worker/wiki) • [Community](https://discord.gg/vles)

</div>