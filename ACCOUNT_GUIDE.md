# 🔐 Panduan Pembuatan Akun VLESS/Trojan untuk V2Ray

## 📱 Langkah-langkah Pembuatan Akun

### 1. Akses Web Interface
- Buka URL Worker yang sudah di-deploy
- Contoh: `https://your-worker.workers.dev`

### 2. Buat Akun Baru

#### Untuk VLESS:
1. Di section "Create Account", pilih:
   - **Protocol**: VLESS
   - **Host**: Otomatis terisi dengan domain Worker Anda
   - **Port**: 
     - `443` untuk koneksi TLS (HTTPS/WSS) - **Direkomendasikan**
     - `80` untuk koneksi non-TLS (HTTP/WS)
   - **Path**: `/ws` (atau custom path yang Anda inginkan)
   - **Name**: Nama akun (contoh: "Akun VLESS Saya")
   - **Security**: 
     - `TLS` untuk koneksi terenkripsi - **Direkomendasikan**
     - `Non-TLS` untuk koneksi tanpa enkripsi

2. Klik tombol **"Create Account"**

3. Link akun akan muncul secara otomatis dengan format:
   ```
   vless://uuid@host:port?type=ws&security=tls&path=/ws&host=host&sni=host#name
   ```

4. Klik tombol **"Copy Link"** untuk menyalin link

#### Untuk Trojan:
1. Di section "Create Account", pilih:
   - **Protocol**: Trojan
   - **Host**: Otomatis terisi dengan domain Worker Anda
   - **Port**: 
     - `443` untuk TLS - **Direkomendasikan**
     - `80` untuk non-TLS
   - **Path**: `/ws`
   - **Name**: Nama akun (contoh: "Akun Trojan Saya")
   - **Security**: `TLS` atau `Non-TLS`

2. Klik **"Create Account"**

3. Link akan dibuat dengan format:
   ```
   trojan://password@host:port?type=ws&security=tls&path=/ws&host=host&sni=host#name
   ```

4. Klik **"Copy Link"**

### 3. Import ke Aplikasi Client

#### V2RayNG (Android):
1. Buka aplikasi V2RayNG
2. Tap icon **"+"** di kanan atas
3. Pilih **"Import config from clipboard"**
4. Link akan otomatis ter-import
5. Tap akun untuk connect

#### Nekobox (Android):
1. Buka Nekobox
2. Tap **"+"** 
3. Pilih **"Import from clipboard"**
4. Akun akan muncul di list
5. Tap untuk connect

#### V2RayN (Windows):
1. Buka V2RayN
2. Klik **"Servers"** → **"Import URL from clipboard"**
3. Akun akan ditambahkan
4. Klik kanan akun → **"Set as active server"**
5. Klik **"Start V2Ray"**

#### Shadowrocket (iOS):
1. Buka Shadowrocket
2. Tap **"+"** di kanan atas
3. Pilih **"Import"** atau paste link langsung
4. Tap untuk connect

## 🔄 Format Link

### VLESS dengan TLS (Direkomendasikan):
```
vless://[UUID]@your-worker.workers.dev:443?type=ws&security=tls&path=/ws&host=your-worker.workers.dev&sni=your-worker.workers.dev#AccountName
```

**Komponen:**
- `UUID`: Identifier unik untuk autentikasi
- `host`: Domain Worker Cloudflare Anda
- `port`: 443 (HTTPS/WSS dengan TLS)
- `type`: ws (WebSocket)
- `security`: tls (koneksi terenkripsi)
- `path`: /ws (WebSocket path)
- `sni`: Server Name Indication untuk TLS

### VLESS tanpa TLS:
```
vless://[UUID]@your-worker.workers.dev:80?type=ws&security=none&path=/ws&host=your-worker.workers.dev#AccountName
```

**Komponen:**
- `port`: 80 (HTTP/WS tanpa TLS)
- `security`: none (tidak terenkripsi)

### Trojan dengan TLS (Direkomendasikan):
```
trojan://[PASSWORD]@your-worker.workers.dev:443?type=ws&security=tls&path=/ws&host=your-worker.workers.dev&sni=your-worker.workers.dev#AccountName
```

**Komponen:**
- `PASSWORD`: Password 32 karakter yang di-generate otomatis
- `host`: Domain Worker Anda
- `port`: 443 (TLS)
- `security`: tls

### Trojan tanpa TLS:
```
trojan://[PASSWORD]@your-worker.workers.dev:80?type=ws&security=none&path=/ws&host=your-worker.workers.dev#AccountName
```

## ✅ Verifikasi Koneksi

### Di Client:
1. Setelah import link, pilih/aktifkan konfigurasi
2. Connect/start VPN
3. Buka browser dan cek IP Anda
4. Tes akses website yang diblokir

### Di Web Interface:
1. Buka dashboard Worker
2. Lihat **"Active Connections"** untuk melihat koneksi aktif
3. Monitor **"Total Requests"** dan **"Success Rate"**

## 🔧 Troubleshooting

### ❌ Koneksi Gagal

**Problem**: Client tidak bisa connect

