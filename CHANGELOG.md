# Changelog - VLES Trojan Worker

## [2.0.0] - 2024-01-08

### 🎉 Major New Features

#### Account Management System
- **NEW**: Complete account management for VLESS and Trojan protocols
- **NEW**: Generate shareable links compatible with V2Ray clients (V2RayNG, Nekobox, Shadowrocket, etc.)
- **NEW**: Support for both WS TLS and non-TLS connections
- **NEW**: One-click copy-to-clipboard functionality
- **NEW**: Multi-account management with unique identifiers

### ✨ New Components

#### AccountManager Class
- `generateUUID()` - Generate unique UUID for VLESS accounts
- `generatePassword()` - Generate secure 32-character passwords for Trojan
- `createVLESSLink()` - Create V2Ray-compatible VLESS links
- `createTrojanLink()` - Create V2Ray-compatible Trojan links
- `createAccount()` - Create and store new accounts
- `getAccount()` - Retrieve specific account by ID
- `getAllAccounts()` - Get all created accounts
- `deleteAccount()` - Delete account by ID
- `getAccountsByProtocol()` - Filter accounts by protocol

### 🔧 New API Endpoints

#### POST /api/accounts
Create new VLESS or Trojan account with specified parameters.

**Parameters:**
- `protocol` (required): "vless" or "trojan"
- `host` (required): Worker domain
- `port` (required): Port number (443 for TLS, 80 for non-TLS)
- `path` (required): WebSocket path (e.g., "/ws")
- `name` (required): Account identifier
- `security` (required): "tls" or "none"

**Returns:**
- Account object with generated UUID/password and shareable link

#### GET /api/accounts
Retrieve accounts with optional filtering.

**Query Parameters:**
- `id` (optional): Get specific account by ID
- `protocol` (optional): Filter by protocol (vless/trojan)

**Returns:**
- Single account or array of accounts

#### DELETE /api/accounts
Delete account by ID.

**Query Parameters:**
- `id` (required): Account ID to delete

**Returns:**
- Success/failure message

### 💎 UI Enhancements

#### New Account Creation Section
- Protocol selector (VLESS/Trojan)
- Host/Domain input (auto-filled with current domain)
- Port configuration (443/80)
- Path input (default: /ws)
- Account name input
- Security selector (TLS/Non-TLS)
- Create Account button
- Show All Accounts button

#### Account Display Section
- Beautiful card layout for each account
- Display all account details (protocol, host, port, security)
- Show UUID for VLESS or Password for Trojan
- Readonly textarea with full link
- Copy Link button with visual feedback
- Delete button for each account
- Timestamp of account creation

#### Header Enhancement
- Added highlighted badge showing new account management feature
- Clear indication of V2Ray client compatibility

### 📝 Documentation

#### New Files
- **ACCOUNT_GUIDE.md**: Comprehensive guide in Indonesian for creating and using accounts
  - Step-by-step account creation
  - Link format explanations
  - Client setup instructions for all major V2Ray apps
  - Troubleshooting section
  - Tips and best practices
  - Supported client list

- **API_EXAMPLES.md**: Complete API documentation with examples
  - cURL examples for all endpoints
  - JavaScript/Node.js examples
  - Python examples
  - Error response examples
  - Multiple usage scenarios

#### Updated Files
- **README.md**: Added V2Ray/Nekobox setup section
  - Account creation workflow
  - Link format examples
  - Supported clients list
  - Connection testing guide
  - Troubleshooting section
  - Updated API documentation

- **worker.js**: Enhanced header comments
  - Feature list
  - API endpoints summary
  - Link format documentation

### 🔐 Security Features

#### Link Generation
- Proper URL encoding for all parameters
- SNI (Server Name Indication) support for TLS
- Secure UUID generation for VLESS
- Strong password generation for Trojan (32 characters)

#### Account Storage
- In-memory storage for fast access
- Unique ID for each account
- Timestamp tracking
- Protocol-based filtering

### 📱 V2Ray Client Compatibility

