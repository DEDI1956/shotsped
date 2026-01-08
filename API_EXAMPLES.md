# 🔧 API Examples - VLES Trojan Worker

## Account Management API

### 1. Create VLESS Account (TLS)

**Request:**
```bash
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "protocol": "vless",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "name": "My VLESS TLS Account",
    "security": "tls"
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Account created successfully",
  "account": {
    "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
    "protocol": "vless",
    "uuid": "12345678-1234-4678-9abc-def012345678",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "security": "tls",
    "name": "My VLESS TLS Account",
    "link": "vless://12345678-1234-4678-9abc-def012345678@your-worker.workers.dev:443?type=ws&security=tls&path=%2Fws&host=your-worker.workers.dev&sni=your-worker.workers.dev#My%20VLESS%20TLS%20Account",
    "created": "2024-01-08T10:00:00.000Z"
  }
}
```

### 2. Create VLESS Account (Non-TLS)

**Request:**
```bash
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "protocol": "vless",
    "host": "your-worker.workers.dev",
    "port": "80",
    "path": "/ws",
    "name": "My VLESS Non-TLS Account",
    "security": "none"
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Account created successfully",
  "account": {
    "id": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
    "protocol": "vless",
    "uuid": "23456789-2345-5789-abcd-ef1234567890",
    "host": "your-worker.workers.dev",
    "port": "80",
    "path": "/ws",
    "security": "none",
    "name": "My VLESS Non-TLS Account",
    "link": "vless://23456789-2345-5789-abcd-ef1234567890@your-worker.workers.dev:80?type=ws&security=none&path=%2Fws&host=your-worker.workers.dev#My%20VLESS%20Non-TLS%20Account",
    "created": "2024-01-08T10:01:00.000Z"
  }
}
```

### 3. Create Trojan Account (TLS)

**Request:**
```bash
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "protocol": "trojan",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "name": "My Trojan TLS Account",
    "security": "tls"
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Account created successfully",
  "account": {
    "id": "c3d4e5f6-a7b8-9012-cdef-123456789012",
    "protocol": "trojan",
    "password": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "security": "tls",
    "name": "My Trojan TLS Account",
    "link": "trojan://a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6@your-worker.workers.dev:443?type=ws&security=tls&path=%2Fws&host=your-worker.workers.dev&sni=your-worker.workers.dev#My%20Trojan%20TLS%20Account",
    "created": "2024-01-08T10:02:00.000Z"
  }
}
```

### 4. Create Trojan Account (Non-TLS)

**Request:**
```bash
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "protocol": "trojan",
    "host": "your-worker.workers.dev",
    "port": "80",
    "path": "/ws",
    "name": "My Trojan Non-TLS Account",
    "security": "none"
  }'
```

**Response:**
```json
{
  "success": true,
  "message": "Account created successfully",
  "account": {
    "id": "d4e5f6a7-b8c9-0123-def1-234567890123",
    "protocol": "trojan",
    "password": "b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7",
    "host": "your-worker.workers.dev",
    "port": "80",
    "path": "/ws",
    "security": "none",
    "name": "My Trojan Non-TLS Account",
    "link": "trojan://b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7@your-worker.workers.dev:80?type=ws&security=none&path=%2Fws&host=your-worker.workers.dev#My%20Trojan%20Non-TLS%20Account",
    "created": "2024-01-08T10:03:00.000Z"
  }
}
```

### 5. Get All Accounts

**Request:**
```bash
curl https://your-worker.workers.dev/api/accounts
```

