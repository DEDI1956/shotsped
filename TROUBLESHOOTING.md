# Troubleshooting Guide - VLES Trojan Worker

## Account Creation Issues

### Issue: No Response When Creating Account

**Symptoms**: Clicking "Create Account" button shows no response or error.

**Solutions**:

1. **Check Browser Console**
   - Press F12 to open DevTools
   - Go to Console tab
   - Click "Create Account" again
   - Look for error messages (red text)

2. **Check Network Tab**
   - Press F12 to open DevTools
   - Go to Network tab
   - Click "Create Account" again
   - Look for failed requests (red entries)
   - Click failed request to see details

3. **Verify KV Setup**
   ```bash
   # Check if KV namespaces exist
   wrangler kv:namespace list

   # View wrangler.toml
   cat wrangler.toml
   # Make sure [[kv_namespaces]] section exists
   ```

4. **Check Worker Logs**
   ```bash
   # View real-time logs
   wrangler tail

   # Try creating account while watching logs
   # Look for errors like:
   # - "Missing required fields"
   # - "KV not configured"
   # - "Failed to save to KV"
   ```

5. **All Fields Required**
   Make sure all fields are filled:
   - ✅ Protocol (VLESS or Trojan)
   - ✅ Host (domain name, auto-filled)
   - ✅ Port (default: 443)
   - ✅ Path (default: /ws)
   - ✅ Account Name (any name you want)
   - ✅ Security (TLS or None)

### Issue: "Account created successfully" but account doesn't work

**Symptoms**: Account is created, but V2Ray client shows connection errors.

**Solutions**:

1. **Verify Link Format**
   - The link should look like:
     ```
     vless://uuid@host:port?type=ws&security=tls&path=/ws&host=host#name
     ```
     or
     ```
     trojan://password@host:port?type=ws&security=tls&path=/ws&host=host#name
     ```

2. **Check Path Configuration**
   - Path in link must match exactly what you created
   - If you created with path `/ws`, client will connect to `https://host/ws`
   - Make sure no extra slashes or typos

3. **Test WebSocket Connection**
   ```bash
   # Test using curl
   curl -i -N \
     -H "Connection: Upgrade" \
     -H "Upgrade: websocket" \
     -H "Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==" \
     -H "Sec-WebSocket-Version: 13" \
     https://your-worker.workers.dev/ws

   # Expected response:
   # HTTP/1.1 101 Switching Protocols
   # Upgrade: websocket
   # Connection: Upgrade
   ```

4. **Check Worker Health**
   ```bash
   # Visit status endpoint
   curl https://your-worker.workers.dev/api/status

   # Expected response:
   {
     "status": "active",
     "totalRequests": 10,
     "successRate": "100%",
     "uptime": 3600
   }
   ```

5. **View Connection Logs**
   ```bash
   # Watch logs while client tries to connect
   wrangler tail

   # Look for:
   # [ProxyWS] Connection received for account...
   # [ProxyWS] WebSocket accepted...
   ```

### Issue: "Missing required fields" error

**Symptoms**: Error message says fields are missing when all are filled.

**Solutions**:

1. **Check Field Names**
   - Open DevTools Network tab
   - Find POST /api/accounts request
   - Check payload sent to server
   - Verify field names are correct:
     ```json
     {
       "protocol": "vless",
       "host": "your-worker.workers.dev",
       "port": 443,
       "path": "/ws",
       "name": "My Account",
       "security": "tls"
     }
     ```

2. **Clear Browser Cache**
   - Try in incognito/private mode
   - Clear browser cache
   - Try different browser

3. **Check JavaScript Errors**
   - Open Console tab in DevTools
   - Look for errors like:
     - `Uncaught TypeError`
     - `ReferenceError`
     - Syntax errors

## Deployment Issues

### Issue: KV Namespace Not Found

**Symptoms**: Deployment fails with KV namespace error.

**Solutions**:

1. **Create KV Namespace**
   ```bash
   ./setup-kv.sh
   ```

2. **Or Create Manually**
   ```bash
   # Production namespace
   wrangler kv:namespace create ACCOUNTS_KV

   # Preview namespace
   wrangler kv:namespace create ACCOUNTS_KV --preview
   ```

3. **Update wrangler.toml**
   - Copy IDs from step 2
   - Update `wrangler.toml` with correct IDs

### Issue: Worker Not Accessible

**Symptoms**: Worker URL returns 404 or 500 errors.

**Solutions**:

1. **Check Deployment Status**
   ```bash
   wrangler status
   ```

