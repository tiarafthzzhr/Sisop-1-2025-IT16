#!/bin/bash

printf "  __    ____   ___    __    ____    __                           \n"
printf " /__\  (  _ \ / __)  /__\  ( ___)  /__\                         \n"
printf "/(__)\  )   /( (__  /(__)\  )__)  /(__)\                        \n"
printf "(__)(__)(_)\_) \___)(__)(__)(____)(__)(__)                      \n"
printf "\n"
printf "      ╔══════════════════════════════╗\n"
printf "      ║        ARCAEA TERMINAL        ║\n"
printf "      ╚══════════════════════════════╝\n"
printf "┌──────────────────────────────────────┐\n"
printf "│ %-2s | %-30s │\n" "ID" "OPTION"
printf "├──────────────────────────────────────┤\n"
printf "│ %-2s | %-30s │\n" "1" "Register New Account"
printf "│ %-2s | %-30s │\n" "2" "Login to Existing Account"
printf "│ %-2s | %-30s │\n" "3" "Exit Arcaea Terminal"
printf "└──────────────────────────────────────┘\n"


vault_folder="data"
database_player="$vault_folder/player.csv"

# Buat direktori jika belum ada
#sudo mkdir -p "$vault_folder" && sudo touch "$database_player"

#Buat header
if [ ! -f "$database_player" ]; then
    echo "Username,Email,Hashed_passwd" > "$database_player"
fi


validasi_email() {
    local email=$1

    # Pisahkan email berdasarkan karakter "@"
    IFS="@" read -r username domain <<< "$email"

    # Periksa apakah email memiliki tepat satu karakter "@"
    if [ -z "$username" ] || [ -z "$domain" ]; then
        echo -e "\nFormat email tidak valid!"
        return 1
    fi

    # Opsional: Periksa apakah domain mengandung titik (.)
    if [[ "$domain" != *.* ]]; then
        echo -e "\nDomain tidak valid (harus mengandung titik)!"
        return 1
    fi

    return 0  # Email valid
}
validasi_passwd() {
    local password=$1
    local error=()

    if [[ ${#password} -lt 8 ]]; then
        error+="Password harus berisikan minimal 8 karakter !"
    fi

    if [[ ! "$password" =~ [A-Z] ]]; then 
        error+="Password minimal memiliki 1 huruf besar !"
    fi

    if [[ ! "$password" =~ [a-z] ]]; then
        error+="Password minimal memiliki 1 huruf kecil !"
    fi

    if [[ ! "$password" =~ [0-9] ]]; then
        error+="Password minimal memiliki 1 angka !"
    fi

    if [ ${#error[@]} -gt 0 ]; then
        echo -e "Password yang anda buat tidak memenuhi kriteria : "
        printf -- "-- %s\n" "${error[@]}"
        return 1
    fi

    return 0
}
hashing_passwd() {
    local password=$1
    echo -n "$password" | sha256sum | cut -d ' ' -f1
}

while true; do
read -p "Masukkan pilihan [1-3] : " option

case $option in
"1")
	echo "Resigter new account"
	read -p "Masukkan username anda	: " username
	read -p "Masukkan alamt email anda: " email
	read -p "Masukkan password dari alamat email anda: " password


	if ! validasi_email "$email"; then
            echo "Email tidak valid. Coba ulang."
            continue
        fi
	#if grep -q ",$email," ",$database_player"; then
	  if grep -q ",$email," "$database_player"; then
            echo "Alamat email sudah terdaftar, silahkan gunakan format yang lain"
            continue
        fi
        if ! validasi_passwd "$password"; then
            echo "Password tidak memenuhi kriteria. Coba ulang."
            continue
        fi
        hashed_passwd=$(hashing_passwd "$password")
        echo "$username,$email,$hashed_passwd" >> "$database_player"
        echo "Akun berhasil didaftarkan!"
        break
        ;;
"2")
	echo "Masuk ke dalam sistem login"
	./login.sh
	;;	
    "3")
        echo "Exiting terminal....."
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Pilihan tidak ada dalam list, silahkan coba lagi!"
        continue
        ;;
    esac
done


