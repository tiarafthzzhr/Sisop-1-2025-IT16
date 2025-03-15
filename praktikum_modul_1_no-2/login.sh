#!/bin/bash

vault_folder="data"
database_player="$vault_folder/player.csv"

hash_passwd() {
    local password=$1
    echo -n "$password" | sha256sum | cut -d ' ' -f1
}

while true; do
    read -p "Masukkan alamat email anda : " email
    read -p "Masukkan sandi anda : " password

    if ! grep -q ",$email," "$database_player"; then
        echo "Email tidak terdaftar. Silakan register terlebih dahulu."
        continue
    fi

    stored_hash=$(grep ",$email," "$database_player" | cut -d',' -f3)
    input_hash=$(hash_passwd "$password")  

    if [ "$input_hash" = "$stored_hash" ]; then
        username=$(grep ",$email," "$database_player" | cut -d',' -f1)
        echo "Login berhasil! Selamat datang, $username!"
       	#htop
		cd scripts && ./manager.sh
		break
    else
        echo "Password salah. Coba lagi."
        continue
    fi
done