2. **Verify Worker Name**
   - Check `name` in `wrangler.toml`
   - Make sure URL matches name: `https://name.workers.dev`

3. **Check Cloudflare Dashboard**
   - Go to https://dash.cloudflare.com
   - Navigate to Workers & Pages
   - Find your worker
   - Check for errors or warnings

4. **Redeploy**
   ```bash
   wrangler deploy
   ```

## Connection Issues

### Issue: V2Ray Client Shows Connection Timeout

**Symptoms**: Client tries to connect but times out.

**Solutions**:

1. **Check Worker Health**
   ```bash
   curl https://your-worker.workers.dev/api/status
   ```

2. **Verify Link Details**
   - Copy link from worker UI again
   - Re-import to client
   - Make sure all details are correct

3. **Check Firewall**
   - Try different network (mobile data vs WiFi)
   - Check if ports are blocked
   - Try with different server

4. **Test with Different Client**
   - Try V2RayNG, Nekobox, Shadowrocket
   - Some clients have different requirements

5. **View Real-Time Logs**
   ```bash
   wrangler tail
   # Connect with client while watching
   # Look for connection attempts
   ```

### Issue: Authentication Failed

**Symptoms**: Client shows authentication errors.

**Solutions**:

1. **Recreate Account**
   - Delete old account
   - Create new one with same settings
   - Copy new link to client

2. **Check UUID/Password**
   - VLESS uses UUID (long hex string)
   - Trojan uses password (random string)
   - Make sure no typos in link

3. **Clear Client Cache**
   - Some clients cache credentials
   - Remove old profiles
   - Re-import fresh

## Performance Issues

### Issue: Slow Connection Speed

**Solutions**:

1. **Check Worker Location**
   - Workers are deployed to nearest edge
   - Location affects latency
   - Consider domain location

2. **Monitor CPU Usage**
   ```bash
   wrangler tail
   # Look for CPU limit warnings
   ```

3. **Reduce Account Count**
   - Many accounts = more memory
   - Delete unused accounts

## Getting Help

### Collect Debug Information

Before asking for help, gather:

1. **Worker Logs**
   ```bash
   wrangler tail > debug.log
   # Reproduce issue
   # Ctrl+C to stop
   ```

2. **Configuration**
   ```bash
   cat wrangler.toml
   ```

3. **Account Details**
   - Don't share full UUID/password
   - Share protocol, host, path (safe info)

4. **Error Messages**
   - Copy exact error from client
   - Copy exact error from worker logs

5. **Browser Console Errors**
   - Screenshot console tab
   - Copy red error messages

### Useful Commands

```bash
# Watch all logs
wrangler tail

# Watch specific patterns
wrangler tail | grep "ERROR"

# Check worker status
wrangler status

# List KV namespaces
wrangler kv:namespace list

# View KV keys
wrangler kv:key list --namespace-id=<ID>

# Get account data from KV
wrangler kv:key get "accounts" --namespace-id=<ID>

# Delete all accounts (WARNING!)
wrangler kv:key delete "accounts" --namespace-id=<ID>

# Redeploy worker
wrangler deploy

# Test deployment
curl https://your-worker.workers.dev/api/status
```

## Common Error Messages

| Error | Meaning | Solution |
|-------|----------|----------|
| "Missing required fields" | Form not filled correctly | Fill all fields: protocol, host, port, path, name |
| "KV not configured" | KV namespace missing | Run `./setup-kv.sh` and update wrangler.toml |
| "Account not found" | Invalid account ID | Check ID in URL or recreate account |
| "Unsupported protocol" | Wrong protocol name | Use "vless" or "trojan" (lowercase) |
| "WebSocket setup failed" | Connection error | Check path in account matches link path |
| "Failed to save to KV" | KV write error | Check KV namespace ID is correct |

## Quick Fixes

### Reset Everything

If nothing works:

```bash
# 1. Delete all accounts from KV
wrangler kv:key delete "accounts" --namespace-id=<YOUR_ID>

# 2. Redeploy worker
wrangler deploy

# 3. Create fresh account from web UI

# 4. Test with new link
```

### Clean Start

```bash
# 1. Remove local dependencies
rm -rf node_modules package-lock.json

# 2. Reinstall
npm install

# 3. Redeploy
wrangler deploy
```

## Still Having Issues?

1. Check [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed setup
2. Review [README.md](README.md) for complete documentation
3. Review [ACCOUNT_GUIDE.md](ACCOUNT_GUIDE.md) for account creation steps
4. Collect debug information (see above)
5. Share details with error logs
