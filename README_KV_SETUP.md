# 🚨 PENTING: Setup KV Namespace Sebelum Deploy!

## Masalah: Tidak Bisa Buat Akun

Jika worker sudah berhasil deploy tapi TIDAK BISA membuat akun (tidak ada respon sama sekali), ini dikarenakan **KV namespace belum di-setup**.

Akun disimpan di Cloudflare KV untuk persistence. Tanpa setup KV, akun akan hilang setiap kali worker restart.

## Cara Memperbaiki: 3 Langkah Sederhana

### Langkah 1: Setup KV Namespace

Buka terminal dan jalankan:

```bash
cd /home/engine/project
./setup-kv.sh
```

**Output akan seperti ini:**

```
🌀 creating namespace with title "worker-AUTHORIZATION_KEY_ACCOUNTS_KV"
✨ Success! Add the following to your configuration file in your kv_namespaces array:
{ binding = "ACCOUNTS_KV", id = "abc123def456..." }

🌀 creating namespace with title "worker-AUTHORIZATION_KEY_ACCOUNTS_KV_preview"
✨ Success! Add the following to your configuration file in your kv_namespaces array:
{ binding = "ACCOUNTS_KV", preview_id = "xyz789uvw012..." }
```

### Langkah 2: Update wrangler.toml

Buka file `wrangler.toml` dan update bagian KV namespace dengan ID dari output di atas:

```toml
# wrangler.toml

# KV namespace for persistent account storage
[[kv_namespaces]]
binding = "ACCOUNTS_KV"
id = "abc123def456..."        # GANTI dengan ID production dari Langkah 1
preview_id = "xyz789uvw012..." # GANTI dengan ID preview dari Langkah 1
```

Contoh yang sudah benar:

```toml
[[kv_namespaces]]
binding = "ACCOUNTS_KV"
id = "c3b5a9e2d1f4g6h8i7j0k9l2m4n6o8p1q3r5"
preview_id = "s7t9u2v4w1x6y3z8a5b2c9d0e1f4g7h0i2"
```

### Langkah 3: Deploy Worker

Setelah update wrangler.toml, deploy ulang worker:

```bash
wrangler deploy
```

Atau gunakan script deploy:

```bash
./deploy.sh
```

## Cara Cek Apakah Setup Benar

### Cek KV Namespace

```bash
wrangler kv:namespace list
```

Harus melihat KV namespace dengan binding "ACCOUNTS_KV".

### Cek Worker Deployed

```bash
curl https://worker-anda.workers.dev/api/status
```

Harus mendapat response JSON:

```json
{
  "status": "active",
  "totalRequests": 0,
  "successRate": "100%",
  "uptime": 0
}
```

## Cara Membuat Akun (Setelah Setup Selesai)

1. Buka URL worker di browser:
   ```
   https://worker-anda.workers.dev
   ```

2. Isi form pembuatan akun:
   - **Protocol**: Pilih VLESS atau Trojan
   - **Host**: Sudah auto-filled dengan domain worker Anda
   - **Port**: 443 (default untuk HTTPS)
   - **Path**: /ws (default)
   - **Account Name**: Nama bebas apa saja
   - **Security**: TLS (direkomendasikan) atau None

3. Klik tombol **Create Account** ✓

4. Akun akan muncul di bawah dengan:
   - UUID atau Password
   - Share link untuk copy
   - Tombol Copy Link

5. Copy link dan import ke aplikasi V2Ray (V2RayNG, Nekobox, Shadowrocket, dll)

## Troubleshooting

### Masalah 1: Setup KV Error

**Error:**
```
Error: No account found. Are you logged in?
```

**Solusi:**
```bash
wrangler login
# Ikuti instruksi di browser
# Setelah login, ulangi Langkah 1
```

### Masalah 2: wrangler.toml Tidak Terupdate

**Error:**
```
Error: KV namespace not found
```

**Solusi:**
- Pastikan wrangler.toml sudah di-update dengan ID yang benar
- Hapus spasi tambahan
- Pastikan format TOML benar (gunakan = bukan :)
- Cek ulang: sudah ada `[[kv_namespaces]]` di file?

### Masalah 3: Masih Tidak Bisa Buat Akun Setelah Deploy

**Cek logs worker:**
```bash
wrangler tail
```

Buka browser, coba buat akun, dan lihat di terminal:

**Jika melihat:**
```
[AccountManager] Failed to load from KV: ...
[AccountManager] Failed to save to KV: ...
```

Artinya: KV binding tidak benar. Cek wrangler.toml lagi.

**Jika melihat:**
```
[ProxyWS] Connection received for account...
[AccountManager] Saved 1 accounts to KV
```

Artinya: **Setup benar!** Masalah mungkin di browser. Clear cache dan refresh.

### Masalah 4: Akun Dibuat Tapi Tidak Bisa Connect di V2Ray

**Cek format link:**
- VLESS: `vless://UUID@HOST:PORT?type=ws&security=tls&path=/ws&host=HOST#NAME`
- Trojan: `trojan://PASSWORD@HOST:PORT?type=ws&security=tls&path=/ws&host=HOST#NAME`

**Test koneksi WebSocket:**
```bash
curl -i -N \
  -H "Connection: Upgrade" \
  -H "Upgrade: websocket" \
  -H "Sec-WebSocket-Key: test" \
  -H "Sec-WebSocket-Version: 13" \
  https://worker-anda.workers.dev/ws
```

Response harus: `HTTP/1.1 101 Switching Protocols`

## Catatan Penting

1. **Wajib Setup KV**: Tanpa KV, akun TIDAK AKAN tersimpan
2. **ID Unik**: Setiap kali setup KV, ID akan berbeda. Update wrangler.toml dengan ID baru setiap kali setup ulang
3. **Deployment Pertama**: Akun dari deployment sebelumnya akan hilang (perlu dibuat ulang)
4. **Multiple Accounts**: Bisa membuat banyak akun dengan path berbeda
5. **Path Matching**: Path di link harus sama persis dengan path di akun

## Dokumentasi Tambahan

- **SETUP_GUIDE.md**: Panduan setup lengkap (Bahasa Inggris)
- **TROUBLESHOOTING.md**: Panduan troubleshooting detail
- **FIXES_APPLIED.md**: Dokumentasi perbaikan yang dilakukan
- **ACCOUNT_GUIDE.md**: Panduan membuat dan menggunakan akun (Bahasa Indonesia)

## Support

Jika masih mengalami masalah:

1. Cek log real-time: `wrangler tail`
2. Cek status KV: `wrangler kv:namespace list`
3. Cek health worker: `curl https://worker-anda.workers.dev/api/status`
4. Buka browser DevTools (F12) dan lihat Console tab saat buat akun
5. Pastikan semua field form terisi dengan benar

## Ringkasan

✅ Worker sudah fix dan siap digunakan
✅ Account creation berfungsi dengan baik
✅ WebSocket handler sudah implement
✅ KV storage sudah terintegrasi

🔔 TAPI: User WAJIB setup KV namespace dulu!

IKUTI 3 LANGKAH DI ATAS untuk memperbaiki masalah.
