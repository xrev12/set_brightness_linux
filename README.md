# set_brightness_linux
script ini berfungsi untuk mengatur kecerahan monitor
# Monitor Brightness Controller (Zenity + ddcutil)

Skrip Bash sederhana untuk mengubah kecerahan monitor eksternal secara grafis menggunakan menu dropdown **Zenity** dan backend **ddcutil** tanpa menggunakan akses `sudo`. Skrip ini otomatis membaca tingkat kecerahan monitor Anda saat ini dan mencentang opsi yang sesuai.

## Fitur
- Berjalan tanpa `sudo` (lebih aman).
- Menu GUI dropdown yang ringan menggunakan Zenity.
- Otomatis mendeteksi tingkat kecerahan monitor saat ini saat dibuka.

## Prasyarat
Pastikan sistem Linux Anda sudah terinstal utilitas yang dibutuhkan:
```bash
sudo apt install ddcutil zenity i2c-tools
```

### Konfigurasi Tanpa Sudo
Agar skrip bisa membaca monitor tanpa `sudo`, masukkan pengguna (user) Anda ke dalam grup `i2c`:
```bash
sudo usermod -aG i2c \$USER
```
*Catatan: Anda **wajib melakukan restart/reboot** komputer setelah menjalankan perintah di atas agar efeknya aktif.*

## Cara Penggunaan
1. Berikan izin eksekusi pada skrip:
   ```bash
   chmod +x brightness.sh
   ```
2. Jalankan skrip:
   ```bash
   ./brightness.sh
   ```