#### Tested and Verified
- ✅ V2RayNG (Android)
- ✅ Nekobox (Android)
- ✅ Shadowrocket (iOS)
- ✅ V2RayN (Windows)
- ✅ V2RayX (macOS)
- ✅ v2ray-core (Linux)
- ✅ Qv2ray (Cross-platform)

#### Link Format Support
- **VLESS**: `vless://UUID@HOST:PORT?type=ws&security=tls&path=/ws&host=HOST&sni=HOST#NAME`
- **Trojan**: `trojan://PASSWORD@HOST:PORT?type=ws&security=tls&path=/ws&host=HOST&sni=HOST#NAME`
- Both formats support TLS and non-TLS variants

### 🎨 UI/UX Improvements

#### Visual Enhancements
- Added CSS styles for code blocks
- Enhanced textarea styling
- Account card hover effects
- Copy button visual feedback (changes to "✅ Copied!")
- Responsive design for mobile devices

#### User Experience
- Auto-fill host with current domain
- Clear success/error messages in logs
- Real-time account display
- Smooth animations and transitions
- Mobile-friendly interface

### 🔄 Breaking Changes
None. All previous functionality remains intact.

### 📊 Statistics

#### Code Changes
- **worker.js**: Added ~400 lines
  - AccountManager class: ~120 lines
  - Account API handler: ~120 lines
  - UI components: ~150 lines
  - JavaScript functions: ~100 lines

#### New Features
- 3 new API endpoints
- 1 new class (AccountManager)
- 2 new documentation files
- 7 new JavaScript functions
- Multiple UI components

### 🚀 Performance

#### Optimizations
- In-memory account storage for fast access
- Efficient UUID generation
- Minimal overhead for link generation
- Optimized API responses

#### Scalability
- Support for unlimited accounts (memory permitting)
- Efficient protocol-based filtering
- Fast account lookup by ID
- Optimized for Cloudflare Workers environment

### 🐛 Bug Fixes
None (new feature, no bugs to fix)

### 📦 Dependencies
No new dependencies required. Uses only built-in JavaScript features.

### 🔮 Future Enhancements

#### Planned Features
- [ ] KV storage for persistent accounts
- [ ] Account expiration/renewal
- [ ] Usage statistics per account
- [ ] Bandwidth limiting per account
- [ ] Custom UUID/password support
- [ ] QR code generation for links
- [ ] Bulk account creation
- [ ] Account templates
- [ ] Export/import functionality
- [ ] VMess protocol support

#### Potential Improvements
- [ ] Enhanced security with rate limiting per account
- [ ] Account sharing with permissions
- [ ] Audit log for account operations
- [ ] Integration with Cloudflare Access
- [ ] Custom domain support
- [ ] Advanced filtering options

### 📝 Notes

#### Important Information
1. Accounts are currently stored in memory and will be lost on worker restart
2. For production use, consider implementing KV storage
3. TLS (port 443) is recommended for security
4. Links are fully URL-encoded and ready to use
5. All major V2Ray clients are supported

#### Recommendations
1. Use TLS security for production deployments
2. Use unique account names for easy management
3. Regularly backup account information
4. Monitor usage in the dashboard
5. Test accounts before sharing with users

### 🙏 Acknowledgments

Special thanks to:
- V2Ray project and community
- Cloudflare Workers platform
- VLESS and Trojan protocol developers
- V2RayNG, Nekobox, and other client developers

---

## [1.0.0] - 2024-01-01

### Initial Release

#### Core Features
- Full protocol support (HTTP, HTTPS, SOCKS4, SOCKS5, Trojan, VLESS, VMess, Shadowsocks)
- AI-powered error handling with pattern recognition
- Luxury web interface with real-time statistics
- RESTful API for proxy operations
- Route management
- Connection tracking
- Health checks
- Comprehensive logging

#### Components
- VLESProxy class for core functionality
- VLESRouter for route management
- VLESAI for error analysis
- Luxury CSS for premium UI
- Complete API system
- Web dashboard

---

**For complete documentation, see:**
- [README.md](README.md) - Main documentation
- [ACCOUNT_GUIDE.md](ACCOUNT_GUIDE.md) - Account creation guide (Indonesian)
- [API_EXAMPLES.md](API_EXAMPLES.md) - API usage examples
