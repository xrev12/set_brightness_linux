#!/bin/bash

# 1. Ambil nilai kecerahan monitor saat ini tanpa sudo
CURRENT_BRIGHTNESS=$(ddcutil getvcp 0x10 | grep -oP 'current value =\s*\K[0-9]+')

# Jika gagal membaca nilai monitor, berikan nilai default 60
if [ -z "$CURRENT_BRIGHTNESS" ]; then
    CURRENT_BRIGHTNESS=60
fi

# 2. Fungsi pembantu untuk mencentang (TRUE) otomatis sesuai kecerahan saat ini
get_status() {
    TARGET_VAL=$1
    # Membulatkan nilai ke kelipatan 10 terdekat (misal: 58 jadi 60)
    ROUNDED_VAL=$(( (CURRENT_BRIGHTNESS + 5) / 10 * 10 ))
    
    if [ "$ROUNDED_VAL" -eq "$TARGET_VAL" ]; then
        echo "TRUE"
    else
        echo "FALSE"
    fi
}

# 3. Tampilkan menu Zenity dengan opsi centang dinamis
CHOICE=$(zenity --list --title="Monitor Brightness" --text="Kecerahan saat ini: ${CURRENT_BRIGHTNESS}%\nPilih tingkat kecerahan:" --radiolist --column="Pilih" --column="Kecerahan" \
  $(get_status 10) "10%" \
  $(get_status 20) "20%" \
  $(get_status 30) "30%" \
  $(get_status 40) "40%" \
  $(get_status 50) "50%" \
  $(get_status 60) "60%" \
  $(get_status 70) "70%" \
  $(get_status 80) "80%" \
  $(get_status 90) "90%" \
  $(get_status 100) "100%")

# Jika membatalkan atau menutup jendela, keluar dengan aman
if [ -z "$CHOICE" ]; then
    exit 0
fi

# 4. Hapus karakter '%' agar menjadi angka murni (contoh: "10%" menjadi "10")
VALUE=$(echo "$CHOICE" | sed 's/%//')

# 5. Eksekusi perubahan kecerahan langsung menggunakan ddcutil tanpa sudo
echo "Mengubah kecerahan dari ${CURRENT_BRIGHTNESS}% menjadi ${VALUE}%..."
ddcutil setvcp 0x10 "$VALUE"

# Tampilkan hasil verifikasi di terminal
ddcutil getvcp 0x10