**Response:**
```json
{
  "accounts": [
    {
      "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "protocol": "vless",
      "uuid": "12345678-1234-4678-9abc-def012345678",
      "host": "your-worker.workers.dev",
      "port": "443",
      "path": "/ws",
      "security": "tls",
      "name": "My VLESS TLS Account",
      "link": "vless://...",
      "created": "2024-01-08T10:00:00.000Z"
    },
    {
      "id": "c3d4e5f6-a7b8-9012-cdef-123456789012",
      "protocol": "trojan",
      "password": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
      "host": "your-worker.workers.dev",
      "port": "443",
      "path": "/ws",
      "security": "tls",
      "name": "My Trojan TLS Account",
      "link": "trojan://...",
      "created": "2024-01-08T10:02:00.000Z"
    }
  ]
}
```

### 6. Get Specific Account

**Request:**
```bash
curl "https://your-worker.workers.dev/api/accounts?id=a1b2c3d4-e5f6-7890-abcd-ef1234567890"
```

**Response:**
```json
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "protocol": "vless",
  "uuid": "12345678-1234-4678-9abc-def012345678",
  "host": "your-worker.workers.dev",
  "port": "443",
  "path": "/ws",
  "security": "tls",
  "name": "My VLESS TLS Account",
  "link": "vless://12345678-1234-4678-9abc-def012345678@your-worker.workers.dev:443?type=ws&security=tls&path=%2Fws&host=your-worker.workers.dev&sni=your-worker.workers.dev#My%20VLESS%20TLS%20Account",
  "created": "2024-01-08T10:00:00.000Z"
}
```

### 7. Get Accounts by Protocol

**Request:**
```bash
curl "https://your-worker.workers.dev/api/accounts?protocol=vless"
```

**Response:**
```json
{
  "accounts": [
    {
      "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "protocol": "vless",
      "uuid": "12345678-1234-4678-9abc-def012345678",
      "host": "your-worker.workers.dev",
      "port": "443",
      "path": "/ws",
      "security": "tls",
      "name": "My VLESS TLS Account",
      "link": "vless://...",
      "created": "2024-01-08T10:00:00.000Z"
    },
    {
      "id": "b2c3d4e5-f6a7-8901-bcde-f12345678901",
      "protocol": "vless",
      "uuid": "23456789-2345-5789-abcd-ef1234567890",
      "host": "your-worker.workers.dev",
      "port": "80",
      "path": "/ws",
      "security": "none",
      "name": "My VLESS Non-TLS Account",
      "link": "vless://...",
      "created": "2024-01-08T10:01:00.000Z"
    }
  ]
}
```

### 8. Delete Account

**Request:**
```bash
curl -X DELETE "https://your-worker.workers.dev/api/accounts?id=a1b2c3d4-e5f6-7890-abcd-ef1234567890"
```

**Response:**
```json
{
  "success": true,
  "message": "Account deleted successfully"
}
```

## Other API Endpoints

### System Status

**Request:**
```bash
curl https://your-worker.workers.dev/api/status
```

**Response:**
```json
{
  "status": "active",
  "timestamp": "2024-01-08T10:00:00.000Z",
  "uptime": 3600,
  "totalRequests": 1234,
  "errorCount": 5,
  "successRate": "99.59%",
  "activeConnections": 3,
  "routes": [],
  "protocols": ["http", "https", "socks4", "socks5", "trojan", "vmess", "vless", "shadowsocks"]
}
```

### Statistics

**Request:**
```bash
curl https://your-worker.workers.dev/api/stats
```

**Response:**
```json
{
  "uptime": 3600,
  "totalRequests": 1234,
  "errorCount": 5,
  "successRate": "99.59%",
  "activeConnections": 3,
  "routes": [],
  "protocols": ["http", "https", "socks4", "socks5", "trojan", "vmess", "vless", "shadowsocks"]
}
```

## JavaScript Examples

### Using Fetch API

