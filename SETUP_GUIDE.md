# Setup Guide - VLES Trojan Worker

## Prerequisites

Before deploying the worker, you need to set up Cloudflare KV namespace for persistent account storage.

## Quick Setup

### Step 1: Install Dependencies

```bash
npm install
```

### Step 2: Login to Cloudflare

```bash
wrangler login
```

### Step 3: Create KV Namespace

Run the setup script to create KV namespaces:

```bash
chmod +x setup-kv.sh
./setup-kv.sh
```

This will output something like:

```
🌀 creating namespace with title "worker-AUTHORIZATION_KEY_ACCOUNTS_KV"
✨ Success! Add the following to your configuration file in your kv_namespaces array:
{ binding = "ACCOUNTS_KV", id = "abc123..." }

🌀 creating namespace with title "worker-AUTHORIZATION_KEY_ACCOUNTS_KV_preview"
✨ Success! Add the following to your configuration file in your kv_namespaces array:
{ binding = "ACCOUNTS_KV", preview_id = "def456..." }
```

### Step 4: Update wrangler.toml

Copy the IDs from the output above and update `wrangler.toml`:

```toml
[[kv_namespaces]]
binding = "ACCOUNTS_KV"
id = "abc123..."        # Replace with your production ID
preview_id = "def456..." # Replace with your preview ID
```

### Step 5: Deploy

```bash
chmod +x deploy.sh
./deploy.sh
```

## Manual KV Setup (Alternative)

If you prefer to create KV namespaces manually:

```bash
# Create production KV namespace
wrangler kv:namespace create ACCOUNTS_KV

# Create preview KV namespace
wrangler kv:namespace create ACCOUNTS_KV --preview
```

Then update `wrangler.toml` with the returned IDs.

## Troubleshooting

### Account Creation Issues

If you're experiencing issues creating accounts:

1. **Check KV Setup**: Make sure KV namespaces are properly configured in `wrangler.toml`
2. **Check Logs**: View worker logs with `wrangler tail`
3. **Verify Worker is Deployed**: Ensure the worker is successfully deployed and running

```bash
# View real-time logs
wrangler tail
```

### No Response When Creating Account

If you don't get any response:

1. Open browser DevTools (F12)
2. Go to Console tab
3. Click "Create Account" button
4. Check for JavaScript errors
5. Check Network tab for failed requests

### Account Not Working with V2Ray Client

If the account doesn't work with V2Ray client:

1. **Verify Link Format**: Ensure the link is properly formatted
2. **Check Path**: Make sure the path in the link matches what you created
3. **Test Connection**: Use curl or telnet to test the connection

```bash
# Test WebSocket connection
curl -i -N \
  -H "Connection: Upgrade" \
  -H "Upgrade: websocket" \
  -H "Sec-WebSocket-Key: test" \
  -H "Sec-WebSocket-Version: 13" \
  https://your-worker.workers.dev/ws
```

## Creating Your First Account

1. Open your worker URL in a browser
2. Fill in the account creation form:
   - **Protocol**: VLESS or Trojan
   - **Host**: Your worker domain (auto-filled)
   - **Port**: 443 (for HTTPS) or 80 (for HTTP)
   - **Path**: /ws (default) or custom path
   - **Account Name**: Any name you want
   - **Security**: TLS (recommended) or None

3. Click "Create Account"
4. Copy the generated link
5. Paste into V2Ray client (V2RayNG, Nekobox, etc.)

## Importing Account to V2Ray Client

### V2RayNG (Android)

1. Copy the account link
2. Open V2RayNG
3. Tap "+" or "Import from clipboard"
4. Select the imported profile
5. Connect!

### Nekobox (Android/iOS)

1. Copy the account link
2. Open Nekobox
3. Go to Settings > Import from clipboard
4. Select the imported profile
5. Connect!

### Shadowrocket (iOS)

1. Copy the account link
2. Open Shadowrocket
3. Allow adding config
4. Select the imported profile
5. Connect!

## Checking Worker Status

View real-time statistics and logs:

```bash
# Watch logs in real-time
wrangler tail

# Check worker status
wrangler status
```

## Updating Worker

After making changes:

```bash
# Simply redeploy
./deploy.sh

# Or manually
wrangler deploy
```

## KV Storage Management

### View All Keys

```bash
wrangler kv:key list --namespace-id=<NAMESPACE_ID>
```

### Delete All Accounts (Warning!)

```bash
wrangler kv:key delete "accounts" --namespace-id=<NAMESPACE_ID>
```

### View Account Data

```bash
wrangler kv:key get "accounts" --namespace-id=<NAMESPACE_ID>
```

## Support

For issues and questions:

1. Check the logs: `wrangler tail`
2. Verify KV configuration
3. Check worker health: Visit `/api/status` endpoint
4. Review Cloudflare dashboard for errors

## Notes

- Accounts are stored in KV namespace and persist across deployments
- Each account creates a unique UUID or password
- The path field creates a WebSocket endpoint for VLESS/Trojan connections
- TLS mode (security=tls) is recommended for production use
- Multiple accounts can be created and managed simultaneously
