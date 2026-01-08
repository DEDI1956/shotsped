# Changelog

All notable changes to VLES Trojan Worker will be documented in this file.

## [1.1.0] - 2025-01-XX

### Added
- **Persistent KV Storage**: Accounts now persist across deployments using Cloudflare KV
  - Automatic save/load from KV namespace
  - No data loss when worker is redeployed
  - Support for account restoration

- **WebSocket Proxy Handler**: Full WebSocket support for VLESS and Trojan connections
  - Bidirectional message handling
  - Connection tracking and logging
  - Protocol-specific validation

- **Setup Script**: Automated KV namespace creation (`setup-kv.sh`)
  - Creates production and preview namespaces
  - Provides clear instructions for configuration
  - One-command setup

- **Setup Guide**: Comprehensive setup documentation (`SETUP_GUIDE.md`)
  - Step-by-step KV configuration
  - Troubleshooting common issues
  - Account creation workflow

- **Troubleshooting Guide**: Detailed problem-solving documentation (`TROUBLESHOOTING.md`)
  - Common errors and solutions
  - Debug commands and techniques
  - Performance optimization tips

### Changed
- **AccountManager**: Refactored with async operations
  - `createAccount()` now returns Promise
  - `deleteAccount()` now returns Promise
  - Added KV integration methods

- **Worker Entry Point**: Improved initialization
  - Lazy initialization of VLESProxy
  - KV binding detection and setup
  - Enhanced error handling

- **CORS Headers**: Added WebSocket support
  - `Upgrade` and `Connection` headers allowed
  - Better cross-origin WebSocket support

### Fixed
- **Account Creation**: Fixed silent failures
  - Added proper error logging
  - Validation of all required fields
  - Detailed error messages

- **WebSocket Routing**: Fixed missing endpoint handler
  - WebSocket connections now properly routed
  - Path matching for account endpoints
  - Connection state management

- **API Response**: Fixed inconsistent response format
  - All endpoints return proper JSON
  - Success/error handling standardized
  - Better error messages

### Improved
- **Logging**: Enhanced console logging
  - Structured log messages with prefixes
  - Connection attempt tracking
  - Error details and context

- **Documentation**: Updated README with KV setup
  - Clear setup requirements
  - Links to new guides
  - Better quick start instructions

## [1.0.0] - 2024-XX-XX

### Added
- Initial release of VLES Trojan Worker
- Full protocol support (HTTP, HTTPS, SOCKS4/5, Trojan, VLESS, VMess, Shadowsocks)
- AI-powered error handling with pattern recognition
- Luxury web interface with real-time stats
- V2Ray account management with shareable links
- RESTful API endpoints
- Comprehensive documentation

---

## Version Format

- **Major.Minor.Patch** (e.g., 1.0.0)
  - **Major**: Breaking changes, major features
  - **Minor**: New features, enhancements
  - **Patch**: Bug fixes, improvements