```javascript
// Create VLESS Account
async function createVLESSAccount() {
  const response = await fetch('https://your-worker.workers.dev/api/accounts', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      protocol: 'vless',
      host: 'your-worker.workers.dev',
      port: '443',
      path: '/ws',
      name: 'My VLESS Account',
      security: 'tls'
    })
  });
  
  const data = await response.json();
  console.log('Account created:', data.account.link);
  return data;
}

// Get All Accounts
async function getAllAccounts() {
  const response = await fetch('https://your-worker.workers.dev/api/accounts');
  const data = await response.json();
  console.log('Total accounts:', data.accounts.length);
  return data.accounts;
}

// Delete Account
async function deleteAccount(accountId) {
  const response = await fetch(
    `https://your-worker.workers.dev/api/accounts?id=${accountId}`,
    { method: 'DELETE' }
  );
  const data = await response.json();
  console.log('Delete result:', data.message);
  return data;
}
```

### Using Axios

```javascript
const axios = require('axios');

const API_BASE = 'https://your-worker.workers.dev/api';

// Create Trojan Account
async function createTrojanAccount() {
  try {
    const response = await axios.post(`${API_BASE}/accounts`, {
      protocol: 'trojan',
      host: 'your-worker.workers.dev',
      port: '443',
      path: '/ws',
      name: 'My Trojan Account',
      security: 'tls'
    });
    
    console.log('Link:', response.data.account.link);
    return response.data;
  } catch (error) {
    console.error('Error:', error.response.data);
  }
}

// Get Accounts by Protocol
async function getVLESSAccounts() {
  try {
    const response = await axios.get(`${API_BASE}/accounts`, {
      params: { protocol: 'vless' }
    });
    
    console.log('VLESS Accounts:', response.data.accounts);
    return response.data.accounts;
  } catch (error) {
    console.error('Error:', error.response.data);
  }
}
```

## Python Examples

### Using Requests

```python
import requests
import json

API_BASE = 'https://your-worker.workers.dev/api'

# Create VLESS Account
def create_vless_account():
    data = {
        'protocol': 'vless',
        'host': 'your-worker.workers.dev',
        'port': '443',
        'path': '/ws',
        'name': 'My VLESS Account',
        'security': 'tls'
    }
    
    response = requests.post(f'{API_BASE}/accounts', json=data)
    result = response.json()
    
    if result['success']:
        print('Account created!')
        print('Link:', result['account']['link'])
    
    return result

# Get All Accounts
def get_all_accounts():
    response = requests.get(f'{API_BASE}/accounts')
    accounts = response.json()['accounts']
    
    for account in accounts:
        print(f"Name: {account['name']}")
        print(f"Protocol: {account['protocol']}")
        print(f"Link: {account['link']}")
        print('---')
    
    return accounts

# Delete Account
def delete_account(account_id):
    response = requests.delete(f'{API_BASE}/accounts', params={'id': account_id})
    result = response.json()
    
    print(result['message'])
    return result

# Example usage
if __name__ == '__main__':
    # Create account
    account = create_vless_account()
    
    # List accounts
    accounts = get_all_accounts()
    
    # Delete account (uncomment to use)
    # delete_account(account['account']['id'])
```

## Error Responses

### Missing Required Fields

**Request:**
```bash
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{"protocol": "vless"}'
```

**Response:**
```json
{
  "success": false,
  "message": "Missing required fields: protocol, host, port, path, name"
}
```

### Unsupported Protocol

**Request:**
```bash
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "protocol": "unsupported",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "name": "Test",
    "security": "tls"
  }'
```

**Response:**
```json
{
  "success": false,
  "message": "Unsupported protocol: unsupported"
}
```

### Account Not Found

**Request:**
```bash
curl "https://your-worker.workers.dev/api/accounts?id=invalid-id"
```

**Response:**
```json
{
  "success": false,
  "message": "Account not found"
}
```

## Notes

1. All account links are URL-encoded and ready to use in V2Ray clients
2. UUID and passwords are automatically generated
3. Accounts are stored in-memory (consider using KV storage for persistence)
4. Links can be directly imported into V2Ray clients by copying the entire link
5. TLS security is recommended for production use (port 443)
6. Non-TLS can be used for testing or specific use cases (port 80)