**Solusi:**
- ✅ Pastikan Worker sudah di-deploy dan bisa diakses
- ✅ Cek domain/host sudah benar
- ✅ Port harus sesuai dengan security:
  - Port 443 = TLS
  - Port 80 = Non-TLS
- ✅ Pastikan path benar (default: `/ws`)
- ✅ Link harus di-copy lengkap tanpa ada yang terpotong

### ❌ TLS Handshake Failed

**Problem**: Error saat TLS handshake

**Solusi:**
- ✅ Gunakan security `TLS` untuk port 443
- ✅ Gunakan security `none` untuk port 80
- ✅ Pastikan SNI sama dengan host domain
- ✅ Jangan mix TLS dengan non-TLS port

### ❌ Authentication Failed

**Problem**: Autentikasi gagal

**Solusi:**
- ✅ Generate ulang akun jika UUID/password berubah
- ✅ Copy link baru yang ter-generate
- ✅ Hapus konfigurasi lama di client
- ✅ Import ulang dengan link yang baru

### ❌ Connection Timeout

**Problem**: Koneksi timeout

**Solusi:**
- ✅ Cek koneksi internet Anda
- ✅ Coba ganti DNS ke 8.8.8.8 atau 1.1.1.1
- ✅ Pastikan Worker tidak di-rate limit
- ✅ Coba protocol lain (VLESS ↔ Trojan)

## 🎯 Tips & Best Practices

### Keamanan:
1. ✅ **Gunakan TLS** untuk enkripsi end-to-end
2. ✅ **Port 443** lebih sulit dideteksi karena terlihat seperti traffic HTTPS biasa
3. ✅ **Custom path** (selain `/ws`) untuk menghindari deteksi
4. ✅ **Unique account names** untuk mudah dikelola

### Performa:
1. ✅ **VLESS lebih ringan** daripada Trojan (overhead lebih kecil)
2. ✅ **WebSocket (WS)** lebih kompatibel dengan CDN dan proxy
3. ✅ **TLS** menambah sedikit latency tapi lebih aman
4. ✅ Monitor **Success Rate** di dashboard untuk cek performa

### Multi-Device:
1. ✅ Buat akun terpisah untuk setiap device
2. ✅ Gunakan nama yang jelas (contoh: "Android-Phone", "Laptop-Home")
3. ✅ Bisa create multiple accounts dengan setting berbeda
4. ✅ Mudah track mana yang aktif digunakan

## 📊 Manajemen Akun

### Melihat Semua Akun:
1. Klik tombol **"Show All Accounts"**
2. Semua akun yang pernah dibuat akan ditampilkan
3. Setiap akun menampilkan:
   - Protocol dan security
   - Host dan port
   - UUID/Password
   - Link lengkap yang bisa di-copy
   - Tombol delete

### Menghapus Akun:
1. Di card akun, klik tombol **"Delete"**
2. Konfirmasi penghapusan
3. Akun akan dihapus dari daftar
4. Client yang menggunakan akun tersebut tidak akan bisa connect lagi

### Export/Backup Akun:
1. Copy link dari setiap akun
2. Simpan di tempat aman (notes, password manager)
3. Link bisa digunakan kapan saja untuk import ulang
4. Bisa share ke device/orang lain jika diperlukan

## 🌐 Aplikasi Client yang Didukung

| Platform | Aplikasi | Status | Download |
|----------|----------|--------|----------|
| Android | V2RayNG | ✅ Tested | [Google Play](https://play.google.com/store/apps/details?id=com.v2ray.ang) |
| Android | Nekobox | ✅ Tested | [GitHub](https://github.com/MatsuriDayo/NekoBoxForAndroid) |
| Android | SagerNet | ✅ Compatible | [GitHub](https://github.com/SagerNet/SagerNet) |
| iOS | Shadowrocket | ✅ Tested | [App Store](https://apps.apple.com/app/shadowrocket/id932747118) |
| iOS | Quantumult X | ✅ Compatible | [App Store](https://apps.apple.com/app/quantumult-x/id1443988620) |
| Windows | V2RayN | ✅ Tested | [GitHub](https://github.com/2dust/v2rayN) |
| Windows | Clash Verge | ✅ Compatible | [GitHub](https://github.com/zzzgydi/clash-verge) |
| macOS | V2RayX | ✅ Tested | [GitHub](https://github.com/Cenmrev/V2RayX) |
| macOS | ClashX | ✅ Compatible | [GitHub](https://github.com/yichengchen/clashX) |
| Linux | v2ray-core | ✅ Tested | [v2fly.org](https://www.v2fly.org/) |
| Linux | Qv2ray | ✅ Tested | [GitHub](https://github.com/Qv2ray/Qv2ray) |

## 📞 Support

Jika mengalami masalah:
1. Cek bagian **Troubleshooting** di atas
2. Lihat **AI Error Handler** di dashboard untuk analisis otomatis
3. Monitor **System Logs** untuk detail error
4. Coba generate ulang akun dengan setting berbeda

---

**Note**: Link yang di-generate sudah dalam format yang benar dan siap digunakan di semua aplikasi V2Ray client yang kompatibel. Pastikan untuk meng-copy link secara lengkap!
