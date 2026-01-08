# ⚡ Quick Start - VLES Trojan Worker

## 🚀 Deploy in 3 Minutes

### 1. Prerequisites
```bash
npm install -g wrangler
```

### 2. Deploy
```bash
git clone <your-repo>
cd vles-trojan-worker
wrangler deploy
```

### 3. Create Account
1. Open your Worker URL: `https://your-worker.workers.dev`
2. Fill in the "Create Account" form:
   - **Protocol**: VLESS or Trojan
   - **Host**: (auto-filled)
   - **Port**: 443 (TLS) or 80 (non-TLS)
   - **Path**: /ws
   - **Name**: My Account
   - **Security**: TLS (recommended)
3. Click **"Create Account"**
4. Click **"Copy Link"**

### 4. Import to V2Ray Client
1. Open V2RayNG/Nekobox/Shadowrocket
2. Click **"+"** or **"Import"**
3. Paste the copied link
4. Connect!

## 🔥 That's It!

Your VLESS/Trojan proxy is now ready to use.

## 📋 Example Links

### VLESS with TLS (Recommended)
```
vless://uuid@your-worker.workers.dev:443?type=ws&security=tls&path=/ws&host=your-worker.workers.dev&sni=your-worker.workers.dev#MyAccount
```

### Trojan with TLS (Recommended)
```
trojan://password@your-worker.workers.dev:443?type=ws&security=tls&path=/ws&host=your-worker.workers.dev&sni=your-worker.workers.dev#MyAccount
```

## 🎯 Common Use Cases

### Case 1: Personal VPN
```bash
# Create one account for yourself
Protocol: VLESS
Security: TLS
Port: 443
```

### Case 2: Multiple Devices
```bash
# Create separate accounts for each device
- Phone: "My Phone - VLESS"
- Laptop: "My Laptop - VLESS"
- Tablet: "My Tablet - VLESS"
```

### Case 3: Share with Friends
```bash
# Create accounts with different names
- Friend 1: "John's Account"
- Friend 2: "Jane's Account"
Copy and share the links!
```

## 🔧 API Quick Example

```bash
# Create account via API
curl -X POST https://your-worker.workers.dev/api/accounts \
  -H "Content-Type: application/json" \
  -d '{
    "protocol": "vless",
    "host": "your-worker.workers.dev",
    "port": "443",
    "path": "/ws",
    "name": "My Account",
    "security": "tls"
  }'
```

## 📱 Supported Clients

- ✅ V2RayNG (Android) - [Download](https://play.google.com/store/apps/details?id=com.v2ray.ang)
- ✅ Nekobox (Android) - [Download](https://github.com/MatsuriDayo/NekoBoxForAndroid)
- ✅ Shadowrocket (iOS) - [Download](https://apps.apple.com/app/shadowrocket/id932747118)
- ✅ V2RayN (Windows) - [Download](https://github.com/2dust/v2rayN)
- ✅ V2RayX (macOS) - [Download](https://github.com/Cenmrev/V2RayX)
- ✅ Qv2ray (Linux) - [Download](https://github.com/Qv2ray/Qv2ray)

## 🆘 Troubleshooting

### Can't Connect?
1. ✅ Check Worker is deployed: Visit your Worker URL in browser
2. ✅ Verify port matches security (443=TLS, 80=none)
3. ✅ Make sure you copied the FULL link
4. ✅ Try creating a new account

### Still Not Working?
- Check the **AI Error Handler** panel on the web UI
- View **System Logs** for detailed errors
- Try switching protocol (VLESS ↔ Trojan)
- Try switching security (TLS ↔ none)

## 📚 More Information

- **Full Documentation**: [README.md](README.md)
- **Account Guide (ID)**: [ACCOUNT_GUIDE.md](ACCOUNT_GUIDE.md)
- **API Examples**: [API_EXAMPLES.md](API_EXAMPLES.md)
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

---

**Need Help?** Check the logs in the web interface or refer to the troubleshooting section in [ACCOUNT_GUIDE.md](ACCOUNT_GUIDE.md)
